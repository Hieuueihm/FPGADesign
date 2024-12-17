module instruction_memory (
    input [31:0] A,
    input rst,
    output [31:0] RD
);
  logic [31:0] mem[1023:0];

  initial begin
    $readmemh("D:\\Code\\FPGADesign\\ComputerArchitecure\\mem\\mem.dump", mem);
  end

  assign RD = (rst == 1'b0) ? mem[A>>2] : 32'b0;

endmodule
