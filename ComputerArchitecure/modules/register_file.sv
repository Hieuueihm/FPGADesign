module register_file (
    input clk,
    input rst,
    input [4:0] A1,
    A2,
    A3,
    input [31:0] WD3,
    output [31:0] RD1,
    RD2,
    input WE3

);

  reg [31:0] Registers[31:0];


  assign RD1 = (rst == 1'b1) ? 32'b0 : Registers[A1];
  assign RD2 = (rst == 1'b1) ? 32'b0 : Registers[A2];

  integer i;
  always @(posedge clk) begin
    if (rst) begin
      for (i = 0; i < 32; i = i + 1) begin
        Registers[i] = 32'd0;
      end
      // Registers[16] = 32'd10;
      // Registers[17] = 32'd20;
    end else if (WE3) begin
      Registers[A3] <= WD3;
    end
  end





endmodule
