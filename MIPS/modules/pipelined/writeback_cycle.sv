module writeback_cycle (
    input clk,
    rst,
    input MemtoRegW,
    input [31:0] ALUOutW,
    input [31:0] ReadDataW,
    output [31:0] ResultW
);

  assign ResultW = (MemtoRegW == 1) ? ReadDataW : ALUOutW;

endmodule
