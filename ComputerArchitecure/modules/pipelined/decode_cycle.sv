module decode_cycle (
    input clk,
    input rst,
    input RegWriteW,
    input [31:0] ResultW,
    input [31:0] PCPlus4D,
    input [4:0] WriteRegW,
    input [31:0] InstructionD,
    output reg [31:0] PCPlus4E,
    output reg [31:0] SignImmE,
    output reg [31:0] RD1E,
    output reg [31:0] RD2E,
    output reg [4:0] RtE,
    RdE,
    output reg RegWriteE,
    MemtoRegE,
    MemWriteE,
    BranchE,
    ALUSrcE,
    RegDstE,
    output reg [2:0] ALUControlE

);
  wire [31:0] RD1D, RD2D;
  wire [31:0] SignImmD;
  wire RegWriteD, MemtoRegD, MemWriteD, BranchD, ALUSrcD, RegDstD;
  wire [2:0] ALUControlD;
  register_file RF (
      .clk(clk),
      .rst(rst),
      .A1 (InstructionD[25:21]),
      .A2 (InstructionD[20:16]),
      .A3 (WriteRegW),
      .WD3(ResultW),
      .RD1(RD1D),
      .RD2(RD2D),
      .WE3(RegWriteW)
  );



  sign_extend SignExtend (
      .sign_in(InstructionD[15:0]),
      .SignImm(SignImmD)
  );
  control_unit CU (
      .Opcode(InstructionD[31:26]),
      .Funct(InstructionD[5:0]),
      .MemtoReg(MemtoRegD),
      .MemWrite(MemWriteD),
      .Branch(BranchD),
      .ALUSrc(ALUSrcD),
      .RegDst(RegDstD),
      .RegWrite(RegWriteD),
      .ALUControl(ALUControlD)

  );

  always @(posedge clk) begin
    if (rst) begin
      RtE <= 0;
      RdE <= 0;
      SignImmE <= 0;
      RD1E <= 0;
      RD2E <= 0;
      PCPlus4E <= 0;

      RegWriteE <= 0;
      MemtoRegE <= 0;
      MemWriteE <= 0;
      BranchE <= 0;
      ALUSrcE <= 0;
      RegDstE <= 0;
      ALUControlE <= 0;
    end else begin
      RtE <= InstructionD[20:16];
      RdE <= InstructionD[15:11];
      SignImmE <= SignImmD;
      PCPlus4E <= PCPlus4E;
      RD1E <= RD1D;
      RD2E <= RD2D;

      RegWriteE <= RegWriteD;
      MemtoRegE <= MemtoRegD;
      MemWriteE <= MemWriteD;
      BranchE <= BranchD;
      ALUSrcE <= ALUSrcD;
      RegDstE <= RegDstD;
      ALUControlE <= ALUControlD;


    end
  end

endmodule
