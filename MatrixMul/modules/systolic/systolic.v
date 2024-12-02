module systolic (
    input start_i,
    input [7:0] a1,
    a2,
    a3,
    a4,
    a5,
    a6,
    a7,
    a8,
    a9,
    input [7:0] b1,
    b2,
    b3,
    b4,
    b5,
    b6,
    b7,
    b8,
    b9,
    input clk,
    input rst,
    output reg done_o,
    output reg [15:0] c1,
    c2,
    c3,
    c4,
    c5,
    c6,
    c7,
    c8,
    c9

);
  // input
  integer i;
  reg [7:0] ai[0:4], bi[0:4];
  always @(posedge clk) begin
    if (rst) begin
      i <= 0;
      ai[0] = 0;
      ai[1] = 0;
      ai[2] = 0;
      ai[3] = 0;
      ai[4] = 0;
      bi[0] = 0;
      bi[1] = 0;
      bi[2] = 0;
      bi[3] = 0;
      bi[4] = 0;
      c1 = 0;
      c2 = 0;
      c3 = 0;
      c4 = 0;
      c5 = 0;
      c6 = 0;
      c7 = 0;
      c8 = 0;
      c9 = 0;
      done_o = 0;
    end
  end
  wire [ 7:0] pe_a_o  [18:0];
  wire [ 7:0] pe_b_o  [18:0];
  wire [15:0] pe_cab_o[18:0];
  wire [ 7:0] de_a_o  [ 5:0];
  wire [ 7:0] de_b_o  [ 5:0];

  // first row 
  pe pe0 (
      .clk(clk),
      .rst(rst),
      .a(ai[0]),
      .b(bi[0]),
      .c(16'd0),
      .a_o(pe_a_o[0]),
      .b_o(pe_b_o[0]),
      .cab_o(pe_cab_o[0])
  );

  pe pe1 (
      .clk(clk),
      .rst(rst),
      .a(pe_a_o[0]),
      .b(bi[1]),
      .c(16'd0),
      .a_o(pe_a_o[1]),
      .b_o(pe_b_o[1]),
      .cab_o(pe_cab_o[1])
  );

  pe pe2 (
      .clk(clk),
      .rst(rst),
      .a(pe_a_o[1]),
      .b(bi[2]),
      .c(16'd0),
      .a_o(pe_a_o[2]),
      .b_o(pe_b_o[2]),
      .cab_o(pe_cab_o[2])
  );

  de de0 (
      .clk(clk),
      .rst(rst),
      .a  (pe_a_o[2]),
      .b  (bi[3]),
      .a_o(de_a_o[0]),
      .b_o(de_b_o[0])
  );

  de de1 (
      .clk(clk),
      .rst(rst),
      .a  (de_a_o[0]),
      .b  (bi[4]),
      .a_o(de_a_o[1]),
      .b_o(de_b_o[1])
  );

  // Second row
  pe pe3 (
      .clk(clk),
      .rst(rst),
      .a(ai[1]),
      .b(pe_b_o[0]),
      .c(16'd0),
      .a_o(pe_a_o[3]),
      .b_o(pe_b_o[3]),
      .cab_o(pe_cab_o[3])
  );

  pe pe4 (
      .clk(clk),
      .rst(rst),
      .a(pe_a_o[3]),
      .b(pe_b_o[1]),
      .c(pe_cab_o[0]),
      .a_o(pe_a_o[4]),
      .b_o(pe_b_o[4]),
      .cab_o(pe_cab_o[4])
  );

  pe pe5 (
      .clk(clk),
      .rst(rst),
      .a(pe_a_o[4]),
      .b(pe_b_o[2]),
      .c(pe_cab_o[1]),
      .a_o(pe_a_o[5]),
      .b_o(pe_b_o[5]),
      .cab_o(pe_cab_o[5])
  );

  pe pe6 (
      .clk(clk),
      .rst(rst),
      .a(pe_a_o[5]),
      .b(de_b_o[0]),
      .c(pe_cab_o[2]),
      .a_o(pe_a_o[6]),
      .b_o(pe_b_o[6]),
      .cab_o(pe_cab_o[6])
  );

  de de2 (
      .clk(clk),
      .rst(rst),
      .a  (pe_a_o[4]),
      .b  (de_b_o[1]),
      .a_o(de_a_o[2]),
      .b_o(de_b_o[2])
  );

  // Third row
  pe pe7 (
      .clk(clk),
      .rst(rst),
      .a(ai[2]),
      .b(pe_b_o[3]),
      .c(16'd0),
      .a_o(pe_a_o[7]),
      .b_o(pe_b_o[7]),
      .cab_o(pe_cab_o[7])
  );

  pe pe8 (
      .clk(clk),
      .rst(rst),
      .a(pe_a_o[7]),
      .b(pe_b_o[4]),
      .c(pe_cab_o[3]),
      .a_o(pe_a_o[8]),
      .b_o(pe_b_o[8]),
      .cab_o(pe_cab_o[8])
  );

  pe pe9 (
      .clk(clk),
      .rst(rst),
      .a(pe_a_o[8]),
      .b(pe_b_o[5]),
      .c(pe_cab_o[4]),
      .a_o(pe_a_o[9]),
      .b_o(pe_b_o[9]),
      .cab_o(pe_cab_o[9])
  );

  pe pe10 (
      .clk(clk),
      .rst(rst),
      .a(pe_a_o[9]),
      .b(pe_b_o[6]),
      .c(pe_cab_o[5]),
      .a_o(pe_a_o[10]),
      .b_o(pe_b_o[10]),
      .cab_o(pe_cab_o[10])
  );

  pe pe11 (
      .clk(clk),
      .rst(rst),
      .a(pe_a_o[10]),
      .b(de_b_o[2]),
      .c(pe_cab_o[6]),
      .a_o(pe_a_o[11]),
      .b_o(pe_b_o[11]),
      .cab_o(pe_cab_o[11])
  );

  // Fourth row
  de de3 (
      .clk(clk),
      .rst(rst),
      .a  (ai[3]),
      .b  (pe_b_o[7]),
      .a_o(de_a_o[3]),
      .b_o(de_b_o[3])
  );

  pe pe12 (
      .clk(clk),
      .rst(rst),
      .a(de_a_o[3]),
      .b(pe_b_o[8]),
      .c(pe_cab_o[7]),
      .a_o(pe_a_o[12]),
      .b_o(pe_b_o[12]),
      .cab_o(pe_cab_o[12])
  );

  pe pe13 (
      .clk(clk),
      .rst(rst),
      .a(pe_a_o[12]),
      .b(pe_b_o[9]),
      .c(pe_cab_o[8]),
      .a_o(pe_a_o[13]),
      .b_o(pe_b_o[13]),
      .cab_o(pe_cab_o[13])
  );

  pe pe14 (
      .clk(clk),
      .rst(rst),
      .a(pe_a_o[13]),
      .b(pe_b_o[10]),
      .c(pe_cab_o[9]),
      .a_o(pe_a_o[14]),
      .b_o(pe_b_o[14]),
      .cab_o(pe_cab_o[14])
  );

  pe pe15 (
      .clk(clk),
      .rst(rst),
      .a(pe_a_o[14]),
      .b(pe_b_o[11]),
      .c(pe_cab_o[10]),
      .a_o(pe_a_o[15]),
      .b_o(pe_b_o[15]),
      .cab_o(pe_cab_o[15])
  );

  // Fifth row
  de de4 (
      .clk(clk),
      .rst(rst),
      .a  (ai[4]),
      .b  (de_b_o[3]),
      .a_o(de_a_o[4]),
      .b_o(de_b_o[4])
  );

  de de5 (
      .clk(clk),
      .rst(rst),
      .a  (de_a_o[4]),
      .b  (pe_b_o[12]),
      .a_o(de_a_o[5]),
      .b_o(de_b_o[5])
  );

  pe pe16 (
      .clk(clk),
      .rst(rst),
      .a(de_a_o[5]),
      .b(pe_b_o[13]),
      .c(pe_cab_o[12]),
      .a_o(pe_a_o[16]),
      .b_o(pe_b_o[16]),
      .cab_o(pe_cab_o[16])
  );

  pe pe17 (
      .clk(clk),
      .rst(rst),
      .a(pe_a_o[16]),
      .b(pe_b_o[14]),
      .c(pe_cab_o[13]),
      .a_o(pe_a_o[17]),
      .b_o(pe_b_o[17]),
      .cab_o(pe_cab_o[17])
  );

  pe pe18 (
      .clk(clk),
      .rst(rst),
      .a(pe_a_o[17]),
      .b(pe_b_o[15]),
      .c(pe_cab_o[14]),
      .a_o(pe_a_o[18]),
      .b_o(pe_b_o[18]),
      .cab_o(pe_cab_o[18])
  );


  // c11 c12 c13
  // c21 c22 c23
  // c31 c32 c33
  always @(posedge clk) begin
    if (start_i) begin
      i = i + 1;
      $display("i : %d", i);
      // Display for pe_cab_o
      $display("a in: %d %d %d %d %d", ai[0], ai[1], ai[2], ai[3], ai[4]);
      $display("b in: %d %d %d %d %d", bi[0], bi[1], bi[2], bi[3], bi[4]);
      $display("out c: %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d", pe_cab_o[0],
               pe_cab_o[1], pe_cab_o[2], pe_cab_o[3], pe_cab_o[4], pe_cab_o[5], pe_cab_o[6],
               pe_cab_o[7], pe_cab_o[8], pe_cab_o[9], pe_cab_o[10], pe_cab_o[11], pe_cab_o[12],
               pe_cab_o[13], pe_cab_o[14], pe_cab_o[15], pe_cab_o[16], pe_cab_o[17], pe_cab_o[18]);

      // Display for pe_a_o
      $display("out a: %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d", pe_a_o[0],
               pe_a_o[1], pe_a_o[2], pe_a_o[3], pe_a_o[4], pe_a_o[5], pe_a_o[6], pe_a_o[7],
               pe_a_o[8], pe_a_o[9], pe_a_o[10], pe_a_o[11], pe_a_o[12], pe_a_o[13], pe_a_o[14],
               pe_a_o[15], pe_a_o[16], pe_a_o[17], pe_a_o[18]);

      // Display for pe_b_o
      $display("out b: %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d ", pe_b_o[0],
               pe_b_o[1], pe_b_o[2], pe_b_o[3], pe_b_o[4], pe_b_o[5], pe_b_o[6], pe_b_o[7],
               pe_b_o[8], pe_b_o[9], pe_b_o[10], pe_b_o[11], pe_b_o[12], pe_b_o[13], pe_b_o[14],
               pe_b_o[15], pe_b_o[16], pe_b_o[17], pe_b_o[18]);


    end else begin
      i = 0;
    end
    case (i)
      1: begin
        ai[0] <= a1;
        ai[1] <= a2;
        ai[2] <= a3;
        ai[3] <= 0;
        ai[4] <= 0;
        bi[0] <= b1;
        bi[1] <= b4;
        bi[2] <= b7;
        bi[3] <= 0;
        bi[4] <= 0;
      end
      2: begin
        ai[0] <= 0;
        ai[1] <= a4;
        ai[2] <= a5;
        ai[3] <= a6;
        ai[4] <= 0;
        bi[0] <= 0;
        bi[1] <= b2;
        bi[2] <= b5;
        bi[3] <= b8;
        bi[4] <= 0;
      end
      3: begin
        ai[0] <= 0;
        ai[1] <= 0;
        ai[2] <= a7;
        ai[3] <= a8;
        ai[4] <= a9;
        bi[0] <= 0;
        bi[1] <= 0;
        bi[2] <= b3;
        bi[3] <= b6;
        bi[4] <= b9;
      end



      7: begin
        c1 = pe_cab_o[18];
        c2 = pe_cab_o[15];
        c3 = pe_cab_o[11];
        c4 = pe_cab_o[17];
        c7 = pe_cab_o[16];
      end
      8: begin
        c5 = pe_cab_o[18];
        c6 = pe_cab_o[15];
        c8 = pe_cab_o[17];
      end
      9: begin
        c9 = pe_cab_o[18];
        done_o = 1;
      end
      default: begin
        ai[0] <= 0;
        ai[1] <= 0;
        ai[2] <= 0;
        ai[3] <= 0;
        ai[4] <= 0;
        bi[0] <= 0;
        bi[1] <= 0;
        bi[2] <= 0;
        bi[3] <= 0;
        bi[4] <= 0;
      end

    endcase
  end

endmodule
