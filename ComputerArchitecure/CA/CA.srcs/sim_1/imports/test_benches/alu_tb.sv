`timescale 1ns / 1ps

module alu_tb;

  reg [31:0] A, B;
  reg [2:0] ALUControl;
  wire [31:0] Result;
  wire Z;

  // Instantiate the ALU module
  alu uut (
      .A(A),
      .B(B),
      .ALUControl(ALUControl),
      .Result(Result),
      .Zero(Z)
  );

  initial begin





    $stop;
  end


endmodule
