module PE #(
    parameter WEIGTH
) (
    input clk,
    input rst,
    input [7:0] x_i,
    input [7:0] y_i,
    output reg [7:0] y_o
);

  always @(posedge clk) begin
    if (rst) begin
      y_o <= 0;
    end else begin
      y_o <= y_i + WEIGTH * x_i;

    end

  end

endmodule
