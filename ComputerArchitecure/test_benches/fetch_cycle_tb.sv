`timescale 1ns / 1ps
`define clk_period 10

module fetch_cycle_tb ();
  reg clk, rst;
  reg PCSrcM;
  reg [31:0] PCBranchM;
  wire [31:0] InstructioD, PCPlus4D;
  fetch_cycle uut (
      .clk(clk),
      .rst(rst),
      .PCSrcM(PCSrcM),
      .PCBranchM(PCBranchM),
      .InstructioD(InstructioD),
      .PCPlus4D(PCPlus4D)
  );
  initial clk = 1;
  always #(`clk_period / 2) clk = ~clk;

  initial begin
    rst <= 1'b1;
    repeat (2) #(`clk_period);
    rst <= 1'b0;
    PCSrcM <= 1'b0;
    PCBranchM <= 32'd10;
    repeat (5) #(`clk_period);
    $stop;
  end



endmodule
