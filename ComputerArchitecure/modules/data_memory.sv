module data_memory (
    input clk,
    input rst,
    input [31:0] A,
    input [31:0] WD,
    input WE,
    output [31:0] RD

);
  reg [31:0] memory[1023:0];
  always @(posedge clk) begin
    if (WE) mem[A] <= WD;
  end
  assign RD = (~rst) ? 32'd0 : mem[A];



endmodule
