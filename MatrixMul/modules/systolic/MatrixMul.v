// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2024.1 (win64) Build 5076996 Wed May 22 18:37:14 MDT 2024
// Date        : Tue Dec  3 00:51:25 2024
// Host        : DESKTOP-4VU606L running 64-bit major release  (build 9200)
// Command     : write_verilog D:/Code/FPGADesign/MatrixMul/modules/systolic/MatrixMul.v
// Design      : systolic
// Purpose     : This is a Verilog netlist of the current design or from a specific cell of the design. The output is an
//               IEEE 1364-2001 compliant Verilog HDL file that contains netlist information obtained from the input
//               design files.
// Device      : xc7k70tfbv676-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* STRUCTURAL_NETLIST = "yes" *)
module systolic
   (start_i,
    a1,
    a2,
    a3,
    a4,
    a5,
    a6,
    a7,
    a8,
    a9,
    b1,
    b2,
    b3,
    b4,
    b5,
    b6,
    b7,
    b8,
    b9,
    clk,
    rst,
    done_o,
    c1,
    c2,
    c3,
    c4,
    c5,
    c6,
    c7,
    c8,
    c9);
  input start_i;
  input [7:0]a1;
  input [7:0]a2;
  input [7:0]a3;
  input [7:0]a4;
  input [7:0]a5;
  input [7:0]a6;
  input [7:0]a7;
  input [7:0]a8;
  input [7:0]a9;
  input [7:0]b1;
  input [7:0]b2;
  input [7:0]b3;
  input [7:0]b4;
  input [7:0]b5;
  input [7:0]b6;
  input [7:0]b7;
  input [7:0]b8;
  input [7:0]b9;
  input clk;
  input rst;
  output done_o;
  output [15:0]c1;
  output [15:0]c2;
  output [15:0]c3;
  output [15:0]c4;
  output [15:0]c5;
  output [15:0]c6;
  output [15:0]c7;
  output [15:0]c8;
  output [15:0]c9;

  wire \<const0> ;
  wire [15:0]c1;
  wire [15:0]c2;
  wire [15:0]c3;
  wire [15:0]c4;
  wire [15:0]c5;
  wire [15:0]c6;
  wire [15:0]c7;
  wire [15:0]c8;
  wire [15:0]c9;
  wire done_o;

  GND GND
       (.G(\<const0> ));
  OBUF \c1_OBUF[0]_inst 
       (.I(\<const0> ),
        .O(c1[0]));
  OBUF \c1_OBUF[10]_inst 
       (.I(\<const0> ),
        .O(c1[10]));
  OBUF \c1_OBUF[11]_inst 
       (.I(\<const0> ),
        .O(c1[11]));
  OBUF \c1_OBUF[12]_inst 
       (.I(\<const0> ),
        .O(c1[12]));
  OBUF \c1_OBUF[13]_inst 
       (.I(\<const0> ),
        .O(c1[13]));
  OBUF \c1_OBUF[14]_inst 
       (.I(\<const0> ),
        .O(c1[14]));
  OBUF \c1_OBUF[15]_inst 
       (.I(\<const0> ),
        .O(c1[15]));
  OBUF \c1_OBUF[1]_inst 
       (.I(\<const0> ),
        .O(c1[1]));
  OBUF \c1_OBUF[2]_inst 
       (.I(\<const0> ),
        .O(c1[2]));
  OBUF \c1_OBUF[3]_inst 
       (.I(\<const0> ),
        .O(c1[3]));
  OBUF \c1_OBUF[4]_inst 
       (.I(\<const0> ),
        .O(c1[4]));
  OBUF \c1_OBUF[5]_inst 
       (.I(\<const0> ),
        .O(c1[5]));
  OBUF \c1_OBUF[6]_inst 
       (.I(\<const0> ),
        .O(c1[6]));
  OBUF \c1_OBUF[7]_inst 
       (.I(\<const0> ),
        .O(c1[7]));
  OBUF \c1_OBUF[8]_inst 
       (.I(\<const0> ),
        .O(c1[8]));
  OBUF \c1_OBUF[9]_inst 
       (.I(\<const0> ),
        .O(c1[9]));
  OBUF \c2_OBUF[0]_inst 
       (.I(\<const0> ),
        .O(c2[0]));
  OBUF \c2_OBUF[10]_inst 
       (.I(\<const0> ),
        .O(c2[10]));
  OBUF \c2_OBUF[11]_inst 
       (.I(\<const0> ),
        .O(c2[11]));
  OBUF \c2_OBUF[12]_inst 
       (.I(\<const0> ),
        .O(c2[12]));
  OBUF \c2_OBUF[13]_inst 
       (.I(\<const0> ),
        .O(c2[13]));
  OBUF \c2_OBUF[14]_inst 
       (.I(\<const0> ),
        .O(c2[14]));
  OBUF \c2_OBUF[15]_inst 
       (.I(\<const0> ),
        .O(c2[15]));
  OBUF \c2_OBUF[1]_inst 
       (.I(\<const0> ),
        .O(c2[1]));
  OBUF \c2_OBUF[2]_inst 
       (.I(\<const0> ),
        .O(c2[2]));
  OBUF \c2_OBUF[3]_inst 
       (.I(\<const0> ),
        .O(c2[3]));
  OBUF \c2_OBUF[4]_inst 
       (.I(\<const0> ),
        .O(c2[4]));
  OBUF \c2_OBUF[5]_inst 
       (.I(\<const0> ),
        .O(c2[5]));
  OBUF \c2_OBUF[6]_inst 
       (.I(\<const0> ),
        .O(c2[6]));
  OBUF \c2_OBUF[7]_inst 
       (.I(\<const0> ),
        .O(c2[7]));
  OBUF \c2_OBUF[8]_inst 
       (.I(\<const0> ),
        .O(c2[8]));
  OBUF \c2_OBUF[9]_inst 
       (.I(\<const0> ),
        .O(c2[9]));
  OBUF \c3_OBUF[0]_inst 
       (.I(\<const0> ),
        .O(c3[0]));
  OBUF \c3_OBUF[10]_inst 
       (.I(\<const0> ),
        .O(c3[10]));
  OBUF \c3_OBUF[11]_inst 
       (.I(\<const0> ),
        .O(c3[11]));
  OBUF \c3_OBUF[12]_inst 
       (.I(\<const0> ),
        .O(c3[12]));
  OBUF \c3_OBUF[13]_inst 
       (.I(\<const0> ),
        .O(c3[13]));
  OBUF \c3_OBUF[14]_inst 
       (.I(\<const0> ),
        .O(c3[14]));
  OBUF \c3_OBUF[15]_inst 
       (.I(\<const0> ),
        .O(c3[15]));
  OBUF \c3_OBUF[1]_inst 
       (.I(\<const0> ),
        .O(c3[1]));
  OBUF \c3_OBUF[2]_inst 
       (.I(\<const0> ),
        .O(c3[2]));
  OBUF \c3_OBUF[3]_inst 
       (.I(\<const0> ),
        .O(c3[3]));
  OBUF \c3_OBUF[4]_inst 
       (.I(\<const0> ),
        .O(c3[4]));
  OBUF \c3_OBUF[5]_inst 
       (.I(\<const0> ),
        .O(c3[5]));
  OBUF \c3_OBUF[6]_inst 
       (.I(\<const0> ),
        .O(c3[6]));
  OBUF \c3_OBUF[7]_inst 
       (.I(\<const0> ),
        .O(c3[7]));
  OBUF \c3_OBUF[8]_inst 
       (.I(\<const0> ),
        .O(c3[8]));
  OBUF \c3_OBUF[9]_inst 
       (.I(\<const0> ),
        .O(c3[9]));
  OBUF \c4_OBUF[0]_inst 
       (.I(\<const0> ),
        .O(c4[0]));
  OBUF \c4_OBUF[10]_inst 
       (.I(\<const0> ),
        .O(c4[10]));
  OBUF \c4_OBUF[11]_inst 
       (.I(\<const0> ),
        .O(c4[11]));
  OBUF \c4_OBUF[12]_inst 
       (.I(\<const0> ),
        .O(c4[12]));
  OBUF \c4_OBUF[13]_inst 
       (.I(\<const0> ),
        .O(c4[13]));
  OBUF \c4_OBUF[14]_inst 
       (.I(\<const0> ),
        .O(c4[14]));
  OBUF \c4_OBUF[15]_inst 
       (.I(\<const0> ),
        .O(c4[15]));
  OBUF \c4_OBUF[1]_inst 
       (.I(\<const0> ),
        .O(c4[1]));
  OBUF \c4_OBUF[2]_inst 
       (.I(\<const0> ),
        .O(c4[2]));
  OBUF \c4_OBUF[3]_inst 
       (.I(\<const0> ),
        .O(c4[3]));
  OBUF \c4_OBUF[4]_inst 
       (.I(\<const0> ),
        .O(c4[4]));
  OBUF \c4_OBUF[5]_inst 
       (.I(\<const0> ),
        .O(c4[5]));
  OBUF \c4_OBUF[6]_inst 
       (.I(\<const0> ),
        .O(c4[6]));
  OBUF \c4_OBUF[7]_inst 
       (.I(\<const0> ),
        .O(c4[7]));
  OBUF \c4_OBUF[8]_inst 
       (.I(\<const0> ),
        .O(c4[8]));
  OBUF \c4_OBUF[9]_inst 
       (.I(\<const0> ),
        .O(c4[9]));
  OBUF \c5_OBUF[0]_inst 
       (.I(\<const0> ),
        .O(c5[0]));
  OBUF \c5_OBUF[10]_inst 
       (.I(\<const0> ),
        .O(c5[10]));
  OBUF \c5_OBUF[11]_inst 
       (.I(\<const0> ),
        .O(c5[11]));
  OBUF \c5_OBUF[12]_inst 
       (.I(\<const0> ),
        .O(c5[12]));
  OBUF \c5_OBUF[13]_inst 
       (.I(\<const0> ),
        .O(c5[13]));
  OBUF \c5_OBUF[14]_inst 
       (.I(\<const0> ),
        .O(c5[14]));
  OBUF \c5_OBUF[15]_inst 
       (.I(\<const0> ),
        .O(c5[15]));
  OBUF \c5_OBUF[1]_inst 
       (.I(\<const0> ),
        .O(c5[1]));
  OBUF \c5_OBUF[2]_inst 
       (.I(\<const0> ),
        .O(c5[2]));
  OBUF \c5_OBUF[3]_inst 
       (.I(\<const0> ),
        .O(c5[3]));
  OBUF \c5_OBUF[4]_inst 
       (.I(\<const0> ),
        .O(c5[4]));
  OBUF \c5_OBUF[5]_inst 
       (.I(\<const0> ),
        .O(c5[5]));
  OBUF \c5_OBUF[6]_inst 
       (.I(\<const0> ),
        .O(c5[6]));
  OBUF \c5_OBUF[7]_inst 
       (.I(\<const0> ),
        .O(c5[7]));
  OBUF \c5_OBUF[8]_inst 
       (.I(\<const0> ),
        .O(c5[8]));
  OBUF \c5_OBUF[9]_inst 
       (.I(\<const0> ),
        .O(c5[9]));
  OBUF \c6_OBUF[0]_inst 
       (.I(\<const0> ),
        .O(c6[0]));
  OBUF \c6_OBUF[10]_inst 
       (.I(\<const0> ),
        .O(c6[10]));
  OBUF \c6_OBUF[11]_inst 
       (.I(\<const0> ),
        .O(c6[11]));
  OBUF \c6_OBUF[12]_inst 
       (.I(\<const0> ),
        .O(c6[12]));
  OBUF \c6_OBUF[13]_inst 
       (.I(\<const0> ),
        .O(c6[13]));
  OBUF \c6_OBUF[14]_inst 
       (.I(\<const0> ),
        .O(c6[14]));
  OBUF \c6_OBUF[15]_inst 
       (.I(\<const0> ),
        .O(c6[15]));
  OBUF \c6_OBUF[1]_inst 
       (.I(\<const0> ),
        .O(c6[1]));
  OBUF \c6_OBUF[2]_inst 
       (.I(\<const0> ),
        .O(c6[2]));
  OBUF \c6_OBUF[3]_inst 
       (.I(\<const0> ),
        .O(c6[3]));
  OBUF \c6_OBUF[4]_inst 
       (.I(\<const0> ),
        .O(c6[4]));
  OBUF \c6_OBUF[5]_inst 
       (.I(\<const0> ),
        .O(c6[5]));
  OBUF \c6_OBUF[6]_inst 
       (.I(\<const0> ),
        .O(c6[6]));
  OBUF \c6_OBUF[7]_inst 
       (.I(\<const0> ),
        .O(c6[7]));
  OBUF \c6_OBUF[8]_inst 
       (.I(\<const0> ),
        .O(c6[8]));
  OBUF \c6_OBUF[9]_inst 
       (.I(\<const0> ),
        .O(c6[9]));
  OBUF \c7_OBUF[0]_inst 
       (.I(\<const0> ),
        .O(c7[0]));
  OBUF \c7_OBUF[10]_inst 
       (.I(\<const0> ),
        .O(c7[10]));
  OBUF \c7_OBUF[11]_inst 
       (.I(\<const0> ),
        .O(c7[11]));
  OBUF \c7_OBUF[12]_inst 
       (.I(\<const0> ),
        .O(c7[12]));
  OBUF \c7_OBUF[13]_inst 
       (.I(\<const0> ),
        .O(c7[13]));
  OBUF \c7_OBUF[14]_inst 
       (.I(\<const0> ),
        .O(c7[14]));
  OBUF \c7_OBUF[15]_inst 
       (.I(\<const0> ),
        .O(c7[15]));
  OBUF \c7_OBUF[1]_inst 
       (.I(\<const0> ),
        .O(c7[1]));
  OBUF \c7_OBUF[2]_inst 
       (.I(\<const0> ),
        .O(c7[2]));
  OBUF \c7_OBUF[3]_inst 
       (.I(\<const0> ),
        .O(c7[3]));
  OBUF \c7_OBUF[4]_inst 
       (.I(\<const0> ),
        .O(c7[4]));
  OBUF \c7_OBUF[5]_inst 
       (.I(\<const0> ),
        .O(c7[5]));
  OBUF \c7_OBUF[6]_inst 
       (.I(\<const0> ),
        .O(c7[6]));
  OBUF \c7_OBUF[7]_inst 
       (.I(\<const0> ),
        .O(c7[7]));
  OBUF \c7_OBUF[8]_inst 
       (.I(\<const0> ),
        .O(c7[8]));
  OBUF \c7_OBUF[9]_inst 
       (.I(\<const0> ),
        .O(c7[9]));
  OBUF \c8_OBUF[0]_inst 
       (.I(\<const0> ),
        .O(c8[0]));
  OBUF \c8_OBUF[10]_inst 
       (.I(\<const0> ),
        .O(c8[10]));
  OBUF \c8_OBUF[11]_inst 
       (.I(\<const0> ),
        .O(c8[11]));
  OBUF \c8_OBUF[12]_inst 
       (.I(\<const0> ),
        .O(c8[12]));
  OBUF \c8_OBUF[13]_inst 
       (.I(\<const0> ),
        .O(c8[13]));
  OBUF \c8_OBUF[14]_inst 
       (.I(\<const0> ),
        .O(c8[14]));
  OBUF \c8_OBUF[15]_inst 
       (.I(\<const0> ),
        .O(c8[15]));
  OBUF \c8_OBUF[1]_inst 
       (.I(\<const0> ),
        .O(c8[1]));
  OBUF \c8_OBUF[2]_inst 
       (.I(\<const0> ),
        .O(c8[2]));
  OBUF \c8_OBUF[3]_inst 
       (.I(\<const0> ),
        .O(c8[3]));
  OBUF \c8_OBUF[4]_inst 
       (.I(\<const0> ),
        .O(c8[4]));
  OBUF \c8_OBUF[5]_inst 
       (.I(\<const0> ),
        .O(c8[5]));
  OBUF \c8_OBUF[6]_inst 
       (.I(\<const0> ),
        .O(c8[6]));
  OBUF \c8_OBUF[7]_inst 
       (.I(\<const0> ),
        .O(c8[7]));
  OBUF \c8_OBUF[8]_inst 
       (.I(\<const0> ),
        .O(c8[8]));
  OBUF \c8_OBUF[9]_inst 
       (.I(\<const0> ),
        .O(c8[9]));
  OBUF \c9_OBUF[0]_inst 
       (.I(\<const0> ),
        .O(c9[0]));
  OBUF \c9_OBUF[10]_inst 
       (.I(\<const0> ),
        .O(c9[10]));
  OBUF \c9_OBUF[11]_inst 
       (.I(\<const0> ),
        .O(c9[11]));
  OBUF \c9_OBUF[12]_inst 
       (.I(\<const0> ),
        .O(c9[12]));
  OBUF \c9_OBUF[13]_inst 
       (.I(\<const0> ),
        .O(c9[13]));
  OBUF \c9_OBUF[14]_inst 
       (.I(\<const0> ),
        .O(c9[14]));
  OBUF \c9_OBUF[15]_inst 
       (.I(\<const0> ),
        .O(c9[15]));
  OBUF \c9_OBUF[1]_inst 
       (.I(\<const0> ),
        .O(c9[1]));
  OBUF \c9_OBUF[2]_inst 
       (.I(\<const0> ),
        .O(c9[2]));
  OBUF \c9_OBUF[3]_inst 
       (.I(\<const0> ),
        .O(c9[3]));
  OBUF \c9_OBUF[4]_inst 
       (.I(\<const0> ),
        .O(c9[4]));
  OBUF \c9_OBUF[5]_inst 
       (.I(\<const0> ),
        .O(c9[5]));
  OBUF \c9_OBUF[6]_inst 
       (.I(\<const0> ),
        .O(c9[6]));
  OBUF \c9_OBUF[7]_inst 
       (.I(\<const0> ),
        .O(c9[7]));
  OBUF \c9_OBUF[8]_inst 
       (.I(\<const0> ),
        .O(c9[8]));
  OBUF \c9_OBUF[9]_inst 
       (.I(\<const0> ),
        .O(c9[9]));
  OBUF done_o_OBUF_inst
       (.I(\<const0> ),
        .O(done_o));
endmodule
