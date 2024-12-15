module PC (
    input rst,
    input clk,
    input [31:0] PCNext,
    output reg [31:0] PC
);
  always @(posedge clk) begin
    if (rst) begin
      PC <= 32'b0;
    end else begin

      PC <= PCNext;
    end
  end


endmodule