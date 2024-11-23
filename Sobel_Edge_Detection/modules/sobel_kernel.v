module sobel_kernel (
    input clk,
    input rst,
    input [7:0] data_i,
    input we_i,
    output [7:0] grayscale_o,
    output done_o
);
  wire [7:0] d0_o, d1_o, d2_o, d3_o, d4_o, d5_o, d6_o, d7_o, d8_o;
  wire buffer_done_o;
  sobel_data_buffer #(
      .DEPTH(512),
      .ROWS (480),
      .COLS (360)
  ) SOBEL_DATA_BUFFER (
      .clk(clk),
      .rst(rst),
      .we_i(we_i),
      .data_i(data_i),

      .d0_o  (d0_o),
      .d1_o  (d1_o),
      .d2_o  (d2_o),
      .d3_o  (d3_o),
      .d4_o  (d4_o),
      .d5_o  (d5_o),
      .d6_o  (d6_o),
      .d7_o  (d7_o),
      .d8_o  (d8_o),
      .done_o(buffer_done_o)
  );

  sobel_calc SOBEL_CALC (
      .clk(clk),
      .rst(rst),
      .done_i(buffer_done_o),
      .d0_i(d0_o),
      .d1_i(d1_o),
      .d2_i(d2_o),
      .d3_i(d3_o),
      .d4_i(d4_o),
      .d5_i(d5_o),
      .d6_i(d6_o),
      .d7_i(d7_o),
      .d8_i(d8_o),
      .done_o(done_o),
      .grayscale_o(grayscale_o)
  );





endmodule
