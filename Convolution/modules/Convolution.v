module Convolution (
    input clk,
    input rst,
    input [7:0] x1,
    x2,
    x3,
    output reg [7:0] y1,
    y2,
    y3
);
  wire [7:0] y_out[0:2];
  reg [7:0] x_in;
  reg [7:0] y_in;
  integer i;
  always @(posedge clk) begin
    if (rst) begin
      y1 <= 0;
      y2 <= 0;
      y3 <= 0;
      x_in <= 0;
      y_in <= 0;
      i <= 0;

    end else begin
      i = i + 1;
      case (i)
        1: begin
          x_in <= x1;
          y_in <= 0;
        end
        2: begin
          x_in <= x2;
          y_in <= 0;
        end
        3: begin
          x_in <= x3;
          y_in <= 0;

        end
        4: begin
          x_in <= 0;
          y_in <= 0;


        end
        5: begin
          x_in <= 0;
          y_in <= 0;
          y1   <= y_out[2];

        end
        6: begin
          x_in <= 0;
          y_in <= 0;
          y2   <= y_out[2];
        end
        7: begin
          x_in <= 0;
          y_in <= 0;
          y3   <= y_out[2];
        end
        default: begin
          x_in <= 0;
          y_in <= 0;
        end
      endcase

    end
  end

  PE #(
      .WEIGTH(1)
  ) pe0 (
      .clk(clk),
      .rst(rst),
      .x_i(x_in),
      .y_i(y_in),
      .y_o(y_out[0])
  );
  PE #(
      .WEIGTH(2)
  ) pe1 (
      .clk(clk),
      .rst(rst),
      .x_i(x_in),
      .y_i(y_out[0]),
      .y_o(y_out[1])
  );
  PE #(
      .WEIGTH(2)
  ) pe2 (
      .clk(clk),
      .rst(rst),
      .x_i(x_in),
      .y_i(y_out[1]),
      .y_o(y_out[2])
  );




endmodule
