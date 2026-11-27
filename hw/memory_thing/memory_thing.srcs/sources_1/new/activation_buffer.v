`timescale 1ns / 1ps

module activation_buffer #(
    parameter MAX_ENTRIES = 3072,
    parameter AXI_STREAM_DATA_BITS = 128,
    parameter ADDR_WIDTH = 12,
    parameter READ_LATENCY = 2
)(
    (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 aclk CLK" *)
    (* X_INTERFACE_PARAMETER = "ASSOCIATED_BUSIF s_act, ASSOCIATED_RESET aresetn" *)
    input wire          aclk,
    (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 aresetn RST" *)
    (* X_INTERFACE_PARAMETER = "POLARITY ACTIVE_LOW" *)
    input wire          aresetn,
    
    (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_act TDATA" *)
    input wire[127:0]   s_act_tdata,
    (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_act TKEEP" *)
    input wire[15:0]    s_act_tkeep,
    (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_act TLAST" *)
    input wire          s_act_tlast,
    (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_act TVALID" *)
    input wire          s_act_tvalid,
    (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_act TREADY" *)
    output wire         s_act_tready,
    
    input wire          rd_en,
    input wire[ADDR_WIDTH - 1:0]    rd_addr,
    output wire[AXI_STREAM_DATA_BITS - 1:0]  rd_data,
    output wire         rd_valid,
        
    output reg          loaded,
    output reg[ADDR_WIDTH - 1:0]    beat_count,
    input wire          rel
);

wire beat = s_act_tvalid && s_act_tready;
reg[ADDR_WIDTH - 1:0]    wptr = 0;

// xpm_memory_sdpram: Simple Dual Port RAM
// Xilinx Parameterized Macro, version 2026.2
xpm_memory_sdpram #(
  .ADDR_WIDTH_A(ADDR_WIDTH),               // DECIMAL
  .ADDR_WIDTH_B(ADDR_WIDTH),               // DECIMAL
  .AUTO_SLEEP_TIME(0),            // DECIMAL
  .BYTE_WRITE_WIDTH_A(AXI_STREAM_DATA_BITS),        // DECIMAL
  .CASCADE_HEIGHT(0),             // DECIMAL
  .CLOCKING_MODE("common_clock"), // String
  .ECC_MODE("no_ecc"),            // String
  .MEMORY_INIT_FILE("none"),      // String
  .MEMORY_INIT_PARAM("0"),        // String
  .MEMORY_OPTIMIZATION("true"),   // String
  .MEMORY_PRIMITIVE("block"),      // String
  .MEMORY_SIZE(AXI_STREAM_DATA_BITS * MAX_ENTRIES),             // DECIMAL
  .MESSAGE_CONTROL(0),            // DECIMAL
  .READ_DATA_WIDTH_B(AXI_STREAM_DATA_BITS),         // DECIMAL
  .READ_LATENCY_B(READ_LATENCY),             // DECIMAL
  .READ_RESET_VALUE_B("0"),       // String
  .RST_MODE_A("SYNC"),            // String
  .RST_MODE_B("SYNC"),            // String
  .SIM_ASSERT_CHK(0),             // DECIMAL; 0=disable simulation messages, 1=enable simulation messages
  .USE_EMBEDDED_CONSTRAINT(0),    // DECIMAL
  .USE_MEM_INIT(0),               // DECIMAL
  .WAKEUP_TIME("disable_sleep"),  // String
  .WRITE_DATA_WIDTH_A(AXI_STREAM_DATA_BITS),        // DECIMAL
  .WRITE_MODE_B("no_change"),     // String
  .WRITE_PROTECT(1)               // DECIMAL
)
u_mem (
  .sleep(1'b0), // 1-bit input: sleep signal to enable the dynamic power saving feature.
  .clka(aclk), // 1-bit input: Clock signal for port A. Also clocks port B when parameter CLOCKING_MODE is "common_clock".
  .ena(1'b1), // 1-bit input: Memory enable signal for port A. Must be high on the clock cycles when you initiate write operations. Pipelined internally.
  .wea(beat && (wptr < MAX_ENTRIES)), // WRITE_DATA_WIDTH_A/BYTE_WRITE_WIDTH_A-bit input: Write enable vector for port A input data port dina. 1 bit
                                            // wide for word-wide writes. In byte-wide write configurations, each bit controls the writing one byte of
                                            // dina to address addra. For example, to synchronously write only bits [15-8] of dina when WRITE_DATA_WIDTH_A
                                    // is 32, wea is 4'b0010.
  .addra(wptr), // ADDR_WIDTH_A-bit input: Address for port A write operations.
  .dina(s_act_tdata), // WRITE_DATA_WIDTH_A-bit input: Data input for port A write operations.
  .injectsbiterra(1'b0), // 1-bit input: Controls single bit error injection on input data when ECC enabled (Error injection capability
                                    // is not available in "decode_only" mode).                        
  .injectdbiterra(1'b0), // 1-bit input: Controls double bit error injection on input data when ECC enabled (Error injection capability
                                    // is not available in "decode_only" mode).
  .clkb(aclk), // 1-bit input: Clock signal for port B when parameter CLOCKING_MODE is "independent_clock". Unused when
                                    // parameter CLOCKING_MODE is "common_clock".
  .rstb(1'b0), // 1-bit input: Reset signal for the final port B output register stage. Synchronously resets output port
                                    // doutb to the value specified by parameter READ_RESET_VALUE_B.
  .enb(rd_en), // 1-bit input: Memory enable signal for port B. Must be high on the clock cycles when you initiate read
                                    // operations. Pipelined internally.
  .regceb(1'b1),
  .addrb(rd_addr), // ADDR_WIDTH_B-bit input: Address for port B read operations.
  .doutb(rd_data), // READ_DATA_WIDTH_B-bit output: Data output for port B read operations.
  .sbiterrb(), // 1-bit output: Status signal to indicate single bit error occurrence on the data output of port B.
  .dbiterrb() // 1-bit output: Status signal to indicate double bit error occurrence on the data output of port B.
);

reg [READ_LATENCY - 1:0] vpipe;

    always @(posedge aclk) begin
        if(!aresetn) begin
            wptr <= 0;
            loaded <= 1'b0;
            beat_count <= 0;
        end else if(rel) begin
            loaded <= 1'b0;
        end else if (beat) begin
            if(s_act_tlast) begin
                loaded <= 1'b1;
                wptr <= 0;
                beat_count <= (wptr < MAX_ENTRIES) ? wptr + 1 : MAX_ENTRIES;
            end else if(wptr < MAX_ENTRIES) begin
                wptr <= wptr + 1;
            end
        end
    end
    always @(posedge aclk) begin
        if(!aresetn) begin
            vpipe <= 0;       
        end else begin
            vpipe = (vpipe << 1) | rd_en;
            
        end
    end
    
    assign rd_valid = vpipe[READ_LATENCY-1];
    assign s_act_tready = !loaded;
endmodule
