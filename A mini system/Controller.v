//*************************************************
//** Description: System controller
//*************************************************

`timescale 1ns/10ps

module Controller (clk, rst, ROM_A, ROM_OE,
  RAM_A, RAM_WE, RAM_OE, done);

  
  // You should complete this part

  input         clk;
  input         rst;
  output   reg  [13:0] ROM_A=14'b0;  //ROM address
  output   reg  ROM_OE; 
  output   reg  [15:0] RAM_A=16'h0;//RAM address
  output   reg  RAM_WE;
  output   reg  RAM_OE;
  output   reg  done;

reg	[1:0]state=2'b00;

parameter	INIT = 2'b00,
		READ = 2'b01,
		WRITE = 2'b10,
		FINAL = 2'b11;


always@(posedge clk or posedge rst)
	if(rst)
		state<=INIT;
	else if(state==INIT)
		state<=READ;
	else if(state==READ)
		state<=WRITE;
	else if(RAM_A!=16'hffff && state==WRITE)
		state<=READ;
	else if(RAM_A==16'hffff && state==WRITE)
		state<=FINAL;
	else
		state<=state;

always@(*)
	if(rst)
		ROM_OE=0;
	else if(state==INIT)
		ROM_OE=0;
	else if(state==READ)
		ROM_OE=1;
	else if(state==WRITE)
		ROM_OE=1;
	else if(state==FINAL)
		ROM_OE=0;
	else
		ROM_OE=ROM_OE;

always@(*)
	if(rst)
		RAM_WE=0;
	else if(state==INIT)
		RAM_WE=0;
	else if(state==READ)
		RAM_WE=0;
	else if(state==WRITE)
		RAM_WE=1;
	else if(state==FINAL)
		RAM_WE=0;
	else
		RAM_WE=RAM_WE;

always@(*)
	if(rst)
		RAM_OE=0;
	else if(state==INIT)
		RAM_OE=0;
	else if(state==READ)
		RAM_OE=1;
	else if(state==WRITE)
		RAM_OE=1;
	else if(state==FINAL)
		RAM_OE=0;
	else
		RAM_OE=RAM_OE;

always@(*)
	if(rst)
		done=0;
	else if(state==INIT)
		done=0;
	else if(state==READ)
		done=0;
	else if(state==WRITE)
		done=0;
	else if(state==FINAL)
		done=1;
	else
		done=done;

always@(*)
	if(rst)
		ROM_A=14'b0;
	else if(state==INIT)
		ROM_A=14'b0;
	else if(state==READ)
		ROM_A={RAM_A[15:9],RAM_A[7:1]};
	else if(state==WRITE)
		ROM_A=ROM_A;
	else if(state==FINAL)
		ROM_A=14'b0;
	else
		ROM_A=ROM_A;

always@(posedge clk or posedge rst)
	if(rst)
		RAM_A<=16'h0;
	else if(state==INIT)
		RAM_A<=16'h0;
	else if(state==READ)
		RAM_A<=RAM_A;
	else if(state==WRITE)
		RAM_A<=RAM_A+16'h0001;
	else if(state==FINAL)
		RAM_A<=16'h0;
	else
		RAM_A<=RAM_A;	
	

endmodule

