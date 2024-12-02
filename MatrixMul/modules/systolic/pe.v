module pe (
    input clk,
    input rst,
    input [7:0] a,
    b,
    input [15:0] c,
    output reg [7:0] a_o,
    b_o,
    output reg [15:0] cab_o
);

  always @(posedge clk) begin
    if (rst) begin
      a_o   <= 0;
      b_o   <= 0;
      cab_o <= 0;
    end else begin
      a_o   <= a;
      b_o   <= b;
      cab_o <= c + a * b;
    end

  end

endmodule
