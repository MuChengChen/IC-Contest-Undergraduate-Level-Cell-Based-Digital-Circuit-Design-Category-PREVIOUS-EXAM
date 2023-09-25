module mac(in_a, in_b, in_valid_a, in_valid_b, clk, 
			reset, mac_out, out_valid);

//input output declartion			
input signed [3:0]   in_a, in_b;
input 	         in_valid_a, in_valid_b;
input			   clk, reset;
output signed [10:0] mac_out;
output 		   out_valid;
/////////////////////////////////////////////

reg signed [3:0] in_a_reg=0,in_b_reg=0;
reg	     [3:0] mul_counter_reg=0,add_counter_reg=0;
reg              in_valid_a_reg=0, in_valid_b_reg=0 ,add_valid=0,out_valid_reg=0;
reg signed [10:0] multiply_reg=0,add_output_reg=0;


always @(posedge clk)
	if(reset)
		in_valid_a_reg<=0;
	else if(in_valid_a)
		in_valid_a_reg<=1;
	else if(!in_valid_a && (in_valid_a_reg && in_valid_b_reg))
		in_valid_a_reg<=0;
	else 
		in_valid_a_reg<=in_valid_a_reg;

always @(posedge clk)
	if(reset)
		in_valid_b_reg<=0;
	else if(in_valid_b)
		in_valid_b_reg<=1;
	else if(!in_valid_b && (in_valid_a_reg && in_valid_b_reg))
		in_valid_b_reg<=0;
	else 
		in_valid_b_reg<=in_valid_b_reg;

always @(posedge clk)
	if(reset)
		in_a_reg<=0;
	else if(in_valid_a)
		in_a_reg<=in_a;
	else if(!in_valid_a && (in_valid_a_reg && in_valid_b_reg))
		in_a_reg<=0;
	else 
		in_a_reg<=in_a_reg;

always @(posedge clk)
	if(reset)
		in_b_reg<=0;
	else if(in_valid_b)
		in_b_reg<=in_b;
	else if(!in_valid_b && (in_valid_a_reg && in_valid_b_reg))
		in_b_reg<=0;
	else 
		in_b_reg<=in_b_reg;


always @(posedge clk)
	if(reset)
		multiply_reg<=0;
	else if(in_valid_a_reg && in_valid_b_reg)
		multiply_reg<=in_a_reg*in_b_reg;
	else if(in_valid_a_reg==0 || in_valid_b_reg==0)
		multiply_reg<=0;
	else
		multiply_reg<=multiply_reg;

always @(posedge clk)
	if(reset)
		add_valid<=0;
	else if(in_valid_a_reg && in_valid_b_reg)
		add_valid<=1;
	else if(in_valid_a_reg==0 || in_valid_b_reg==0)
		add_valid<=0;
	else
		add_valid<=0;

always @(posedge clk)
	if(reset)
		mul_counter_reg<=0;
	else if((in_valid_a_reg && in_valid_b_reg) && mul_counter_reg!=8)
		mul_counter_reg<=mul_counter_reg+1;
	else if((in_valid_a_reg && in_valid_b_reg) && mul_counter_reg==8)
		mul_counter_reg<=1;
	else if(!(in_valid_a_reg && in_valid_b_reg) && mul_counter_reg==8)
		mul_counter_reg<=0;
	else
		mul_counter_reg<=mul_counter_reg;

always @(posedge clk)
	add_counter_reg<=mul_counter_reg;

always @(posedge clk)
	if(reset)
		add_output_reg<=0;
	else if(add_valid && add_counter_reg!=8)
		add_output_reg<=add_output_reg+multiply_reg;
	else if(add_valid && add_counter_reg==8)
		add_output_reg<=multiply_reg;
	else if(!add_valid && add_counter_reg==8)
		add_output_reg<=0;
	else
		add_output_reg<=add_output_reg;

always @(posedge clk)
	if(reset)
		out_valid_reg<=0;
	else if(mul_counter_reg!=8)
		out_valid_reg<=0;
	else if(mul_counter_reg==8)
		out_valid_reg<=1;
	else
		out_valid_reg<=0;

assign mac_out=add_output_reg;
assign out_valid=out_valid_reg;

	
endmodule
