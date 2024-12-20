`timescale 1ns / 1ps



`define clk_period 10


module fifo_double_line_buffer_tb ();

  reg clk, rst, we_i;
  reg [7:0] data_i;
  wire [7:0] data0_o, data1_o, data2_o;
  wire done_o;


  initial clk = 1'b1;
  always #(`clk_period / 2) clk = ~clk;
  fifo_double_line_buffer #(
      .DEPTH(5),
  ) uut (
      .clk(clk),
      .rst(rst),
      .we_i(we_i),
      .data_i(data_i),

      .data0_o(data0_o),
      .data1_o(data1_o),
      .data2_o(data2_o),

      .done_o(done_o)
  );
  integer i;
  initial begin
    rst = 1'b1;
    data_i = 8'b0;
    we_i = 1'b0;

    #(`clk_period);
    rst  = 1'b0;
    we_i = 1'b1;


    for (i = 0; i < 15; i = i + 1) begin
      data_i = i;
      #(`clk_period);
    end

    we_i = 1'b0;
    #(`clk_period);

    $stop;

  end

endmodule
