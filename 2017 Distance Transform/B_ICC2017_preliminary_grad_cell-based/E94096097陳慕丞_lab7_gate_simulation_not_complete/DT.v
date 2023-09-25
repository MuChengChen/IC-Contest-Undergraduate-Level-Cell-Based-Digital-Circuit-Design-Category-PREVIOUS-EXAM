module DT(
	input 			clk, 
	input			reset,
	output	reg		done ,
	output	reg		sti_rd ,
	output	reg 	[9:0]	sti_addr ,
	input		[15:0]	sti_di,
	output	reg		res_wr ,
	output	reg		res_rd ,
	output	reg 	[13:0]	res_addr ,
	output	reg 	[7:0]	res_do,
	input		[7:0]	res_di
	);

reg [2:0] block_counter; 
reg forward_0_backward_1,switch_sti_addr;
wire sti_a;
assign sti_a=sti_di[15-res_addr[3:0]];
wire [7:0] res_di_add;
assign res_di_add=res_di+1;
wire [13:0] res_addr_add1;
assign res_addr_add1=res_addr+1;

always @(posedge clk or negedge reset) begin
	if(!reset)
		switch_sti_addr<=0;
    else if(block_counter==0 && res_addr[3:0]==15 && sti_a==0  && sti_addr<=1022 && res_addr>=128 && res_addr<=16255 && !forward_0_backward_1 )
		switch_sti_addr<=1;
	else
		switch_sti_addr<=0;
end
always @(posedge clk or negedge reset) begin
	if(!reset)
		block_counter<=0;
	else if(res_wr)
		block_counter<=0;//f:object pixel,sti_di==0 or sti_di==1 and whether_in_continue_block==1 finish //b:object pixel
	else if(switch_sti_addr)
		block_counter<=0;//f:object pixel,sti_di==0 or sti_di==1 and whether_in_continue_block==1 finish //b:object pixel
	else if(block_counter==1 && res_di==0 && forward_0_backward_1)
		block_counter<=0;//f:object pixel,sti_di==0 or sti_di==1 and whether_in_continue_block==1 finish //b:object pixel
	else if(block_counter==0 && sti_a!=0 && !switch_sti_addr )
		block_counter<=1;//f:NW 
	else if(block_counter==0 && forward_0_backward_1)
		block_counter<=1;//f:NW 
	else if(block_counter==1)
		block_counter<=2;//f:N 
	else if(block_counter==2)
		block_counter<=3;
	else if(block_counter==3 )
		block_counter<=4;//f:W or (whether_in_continue_block==2 || whether_in_continue_block==3) finish 
	else if(block_counter==4 )
		block_counter<=5;//f:normal finish 
	else if(block_counter==5)
		block_counter<=6;//f:have 0 finish //b:normal finish
	else
		block_counter<=block_counter;
end
always @(posedge clk or negedge reset) begin
	if(!reset)
		sti_rd<=0;
	else if(!forward_0_backward_1)
		sti_rd<=1;
	else if(forward_0_backward_1)
		sti_rd<=0;
	else
		sti_rd<=sti_rd;
end
always @(posedge clk or negedge reset) begin
	if(!reset)
		sti_addr<=0;
	else if(block_counter==0 && res_addr[3:0]==15 && sti_addr<=1022 && !forward_0_backward_1 )
		sti_addr<=sti_addr+1;
	else 
		sti_addr<=sti_addr;
end
always @(negedge clk or negedge reset) begin
	if(!reset)
		res_wr<=0;
	else if(block_counter==0 && sti_a==0 && !switch_sti_addr && !forward_0_backward_1)
		res_wr<=1;
	else if(block_counter==6)
		res_wr<=1;
	else
		res_wr<=0;
end
always @(posedge clk or negedge reset) begin
	if(!reset)
		res_rd<=0;
	else
		res_rd<=1;
end
always @(posedge clk or negedge reset) begin
	if(!reset)
		res_addr<=0;
	else if(switch_sti_addr)
		res_addr<=res_addr;
	else if(block_counter==2 )
		res_addr<=res_addr_add1;
	else if(block_counter==3 )
		res_addr<=res_addr_add1;
    else if(block_counter==0 && res_addr==0 && !res_wr && !forward_0_backward_1)
		res_addr<=0;
	else if(block_counter==0 && sti_a==0 && !switch_sti_addr && !forward_0_backward_1)
		res_addr<=res_addr_add1;
	else if(block_counter==0 && sti_a!=0 && !switch_sti_addr && !forward_0_backward_1)
		res_addr<=res_addr-129;
	else if(block_counter==5 && !forward_0_backward_1)
		res_addr<=res_addr_add1;
	else if(block_counter==6 && !forward_0_backward_1)
		res_addr<=res_addr_add1;
	else if(block_counter==4 && !forward_0_backward_1)
		res_addr<=res_addr+126;
	else if(block_counter==0 && res_addr==16383 && res_wr && !forward_0_backward_1)
		res_addr<=16254;
	else if(res_addr==129 && res_wr && forward_0_backward_1)
		res_addr<=res_addr;
	else if(res_addr[6:0]==0 && res_wr && forward_0_backward_1)
		res_addr<=res_addr-2;
	else if(block_counter==1 && res_di==0 && forward_0_backward_1)
		res_addr<=res_addr-1;
	else if(block_counter==5 && forward_0_backward_1)
		res_addr<=res_addr-1;
	else if(block_counter==6 && forward_0_backward_1)
		res_addr<=res_addr-1;
	else if(block_counter==1 && forward_0_backward_1)//block_counter==1 still at object pixel 
		res_addr<=res_addr+127;
	else if(block_counter==4 && forward_0_backward_1)
		res_addr<=res_addr-128;
	else
		res_addr<=res_addr;
end
always @(negedge clk or negedge reset) begin
	if(!reset)
		res_do<=0;
	else if(block_counter==0 && !switch_sti_addr && sti_a==0  && !forward_0_backward_1)
		res_do<=0;
	else if(block_counter==2 && !forward_0_backward_1)
		res_do<=res_di_add;
	else if(block_counter==1 && forward_0_backward_1)
		res_do<=res_di;
	else if(block_counter==3 && res_di<res_do )
		res_do<=res_di_add;
	else if(block_counter==4 && res_di<res_do )
		res_do<=res_di_add;
	else if(block_counter==5 && res_di<res_do)
		res_do<=res_di_add;
	else if(block_counter==6 && res_di<res_do)
		res_do<=res_di_add;
	else
		res_do<=res_do;
end

always @(posedge clk or negedge reset) begin
	if(!reset)
		forward_0_backward_1<=0;
	else if(res_addr==16383 && res_wr)
		forward_0_backward_1<=1;
	else
		forward_0_backward_1<=forward_0_backward_1;
end
always @(posedge clk or negedge reset) begin
	if(!reset)
		done<=0;
	else if(res_addr==129 && (res_wr || (block_counter==1 && res_di==0)) && forward_0_backward_1)
		done<=1;
	else
		done<=done;
end
endmodule
