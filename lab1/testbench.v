`timescale 1ns/10ps

module testbench;

reg clk;
reg reset;
reg [2:0] sel;

wire [7:0]out;

initial begin
	$fsdbDumpfile("decoder.fsdb");
	$fsdbDumpvars;
	//$fsdbDumpMDA();
end

decoder decoder(.clk(clk),.reset(reset),.sel(sel),.out(out));

always begin
    #5 clk = ~clk;
end

initial begin
	clk <= 1'b1;
	reset <= 1'b0;
end

always @(posedge clk ) begin
	#10 reset <= 1'b1;
	#10 reset <= 1'b0;
	#10 sel <= 3'b000;
	#10 sel <= 3'b001;
	#10 sel <= 3'b010;
	#10 sel <= 3'b011;
	#10 sel <= 3'b100;
	#10 sel <= 3'b101;
	#10 sel <= 3'b110;
	#10 sel <= 3'b111;
	#20 $finish;
end

endmodule