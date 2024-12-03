`timescale 1ns / 1ps

module Convolution_tb;

  // Testbench Signals
  reg clk;
  reg rst;
  reg [7:0] x1, x2, x3;
  wire [7:0] y1, y2, y3;

  // Instantiate the Convolution module
  Convolution uut (
      .clk(clk),
      .rst(rst),
      .x1 (x1),
      .x2 (x2),
      .x3 (x3),
      .y1 (y1),
      .y2 (y2),
      .y3 (y3)
  );

  // Clock Generation
  initial clk = 0;
  always #5 clk = ~clk;  // 100 MHz clock

  // Testbench Logic
  initial begin
    // Initialize Inputs
    rst = 1;
    x1  = 0;
    x2  = 0;
    x3  = 0;

    // Reset the System
    #10 rst = 0;

    // Test Case 1
    x1 = 8'd10;
    x2 = 8'd20;
    x3 = 8'd30;
    // y1  10 * 1 + 20 * 2 + 30 * 2 = 110
    // y2 = 1 * 20 + 2 * 30 = 80
    // y3 = 1 * 30 = 30
    // Wait for Results
    #100;



    // End Simulation
    $stop;
  end

  // Monitor Outputs
  initial begin
    $monitor("Time: %0t | x1: %h, x2: %h, x3: %h | y1: %h, y2: %h, y3: %h", $time, x1, x2, x3, y1,
             y2, y3);
  end

endmodule
