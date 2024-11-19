`timescale 1ns / 1ps



`define clk_period 10


module sobel_data_buffer_tb ();

  reg clk, rst, we_i;
  reg [7:0] data_i;
  wire [7:0] d0_o, d1_o, d2_o, d3_o, d4_o, d5_o, d6_o, d7_o, d8_o;
  wire done_o;


  initial clk = 1'b1;
  always #(`clk_period / 2) clk = ~clk;
  sobel_data_buffer #(
      .DEPTH_1(3),
      .DEPTH_2(3),
      .ROWS(5),
      .COLS(6)
  ) uut (
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
      .done_o(done_o)
  );
  integer i;
  initial begin
    rst    = 1'b1;
    data_i = 8'b0;
    we_i   = 1'b0;

    #(`clk_period);
    rst  = 1'b0;
    we_i = 1'b1;

    /*
         01 02 03 04 05 06
         07 08 09 10 11 12
         13 14 15 16 17 18
         19 20 21 22 23 24
         25 26 27 28 29 30
         */


    for (i = 1; i <= 30; i = i + 1) begin
      data_i = i;
      #(`clk_period);
    end


    we_i = 1'b0;
    #(`clk_period);

   $stop;

  end

endmodule
