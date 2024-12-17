module mips_top (
    input clk,
    input rst
);
  wire [31:0] PCTop, Instr;
  wire [31:0] Result;
  wire MemtoReg, MemWrite, Branch, ALUSrc, RegDst, RegWrite;
  wire [2:0] ALUControl;
  wire [31:0] SrcA, SrcB_RF;
  wire [31:0] SignImm;
  wire [31:0] SrcB;
  wire [31:0] ALUResult;
  wire Zero;
  wire [31:0] ReadData;
  wire PCSrc;
  wire [31:0] PCNext;

  PC PCIns (
      .rst(rst),
      .clk(clk),
      .PCNext(PCNext),
      .PC(PCTop)
  );
  instruction_memory InstructionMemory (
      .A  (PCTop),
      .rst(rst),
      .RD (Instr)
  );

  control_unit CU (
      .Opcode(Instr[31:26]),
      .Funct(Instr[5:0]),
      .MemtoReg(MemtoReg),
      .MemWrite(MemWrite),
      .Branch(Branch),
      .ALUSrc(ALUSrc),
      .RegDst(RegDst),
      .RegWrite(RegWrite),
      .ALUControl(ALUControl)

  );

  register_file RF (
      .clk(clk),
      .rst(rst),
      .A1 (Instr[25:21]),
      .A2 (Instr[20:16]),
      .A3 ((RegDst == 1'b1) ? Instr[15:11] : Instr[20:16]),  // address of source and destination
      .WD3(Result),
      .RD1(SrcA),
      .RD2(SrcB_RF),
      .WE3(RegWrite)
  );

  sign_extend SignExtend (
      .sign_in(Instr[15:0]),
      .SignImm(SignImm)
  );
  assign SrcB = (ALUSrc == 1'b1) ? SignImm : SrcB_RF;


  alu ALU (
      .A(SrcA),
      .B(SrcB),
      .ALUControl(ALUControl),
      .Result(ALUResult),
      .Zero(Zero)
  );
  data_memory DataMemory (
      .clk(clk),
      .rst(rst),
      .A  (ALUResult),
      .WD (SrcB_RF),
      .WE (MemWrite),
      .RD (ReadData)
  );
  assign Result = (MemtoReg == 1'b1) ? ReadData : ALUResult;
  assign PCSrc  = Branch & Zero;
  assign PCNext = (PCSrc == 1'b0) ? (PCTop + 32'd4) : (PCTop + 32'd4 + (SignImm << 2));




endmodule
