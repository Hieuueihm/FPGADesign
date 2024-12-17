`timescale 1ns / 1ps
module mips_tops_tb ();

  reg clk = 1'b1, rst;

  mips_top MIPS_TOP (
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
    #450;
    $stop;
  end
endmodule
