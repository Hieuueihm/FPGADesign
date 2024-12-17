module memory_cycle (
    input clk,
    input rst,
    input RegWriteM,
    input MemtoRegM,
    input MemWriteM,
    input BranchM,
    input ZeroM,
    input [31:0] ALUOutM,
    input [31:0] WriteDataM,
    input [4:0] WriteRegM,
    output reg RegWriteW,
    output reg MemtoRegW,
    output reg [31:0] ALUOutW,
    output reg [31:0] ReadDataW,
    output reg [4:0] WriteRegW,
    output PCSrcM,
    output [31:0] _ALUOutM
);
  wire [31:0] ReadDataM;
  assign PCSrcM = BranchM & ZeroM;
  data_memory DataMemory (
      .clk(clk),
      .rst(rst),
      .A  (ALUOutM),
      .WD (WriteDataM),
      .WE (MemWriteM),
      .RD (ReadDataM)
  );
  assign _ALUOutM = ALUOutM;
  always @(posedge clk) begin
    if (rst) begin
      RegWriteW <= 0;
      MemtoRegW <= 0;
      ALUOutW   <= 0;
      ReadDataW <= 0;
      WriteRegW <= 0;
    end else begin
      RegWriteW <= RegWriteM;
      MemtoRegW <= MemtoRegM;
      ALUOutW   <= ALUOutM;
      ReadDataW <= ReadDataM;
      WriteRegW <= WriteRegM;

    end
  end


endmodule
