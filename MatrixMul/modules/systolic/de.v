module de (
    input clk,
    input rst,
    input [7:0] a,
    b,
    output reg [7:0] a_o,
    b_o
);
  always @(posedge clk) begin
    if (rst) begin
      a_o <= 0;
      b_o <= 0;
    end else begin

      a_o <= a;
      b_o <= b;
    end
  end

endmodule
