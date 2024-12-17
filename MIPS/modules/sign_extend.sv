module sign_extend (
    input  [15:0] sign_in,
    output [31:0] SignImm
);
  assign SignImm = {{16{sign_in[15]}}, sign_in};

endmodule
