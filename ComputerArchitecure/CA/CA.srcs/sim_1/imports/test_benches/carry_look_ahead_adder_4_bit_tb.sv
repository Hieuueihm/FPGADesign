`timescale 1ns / 1ps

module carry_look_ahead_adder_4_bit_tb ();
  reg [3:0] A, B;
  reg Cin;
  wire [3:0] S;
  wire Cout;

  cla_4_bit UUT (
      .A(A),
      .B(B),
      .Cin(Cin),
      .S(S),
      .Cout(Cout)
  );

  initial begin
    $monitor("A = %b, B = %b, Cin = %b, S = %b, Cout = %b", A, B, Cin, S, Cout);

    A   = 4'b0011;
    B   = 4'b0111;
    Cin = 1'b0;
    #10;
    $display("%4d", S);
  end
endmodule
