module data_memory (
    input clk,
    input rst,
    input [31:0] A,
    input [31:0] WD,
    input WE,
    output [31:0] RD

);
  reg [31:0] mem[1023:0];
  always @(posedge clk) begin
    if (rst) begin
      mem[2]  = 32'h0fffffff;
      mem[3]  = 32'h0000000f;
      mem[32] = 32'h0000000f;
    end else if (WE) mem[A] <= WD;
  end
  assign RD = (rst == 1'b1) ? 32'd0 : mem[A];



endmodule
