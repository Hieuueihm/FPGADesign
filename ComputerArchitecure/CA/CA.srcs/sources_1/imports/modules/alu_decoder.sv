module alu_decoder (
    input  [5:0] Funct,
    input  [1:0] ALUOp,
    output [2:0] ALUControl
);

  assign ALUControl = (ALUOp == 2'b00) ? 3'b010: 
                    (ALUOp[0] == 1'b1) ? 3'b110:
                    ((ALUOp[1] == 1'b1) & (Funct == 6'b100000)) ? 3'b010:
                    ((ALUOp[1] == 1'b1) & (Funct == 6'b100010)) ? 3'b110:
                    ((ALUOp[1] == 1'b1) & (Funct == 6'b100100)) ? 3'b000:
                    ((ALUOp[1] == 1'b1) & (Funct == 6'b100101)) ? 3'b001:
                    ((ALUOp[1] == 1'b1) & (Funct == 6'b101010)) ? 3'b111: 3'b000;

endmodule
