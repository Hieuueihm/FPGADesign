module fifo_single_line_buffer #(
    parameter DEPTH
) (
    input clk,
    input rst,
    input we_i,
    input [7:0] data_i,
    // outputs
    output [7:0] data_o,
    output done_o
);

  reg [7:0] mem[0:DEPTH - 1];
  reg [9:0] wr_pointer;
  reg [9:0] rd_pointer;


  reg [9:0] i_counter;
  assign done_o = (i_counter == DEPTH) ? 1 : 0;
  assign data_o = mem[rd_pointer];
  // increment i_counter
  always @(posedge clk) begin
    if (rst) begin
      i_counter <= 0;
    end else begin
      if (we_i) begin
        i_counter <= (i_counter == DEPTH) ? i_counter : i_counter + 1;
      end

    end
  end

  // write process
  always @(posedge clk) begin
    if (rst) begin
      wr_pointer <= 0;
    end else begin
      if (we_i) begin
        mem[wr_pointer] <= data_i;
        wr_pointer <= (wr_pointer == DEPTH - 1) ? 0 : wr_pointer + 1;
      end

    end
  end

  // read process

  always @(posedge clk) begin
    if (rst) begin
      rd_pointer <= 0;
    end else begin
      if (we_i) begin
        if (i_counter == DEPTH) begin
          rd_pointer <= (rd_pointer == DEPTH - 1) ? 0 : rd_pointer + 1;
        end
      end

    end
  end







endmodule
