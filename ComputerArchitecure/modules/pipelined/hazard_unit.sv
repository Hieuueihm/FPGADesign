module hazard_unit (
    input [4:0] WriteRegM,
    WriteRegW,
    input RegWriteM,
    RegWriteW,
    input MemtoRegE,
    input [4:0] RsD,
    RtD,
    RsE,
    RtE,
    output [1:0] ForwardAE,
    ForwardBE,
    output StallF,
    StallD,
    FlushE

);
  assign ForwardAE = ((RsE) != 0 && (RsE == WriteRegM) && RegWriteM)  ? 2'b10  : 
                        ((RsE) !=0 && (RsE == WriteRegW) && RegWriteW) ? 2'b01 :  2'b00;
  assign ForwardBE = ((RtE) != 0 && (RtE == WriteRegM) && RegWriteM)  ? 2'b10  : 
                        ((RtE) !=0 && (RtE == WriteRegW) && RegWriteW) ? 2'b01 :  2'b00;

  wire lwstall;
  assign lwstall = (((RsD == RtE) || (RtD == RtE)) && MemtoRegE) ? 1'b1 : 1'b0;

  assign StallF  = lwstall;
  assign StallD  = lwstall;
  assign FlushE  = lwstall;




endmodule
