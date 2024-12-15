module register_file (
    input clk,
    input rst,
    input [4:0] A1,A2, A3, // address of source and destination
    input [31:0] WD3,
    output [31:0] RD1, RD2

);

    reg [31:0] Registers [31:0];


    assign RD1 = (rst == 1'b1) ? 32'b0 : Register[A1];
    assign RD2 = (rst == 1'b1) ? 32'b0 : Register[A2];


    always @(posedge clk) begin
        if(WE3) begin
            Register[A3] <= WD3;
            
        end
    end

    
endmodule