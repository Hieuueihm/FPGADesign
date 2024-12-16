`timescale 1ns / 1ps
module pipelined_mips_tb ();

  reg clk = 1'b1, rst;

  pipelined_mips MIPS_TOP (
      .clk(clk),
      .rst(rst)
  );

  always begin
    clk = ~clk;
    #50;

  end

  initial begin
    rst <= 1'b1;
    #150;

    rst <= 1'b0;
    #1000;
    $stop;
  end
endmodule
