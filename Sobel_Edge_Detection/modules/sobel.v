// top level file

module sobel (
    input clk,
    input rst,
    input [7:0] red_i,
    input [7:0] green_i,
    input [7:0] blue_i,

    input done_i,

    output [7:0] red_o,
    output [7:0] green_o,
    output [7:0] blue_o,

    output done_o
);
    wire [7:0] RGB2Gray_grayscale_o;
    wire RGB2Gray_done_o;

    
    wire kernel_done_o;
    wire[7:0] kernel_data;
   RGB2Gray RGB2Gray_instance (
      .clk(clk),
      .rst(rst),
      .red_i(red_i),
      .green_i(green_i),
      .blue_i(blue_i),
      .done_i(done_i),
      .grayscale_o(RGB2Gray_grayscale_o),
      .done_o(RGB2Gray_done_o)
  );

    sobel_kernel SOBEL_KERNEL_INSTANCE(
        .clk(clk),
        .rst(rst),
        .data_i(RGB2Gray_grayscale_o),
        .we_i(RGB2Gray_done_o),
        .grayscale_o(kernel_data),
        .done_o(kernel_done_o)
    );

    Gray2RGB Gray2RGB_Instance(
        .clk(clk),
      .rst(rst),
      .done_i(kernel_done_o),
      .grayscale_i(kernel_data),
      .red_o(red_o),
      .green_o(green_o),
      .blue_o(blue_o),
      .done_o(done_o)
    );





endmodule
