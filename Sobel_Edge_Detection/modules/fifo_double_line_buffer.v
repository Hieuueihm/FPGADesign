module fifo_double_line_buffer #(

    parameter DEPTH,
) (
    input clk,
    input rst,
    input we_i,
    input [7:0] data_i,

    output [7:0] data0_o,
    output [7:0] data1_o,
    output [7:0] data2_o,

    output done_o

);

  wire [7:0] fifo01_data_o, fifo02_data_o;
  wire fifo01_done_o, fifo02_done_o;


  assign data0_o = data_i;
  assign data1_o = fifo01_data_o;
  assign data2_o = fifo02_data_o;

  assign done_o  = fifo01_done_o;

  fifo_single_line_buffer #(
      .DEPTH(DEPTH)
  ) line_1 (
      .clk(clk),
      .rst(rst),
      .we_i(we_i),
      .data_i(data_i),
      .data_o(fifo01_data_o),
      .done_o(fifo01_done_o)
  );



  fifo_single_line_buffer #(
      .DEPTH(DEPTH)
  ) line_2 (

      .clk(clk),
      .rst(rst),

      .we_i  (fifo01_done_o),
      .data_i(fifo01_data_o),

      .data_o(fifo02_data_o),
      .done_o(fifo02_done_o)
  );




endmodule
