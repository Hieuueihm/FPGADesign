`timescale 1ns / 1ps



`define clk_period 10


module sobel_calc_tb ();

  reg clk, rst, done_i;
  reg [7:0] d0_i, d1_i, d2_i, d3_i, d4_i, d5_i, d6_i, d7_i, d8_i;
  wire done_o;
  wire [7:0] grayscale_o;


  initial clk = 1'b1;
  always #(`clk_period / 2) clk = ~clk;
  sobel_calc uut (
      .clk(clk),
      .rst(rst),
      .done_i(done_i),
      .d0_i(d0_i),
      .d1_i(d1_i),
      .d2_i(d2_i),
      .d3_i(d3_i),
      .d4_i(d4_i),
      .d5_i(d5_i),
      .d6_i(d6_i),
      .d7_i(d7_i),
      .d8_i(d8_i),
      .done_o(done_o),
      .grayscale_o(grayscale_o)
  );
  integer i;
  initial begin
    rst    = 1'b1;
    done_i = 1'b0;

    #(`clk_period);

    rst = 1'b0;
    done_i = 1'b1;

    #(`clk_period);


    d0_i = 8'd1;
    d1_i = 8'd2;
    d2_i = 8'd3;
    d3_i = 8'd4;
    d4_i = 8'd5;
    d5_i = 8'd6;
    d6_i = 8'd7;
    d7_i = 8'd8;
    d8_i = 8'd9;


    // g_sum = 32

    #(`clk_period);
    #(`clk_period);
    #(`clk_period);
    #(`clk_period);
    #(`clk_period);
    #(`clk_period);
    #(`clk_period);
    #(`clk_period);
    #(`clk_period);
    done_i = 1'b0;
    #(`clk_period);
    $stop;

  end

endmodule
