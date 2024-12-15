module alu (
    input [31:0] A,
    input [31:0] B,
    input [2:0] ALUControl,
    output [31:0] Result,
    output Z
);

  wire [31:0] a_and_b;
  wire [31:0] a_or_b;
  wire [31:0] not_b;
  wire [31:0] sum;
  reg [31:0] mux_1, mux_2;
  wire Cout;

  assign a_and_b = A & B;
  assign a_or_b  = A | B;
  assign not_b   = ~B;




  assign mux_1   = (ALUControl[2] == 0) ? B : not_b;
  carry_look_ahead_adder_32_bit ADDER (
      .A(A),
      .B(mux_1),
      .Cin(ALUControl[2]),
      .Cout(Cout),
      .S(sum)
  );

  assign mux_2 = (ALUControl[1:0] == 2'b00) ? a_and_b : 
             (ALUControl[1:0] == 2'b01) ? a_or_b : 
             (ALUControl[1:0] == 2'b10) ? sum : 
             (ALUControl[1:0] == 2'b11) ? {31'b0, sum[31]} : {32'b0};

  assign Result = mux_2;

  assign Z = &(~Result);






endmodule
