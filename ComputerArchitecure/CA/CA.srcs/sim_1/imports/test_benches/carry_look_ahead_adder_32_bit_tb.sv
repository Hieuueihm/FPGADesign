`timescale 1ns / 1ps

module carry_look_ahead_adder_32_bit_tb;

  reg [31:0] A;
  reg [31:0] B;
  reg Cin;
  wire [31:0] S;
  wire Cout;

  // Instantiate the carry_look_ahead_adder_32_bit module
  cla_32_bit uut (
      .A(A),
      .B(B),
      .Cin(Cin),
      .S(S),
      .Cout(Cout)
  );

  initial begin
    // Initialize inputs
    A   = 32'd0;
    B   = 32'd0;
    Cin = 1'b0;

    // Apply test cases
    $display("Time\tA\t\t\t\tB\t\t\t\tCin\tS\t\t\t\tCout");

    // Test Case 1:
    #10 A = 32'h00000005;
    B   = 32'h00000003;
    Cin = 1'b0;
    #1
    if (S !== 32'h00000008 || Cout !== 1'b0) begin
      $display("Test Case 1 Failed");
      $finish;
    end

    // Test Case 2:
    #10 A = 32'h0000FFFF;
    B   = 32'h00010001;
    Cin = 1'b0;
    #1
    if (S !== 32'h00020000 || Cout !== 1'b0) begin
      $display("Test Case 2 Failed");
      $finish;
    end

    // Test Case 3: 
    #10 A = 32'hFFFFFFFF;
    B   = 32'h00000001;
    Cin = 1'b1;
    #1
    if (S !== 32'h00000001 || Cout !== 1'b1) begin
      $display("Test Case 3 Failed");
      $finish;
    end

    // Test Case 4:
    #10 A = 32'hFFFFFFFE;
    B   = 32'h00000002;
    Cin = 1'b0;
    #1
    if (S !== 32'h00000000 || Cout !== 1'b1) begin
      $display("Test Case 4 Failed");
      $finish;
    end

    // Test Case 5: 
    #10 A = 32'hFFFFFFFF;
    B   = 32'hFFFFFFFF;
    Cin = 1'b1;
    #1
    if (S !== 32'hFFFFFFFF || Cout !== 1'b1) begin
      $display("Test Case 5 Failed");
      $finish;
    end

    $display("All Test Cases Passed");
    // End simulation
    #10 $finish;
  end

endmodule
