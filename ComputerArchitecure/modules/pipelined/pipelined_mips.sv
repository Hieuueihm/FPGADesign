module pipelined_mips (
    input clk,
    input rst
);

  wire [31:0] PCBranchM, InstructionD, PCPlus4D;
  wire RegWriteW;
  wire [31:0] ResultW, PCPlus4E, SignImmE, RD2E, RD1E;
  wire [4:0] RtE, RdE;
  wire RegWriteE, MemtoRegE, BranchE, ALUSrcE, RegDstE, MemWriteE;
  wire [2:0] ALUControlE;
  wire ZeroM, RegWriteM, MemtoRegM, MemWriteM, BranchM;
  wire [31:0] ALUOutM, WriteDataM;
  wire [4:0] WriteRegM;

  wire MemtoRegW, PCSrcM;
  wire [31:0] ALUOutW, ReadDataW;
  wire [4:0] WriteRegW;


  fetch_cycle FetchCycle (
      .clk(clk),
      .rst(rst),
      .PCSrcM(PCSrcM),
      .PCBranchM(PCBranchM),
      .InstructionD(InstructionD),
      .PCPlus4D(PCPlus4D)
  );
  decode_cycle DecodeCycle (
      .clk(clk),
      .rst(rst),
      .RegWriteW(RegWriteW),
      .ResultW(ResultW),
      .PCPlus4D(PCPlus4D),
      .WriteRegW(WriteRegW),
      .InstructionD(InstructionD),
      .PCPlus4E(PCPlus4E),
      .SignImmE(SignImmE),
      .RD1E(RD1E),
      .RD2E(RD2E),
      .RtE(RtE),
      .RdE(RdE),
      .RegWriteE(RegWriteE),
      .MemtoRegE(MemtoRegE),
      .MemWriteE(MemWriteE),
      .BranchE(BranchE),
      .ALUSrcE(ALUSrcE),
      .RegDstE(RegDstE),
      .ALUControlE(ALUControlE)

  );

  execute_cycle ExecuteCycle (
      .clk(clk),
      .rst(rst),
      .PCPlus4E(PCPlus4E),
      .SignImmE(SignImmE),
      .RD1E(RD1E),
      .RD2E(RD2E),
      .RtE(RtE),
      .RdE(RdE),
      .RegWriteE(RegWriteE),
      .MemtoRegE(MemtoRegE),
      .MemWriteE(MemWriteE),
      .BranchE(BranchE),
      .ALUSrcE(ALUSrcE),
      .RegDstE(RegDstE),
      .ALUControlE(ALUControlE),
      .ZeroM(ZeroM),
      .ALUOutM(ALUOutM),
      .WriteDataM(WriteDataM),
      .WriteRegM(WriteRegM),
      .PCBranchM(PCBranchM),
      .RegWriteM(RegWriteM),
      .MemtoRegM(MemtoRegM),
      .MemWriteM(MemWriteM),
      .BranchM(BranchM)
  );

  memory_cycle MemoryCycle (
      .clk(clk),
      .rst(rst),
      .RegWriteM(RegWriteM),
      .MemtoRegM(MemtoRegM),
      .MemWriteM(MemWriteM),
      .BranchM(BranchM),
      .ZeroM(ZeroM),
      .ALUOutM(ALUOutM),
      .WriteDataM(WriteDataM),
      .WriteRegM(WriteRegM),
      .RegWriteW(RegWriteW),
      .MemtoRegW(MemtoRegW),
      .ALUOutW(ALUOutW),
      .ReadDataW(ReadDataW),
      .WriteRegW(WriteRegW),
      .PCSrcM(PCSrcM)
  );
  writeback_cycle WriteBackCycle (

      .clk(clk),
      .rst(rst),
      .MemtoRegW(MemtoRegW),
      .ALUOutW(ALUOutW),
      .ReadDataW(ReadDataW),
      .ResultW(ResultW)
  );
endmodule
