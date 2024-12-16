module fetch_cycle (
    input clk,
    input rst,
    input PCSrcM,
    input [31:0] PCBranchM,
    output reg [31:0] InstructionD,
    output reg [31:0] PCPlus4D
);
  wire [31:0] PCF_Next;
  wire [31:0] PCF;
  wire [31:0] InstrF;
  wire [31:0] PCPlus4F;

  PC PCIns (
      .rst(rst),
      .clk(clk),
      .PCNext(PCF_Next),
      .PC(PCF)
  );
  instruction_memory InstructionMemory (
      .A  (PCF),
      .rst(rst),
      .RD (InstrF)
  );

  assign PCF_Next = (PCSrcM == 1) ? PCBranchM : PCPlus4F;
  assign PCPlus4F = (PCF + 32'd4);
  always @(posedge clk) begin
    if (rst) begin

      InstructionD <= 0;
      PCPlus4D <= 0;
    end else begin
      PCPlus4D <= PCPlus4F;
      InstructionD <= InstrF;
    end
  end




endmodule
