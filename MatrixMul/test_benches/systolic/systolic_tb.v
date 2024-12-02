module systolic_tb;

  // Inputs
  reg start_i;
  reg [7:0] a1, a2, a3, a4, a5, a6, a7, a8, a9;
  reg [7:0] b1, b2, b3, b4, b5, b6, b7, b8, b9;
  reg  clk;
  reg  rst;

  // Outputs
  wire done_o;
  wire [15:0] c1, c2, c3, c4, c5, c6, c7, c8, c9;

  // Instantiate the Unit Under Test (UUT)
  systolic uut (
      .start_i(start_i),
      .a1(a1),
      .a2(a2),
      .a3(a3),
      .a4(a4),
      .a5(a5),
      .a6(a6),
      .a7(a7),
      .a8(a8),
      .a9(a9),
      .b1(b1),
      .b2(b2),
      .b3(b3),
      .b4(b4),
      .b5(b5),
      .b6(b6),
      .b7(b7),
      .b8(b8),
      .b9(b9),
      .clk(clk),
      .rst(rst),
      .done_o(done_o),
      .c1(c1),
      .c2(c2),
      .c3(c3),
      .c4(c4),
      .c5(c5),
      .c6(c6),
      .c7(c7),
      .c8(c8),
      .c9(c9)
  );

  // Clock generation
  initial begin
    clk = 0;
    forever #5 clk = ~clk;  // 10 ns clock period
  end

  // Test stimulus
  initial begin
    // Initialize inputs
    start_i = 0;
    rst = 1;
    a1 = 8'd0;
    a2 = 8'd0;
    a3 = 8'd0;
    a4 = 8'd0;
    a5 = 8'd0;
    a6 = 8'd0;
    a7 = 8'd0;
    a8 = 8'd0;
    a9 = 8'd0;
    b1 = 8'd0;
    b2 = 8'd0;
    b3 = 8'd0;
    b4 = 8'd0;
    b5 = 8'd0;
    b6 = 8'd0;
    b7 = 8'd0;
    b8 = 8'd0;
    b9 = 8'd0;

    // Apply reset
    #10 rst = 0;

    // Apply input values
    #10;
    rst = 1;
    #10;
    rst = 0;
    start_i = 1;
    a1 = 8'd1;
    a2 = 8'd2;
    a3 = 8'd3;
    a4 = 8'd4;
    a5 = 8'd5;
    a6 = 8'd6;
    a7 = 8'd7;
    a8 = 8'd8;
    a9 = 8'd9;
    b1 = 8'd10;
    b2 = 8'd11;
    b3 = 8'd12;
    b4 = 8'd13;
    b5 = 8'd14;
    b6 = 8'd15;
    b7 = 8'd16;
    b8 = 8'd17;
    b9 = 8'd18;

    // Wait for done signal
    wait (done_o);

    // Check the outputs
    #100;
    $display("Results:");
    $display("c1 = %d", c1);
    $display("c2 = %d", c2);
    $display("c3 = %d", c3);
    $display("c4 = %d", c4);
    $display("c5 = %d", c5);
    $display("c6 = %d", c6);
    $display("c7 = %d", c7);
    $display("c8 = %d", c8);
    $display("c9 = %d", c9);

    // Finish simulation
    #10 $stop;
  end

endmodule
