`timescale 1ns / 1ps

module pe_tb;
  // Inputs to the DUT (Device Under Test)
  reg clk;
  reg rst;
  reg [7:0] a, b;
  reg [15:0] c;

  // Outputs from the DUT
  wire [7:0] a_o, b_o;
  wire [15:0] cab_o;

  // Instantiate the DUT
  pe uut (
      .clk(clk),
      .rst(rst),
      .a(a),
      .b(b),
      .c(c),
      .a_o(a_o),
      .b_o(b_o),
      .cab_o(cab_o)
  );

  // Clock generation
  initial clk = 0;
  always #5 clk = ~clk;  // 10ns clock period

  // Testbench logic
  initial begin
    // Initialize inputs
    rst = 1;
    a   = 0;
    b   = 0;
    c   = 0;

    // Apply reset
    #10 rst = 0;  // Deassert reset after 10ns

    // Test case 1: Basic operation
    a = 8'd5;
    b = 8'd10;
    c = 16'd20;
    #10;  // Wait for a clock cycle
    $display("Test 1 - a: %d, b: %d, c: %d, cab_o: %d", a_o, b_o, c, cab_o);

    // Test case 2: Change inputs
    a = 8'd3;
    b = 8'd7;
    c = 16'd100;
    #10;  // Wait for a clock cycle
    $display("Test 2 - a: %d, b: %d, c: %d, cab_o: %d", a_o, b_o, c, cab_o);

    // Test case 3: Reset behavior
    rst = 1;  // Assert reset
    #10;
    rst = 0;  // Deassert reset
    #10;
    $display("Test 3 - After reset - a_o: %d, b_o: %d, cab_o: %d", a_o, b_o, cab_o);

    // Finish simulation
    $stop;
  end
endmodule
