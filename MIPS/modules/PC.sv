module PC (
    input rst,
    input clk,
    input En,
    input [31:0] PCNext,
    output reg [31:0] PC
);
  always @(posedge clk) begin
    if (rst) begin
      PC <= 32'b0;
    end else if (En == 1'b1) begin
      PC <= PCNext;
    end else begin
      PC <= PC;
    end
  end


endmodule
