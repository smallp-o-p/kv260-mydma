// xpm_memory_sdpram_sim.v - SIMULATION-ONLY stand-in for AMD's XPM macro, so
// testbenches that instantiate xpm_memory_sdpram run in Icarus/Verilator.
// Never add this to a Vivado project: Vivado has the real macro built in.
//
// Covers what activation_buffer uses: common clock, no ECC, word-wide
// writes, READ_LATENCY_B >= 1 (data valid READ_LATENCY_B edges after enb).
// Other parameters are accepted and ignored.
`timescale 1ns / 1ps

module xpm_memory_sdpram #(
    parameter ADDR_WIDTH_A = 6,  parameter ADDR_WIDTH_B = 6,
    parameter AUTO_SLEEP_TIME = 0, parameter BYTE_WRITE_WIDTH_A = 32,
    parameter CASCADE_HEIGHT = 0, parameter CLOCKING_MODE = "common_clock",
    parameter ECC_BIT_RANGE = "7:0", parameter ECC_MODE = "no_ecc", parameter ECC_TYPE = "none",
    parameter IGNORE_INIT_SYNTH = 0, parameter MEMORY_INIT_FILE = "none",
    parameter MEMORY_INIT_PARAM = "0", parameter MEMORY_OPTIMIZATION = "true",
    parameter MEMORY_PRIMITIVE = "auto", parameter MEMORY_SIZE = 2048,
    parameter MESSAGE_CONTROL = 0, parameter RAM_DECOMP = "auto",
    parameter READ_DATA_WIDTH_B = 32, parameter READ_LATENCY_B = 2,
    parameter READ_RESET_VALUE_B = "0", parameter RST_MODE_A = "SYNC", parameter RST_MODE_B = "SYNC",
    parameter SIM_ASSERT_CHK = 0, parameter USE_EMBEDDED_CONSTRAINT = 0,
    parameter USE_MEM_INIT = 1, parameter USE_MEM_INIT_MMI = 0,
    parameter WAKEUP_TIME = "disable_sleep", parameter WRITE_DATA_WIDTH_A = 32,
    parameter WRITE_MODE_B = "no_change", parameter WRITE_PROTECT = 1
)(
    input  wire                          sleep,
    input  wire                          clka,
    input  wire                          ena,
    input  wire [WRITE_DATA_WIDTH_A/BYTE_WRITE_WIDTH_A-1:0] wea,
    input  wire [ADDR_WIDTH_A-1:0]       addra,
    input  wire [WRITE_DATA_WIDTH_A-1:0] dina,
    input  wire                          injectsbiterra,
    input  wire                          injectdbiterra,
    input  wire                          clkb,
    input  wire                          rstb,
    input  wire                          enb,
    input  wire                          regceb,
    input  wire [ADDR_WIDTH_B-1:0]       addrb,
    output wire [READ_DATA_WIDTH_B-1:0]  doutb,
    output wire                          sbiterrb,
    output wire                          dbiterrb
);
    localparam DEPTH = MEMORY_SIZE / WRITE_DATA_WIDTH_A;
    reg [WRITE_DATA_WIDTH_A-1:0] mem [0:DEPTH-1];
    reg [READ_DATA_WIDTH_B-1:0]  q   [0:READ_LATENCY_B-1];
    integer i;

    always @(posedge clka) begin
        if (ena && wea[0] && addra < DEPTH)
            mem[addra] <= dina;
        if (enb)
            q[0] <= (addrb < DEPTH) ? mem[addrb] : {READ_DATA_WIDTH_B{1'bx}};
        for (i = 1; i < READ_LATENCY_B; i = i + 1)
            if (i < READ_LATENCY_B - 1 || regceb)
                q[i] <= q[i-1];
    end
    assign doutb    = q[READ_LATENCY_B-1];
    assign sbiterrb = 1'b0;
    assign dbiterrb = 1'b0;
endmodule
