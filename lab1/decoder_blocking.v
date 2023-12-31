module decoder (
	input clk,
	input reset,
	input [2:0] sel,
	output reg [7:0]out
);
///////////////modify your code///////////////
always@(*)
        if(reset)
                out=8'b00000000;
        else if(sel==3'b000)
                out=8'b00000001;
        else if(sel==3'b001)
                out=8'b00000010;
        else if(sel==3'b010)
                out=8'b00000100;
        else if(sel==3'b011)
                out=8'b00001000;
        else if(sel==3'b100)
                out=8'b00010000;
        else if(sel==3'b101)
                out=8'b00100000;
        else if(sel==3'b110)
                out=8'b01000000;
        else if(sel==3'b111)
                out=8'b10000000;
        else
                out=8'b00000000;


endmodule