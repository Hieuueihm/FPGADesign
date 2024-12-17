module cla_32_bit (
    input [31:0] A,
    input [31:0] B,
    input Cin,
    output [31:0] S,
    output Cout
);
  wire [3:0] S_in[0:7];
  wire [3:0] Co  [0:7];
  cla_4_bit F0 (
      .A(A[3:0]),
      .B(B[3:0]),
      .Cin(Cin),
      .S(S_in[0]),
      .Cout(Co[0])
  );
  cla_4_bit F1 (
      .A(A[7:4]),
      .B(B[7:4]),
      .Cin(Co[0]),
      .S(S_in[1]),
      .Cout(Co[1])
  );
  cla_4_bit F2 (
      .A(A[11:8]),
      .B(B[11:8]),
      .Cin(Co[1]),
      .S(S_in[2]),
      .Cout(Co[2])
  );
  cla_4_bit F3 (
      .A(A[15:12]),
      .B(B[15:12]),
      .Cin(Co[2]),
      .S(S_in[3]),
      .Cout(Co[3])
  );
  cla_4_bit F4 (
      .A(A[19:16]),
      .B(B[19:16]),
      .Cin(Co[3]),
      .S(S_in[4]),
      .Cout(Co[4])
  );
  cla_4_bit F5 (
      .A(A[23:20]),
      .B(B[23:20]),
      .Cin(Co[4]),
      .S(S_in[5]),
      .Cout(Co[5])
  );
  cla_4_bit F6 (
      .A(A[27:24]),
      .B(B[27:24]),
      .Cin(Co[5]),
      .S(S_in[6]),
      .Cout(Co[6])
  );
  cla_4_bit F7 (
      .A(A[31:28]),
      .B(B[31:28]),
      .Cin(Co[6]),
      .S(S_in[7]),
      .Cout(Co[7])
  );

  assign Cout = Co[7];
  assign S = {S_in[7], S_in[6], S_in[5], S_in[4], S_in[3], S_in[2], S_in[1], S_in[0]};


endmodule
