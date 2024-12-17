module main_decoder (
    input [5:0] Opcode,
    output MemtoReg,
    output MemWrite,
    output Branch,
    ALUSrc,
    RegDst,
    RegWrite,
    output [1:0] ALUOp
);

  assign RegWrite = ((Opcode == 6'b000000) || (Opcode == 6'b100011)) ? 1'b1 : 1'b0;
  assign MemWrite = (Opcode == 6'b101011) ? 1'b1 : 1'b0;
  assign ALUSrc = ((Opcode == 6'b101011) || (Opcode == 6'b100011)) ? 1'b1 : 1'b0;
  assign Branch = (Opcode == 6'b000100) ? 1'b1 : 1'b0;
  assign RegDst = (Opcode == 6'b000000) ? 1'b1 : 1'b0;
  assign MemtoReg = (Opcode == 6'b100011) ? 1'b1 : 1'b0;
  assign ALUOp = (Opcode == 6'b000000) ? 2'b10 : (Opcode == 6'b000100) ? 2'b01 : 2'b00;

endmodule
