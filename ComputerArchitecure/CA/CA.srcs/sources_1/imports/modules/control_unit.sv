module control_unit (
    input [5:0] Opcode,
    input [5:0] Funct,
    output MemtoReg,
    MemWrite,
    Branch,
    ALUSrc,
    RegDst,
    RegWrite,
    output [2:0] ALUControl
);
  wire [1:0] ALUOp;
  main_decoder MAIN_DECODER (
      .Opcode(Opcode),
      .MemtoReg(MemtoReg),
      .MemWrite(MemWrite),
      .Branch(Branch),
      .ALUSrc(ALUSrc),
      .RegDst(RegDst),
      .RegWrite(RegWrite),
      .ALUOp(ALUOp)
  );

  alu_decoder ALU_DECODER (
      .Funct(Funct),
      .ALUOp(ALUOp),
      .ALUControl(ALUControl)
  );
endmodule
