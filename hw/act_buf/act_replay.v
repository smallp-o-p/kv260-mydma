// act_replay.v - TEMPORARY test reader for activation_buffer.v.
//
// Stands in for the array's controller until the array exists:
//
//   axi_dma_4 MM2S --> activation_buffer --rd_*--> act_replay --m_axis--> lane_checker s_act
//
// When the buffer reports `loaded`, this block reads words 0 .. beat_count-1
// once, sends them out on m_axis (TLAST on the last word), then pulses `rel`
// so the buffer takes the next load. lane_checker then returns the XOR and
// beat count of what came out of the BRAM, so bwtest's existing activation
// check ("activation path ... OK") proves the whole write/read path.
// Delete this block when the controller arrives; it drives the same pins.
//
// Back-pressure: the RAM answers READ_LATENCY cycles after rd_en, so words
// already requested keep arriving after m_axis_tready drops. They land in a
// small FIFO (FIFO_DEPTH words). A read is only issued while
//     words requested - words sent < FIFO_DEPTH
// so the FIFO can never overflow. With FIFO_DEPTH >= READ_LATENCY + 2 it
// still runs at one word per clock. Correctness doesn't depend on the
// latency, only the throughput does.
//
// Pins to activation_buffer (same names, opposite directions):
//   loaded, beat_count  in    rd_en, rd_addr, rel   out    rd_data, rd_valid  in
`timescale 1ns / 1ps

module act_replay #(
    parameter DATA_WIDTH   = 128,
    parameter ADDR_WIDTH   = 12,
    parameter FIFO_DEPTH   = 4     // power of 2; >= the buffer's READ_LATENCY + 2 for full rate
)(
    (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 aclk CLK" *)
    (* X_INTERFACE_PARAMETER = "ASSOCIATED_BUSIF m_axis, ASSOCIATED_RESET aresetn" *)
    input  wire                    aclk,
    (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 aresetn RST" *)
    (* X_INTERFACE_PARAMETER = "POLARITY ACTIVE_LOW" *)
    input  wire                    aresetn,

    // ---- to/from activation_buffer ----
    input  wire                    loaded,
    input  wire [ADDR_WIDTH-1:0]   beat_count,
    output reg                     rel,
    output wire                    rd_en,
    output reg  [ADDR_WIDTH-1:0]   rd_addr,
    input  wire [DATA_WIDTH-1:0]   rd_data,
    input  wire                    rd_valid,

    // ---- AXI4-Stream master: the buffer's contents, one packet per load ----
    (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m_axis TDATA" *)
    output wire [DATA_WIDTH-1:0]   m_axis_tdata,
    (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m_axis TKEEP" *)
    output wire [DATA_WIDTH/8-1:0] m_axis_tkeep,
    (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m_axis TLAST" *)
    output wire                    m_axis_tlast,
    (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m_axis TVALID" *)
    output wire                    m_axis_tvalid,
    (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m_axis TREADY" *)
    input  wire                    m_axis_tready
);
    localparam FW = $clog2(FIFO_DEPTH);

    // ------------------------------------------------------------------
    // Control
    //   active      : replaying the current load
    //   rd_addr     : next address to request (0 .. beat_count)
    //   sent        : words sent on m_axis so far
    //   outstanding : requested but not yet sent (in the RAM pipe + FIFO)
    // ------------------------------------------------------------------
    reg              active;
    reg [ADDR_WIDTH:0] sent;
    reg [FW:0]       outstanding;

    wire more_to_read = ({1'b0, rd_addr} < {1'b0, beat_count});
    assign rd_en      = active && more_to_read && (outstanding < FIFO_DEPTH);

    wire out_beat  = m_axis_tvalid && m_axis_tready;
    wire last_beat = out_beat && (sent == {1'b0, beat_count} - 1'b1);

    always @(posedge aclk) begin
        if (!aresetn) begin
            active      <= 1'b0;
            rel         <= 1'b0;
            rd_addr     <= 0;
            sent        <= 0;
            outstanding <= 0;
        end else begin
            rel <= 1'b0;                                   // 1-cycle pulse

            // Start on a fresh load. !rel: in the cycle rel is high the
            // buffer still shows loaded = 1, so don't restart on it.
            if (!active && loaded && !rel) begin
                active  <= 1'b1;
                rd_addr <= 0;
                sent    <= 0;
            end

            if (rd_en)
                rd_addr <= rd_addr + 1'b1;
            if (out_beat)
                sent <= sent + 1'b1;
            outstanding <= outstanding + {{FW{1'b0}}, rd_en} - {{FW{1'b0}}, out_beat};

            if (last_beat) begin                           // all sent: hand it back
                active <= 1'b0;
                rel    <= 1'b1;
            end
        end
    end

    // ------------------------------------------------------------------
    // FIFO for words returning from the RAM
    // ------------------------------------------------------------------
    reg [DATA_WIDTH-1:0] fifo [0:FIFO_DEPTH-1];
    reg [FW-1:0]         wp, rp;
    reg [FW:0]           count;

    always @(posedge aclk) begin
        if (rd_valid)
            fifo[wp] <= rd_data;
    end

    always @(posedge aclk) begin
        if (!aresetn) begin
            wp    <= 0;
            rp    <= 0;
            count <= 0;
        end else begin
            if (rd_valid) wp <= wp + 1'b1;
            if (out_beat) rp <= rp + 1'b1;
            count <= count + {{FW{1'b0}}, rd_valid} - {{FW{1'b0}}, out_beat};
        end
    end

    assign m_axis_tvalid = (count != 0);
    assign m_axis_tdata  = fifo[rp];
    assign m_axis_tkeep  = {DATA_WIDTH/8{1'b1}};
    assign m_axis_tlast  = (sent == {1'b0, beat_count} - 1'b1);
endmodule
