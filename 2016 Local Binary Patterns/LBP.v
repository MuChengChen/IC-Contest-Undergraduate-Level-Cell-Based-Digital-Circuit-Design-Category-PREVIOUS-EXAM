
`timescale 1ns/10ps
module LBP ( clk, reset, gray_addr, gray_req, gray_ready, gray_data, lbp_addr, lbp_valid, lbp_data, finish);
input   	clk;
input   	reset;
output  [13:0] 	gray_addr;
output         	gray_req;
input   	gray_ready;
input   [7:0] 	gray_data;
output  [13:0] 	lbp_addr;
output  	lbp_valid;
output  [7:0] 	lbp_data;
output  	finish;
//====================================================================
reg [13:0]  gray_addr;
reg         gray_req;
reg [13:0]  lbp_addr;
reg         lbp_valid;
reg [7:0]   lbp_data;
reg         finish;                
reg [3:0]   block_counter;
reg [7:0]   mm,mm_lm,step_counter;

always @(posedge clk or posedge reset) begin
    if(reset)
        gray_addr<=0;
    else if(gray_ready && gray_addr==0 && block_counter==0)
        gray_addr<=129;
    else if(gray_ready && gray_addr!=0 && block_counter==0)
        gray_addr<=gray_addr-129;
    else if(gray_ready && block_counter==1)
        gray_addr<=gray_addr+1;
    else if(gray_ready && block_counter==2)
        gray_addr<=gray_addr+1;
    else if(gray_ready && block_counter==3 && step_counter==0)
        gray_addr<=gray_addr+126;
    else if(gray_ready && block_counter==3 && step_counter!=0)
        gray_addr<=gray_addr+128;
    else if(gray_ready && block_counter==4 )
        gray_addr<=gray_addr+2;
    else if(gray_ready && block_counter==5)
        gray_addr<=gray_addr+126;
    else if(gray_ready && block_counter==6)
        gray_addr<=gray_addr+1;
    else if(gray_ready && block_counter==7)
        gray_addr<=gray_addr+1;
    else if(gray_ready && block_counter==8 && step_counter!=125)
        gray_addr<=gray_addr-128;
    else if(gray_ready && block_counter==8 && step_counter==125)
        gray_addr<=gray_addr-126;
    else
        gray_addr<=gray_addr;
end
always @(posedge clk or posedge reset) begin
    if(reset)
        gray_req<=0;
    else if(gray_ready && gray_addr!=16383)
        gray_req<=1;
    else if(gray_ready && gray_addr==16383)
        gray_req<=0;
    else
        gray_req<=gray_req;
end
always @(posedge clk or posedge reset) begin
    if(reset)
        lbp_addr<=0;
    else if(block_counter==0)
        lbp_addr<=gray_addr;
    else
        lbp_addr<=lbp_addr;
end
always @(posedge clk or posedge reset) begin
    if(reset)
        lbp_valid<=0;
    else if(gray_addr!=0 && gray_addr!=129 && block_counter==8 && !finish)
        lbp_valid<=1;
    else if(finish)
        lbp_valid<=0;
    else
        lbp_valid<=0;
end
always @(posedge clk or posedge reset) begin
    if(reset)
        lbp_data<=0;
    else if(block_counter==1 && gray_data>=mm && step_counter==0)
        lbp_data<=1;
    else if(block_counter==1 && gray_data>=mm && mm_lm>=mm && step_counter!=0)
        lbp_data<=9;
    else if(block_counter==1 && gray_data>=mm && mm_lm<mm && step_counter!=0)
        lbp_data<=1;
    else if(block_counter==1 && gray_data<mm && mm_lm>=mm && step_counter!=0)
        lbp_data<=8;
    else if(block_counter==2 && gray_data>=mm)
        lbp_data<=lbp_data+2;
    else if(block_counter==3 && gray_data>=mm)
        lbp_data<=lbp_data+4;
    else if(block_counter==4 && gray_data>=mm && step_counter==0)
        lbp_data<=lbp_data+8;
    else if(block_counter==5 && gray_data>=mm)
        lbp_data<=lbp_data+16;
    else if(block_counter==6 && gray_data>=mm)
        lbp_data<=lbp_data+32;
    else if(block_counter==7 && gray_data>=mm)
        lbp_data<=lbp_data+64;
    else if(gray_addr!=0 && gray_addr!=129 && block_counter==8 && gray_data>=mm && !finish)
        lbp_data<=lbp_data+128;
    else if(block_counter==0)
        lbp_data<=0;
    else
        lbp_data<=lbp_data;
end
always @(posedge clk or posedge reset) begin
    if(reset)
        mm<=0;
    else if(gray_req && block_counter==0)
        mm<=gray_data;
    else
        mm<=mm;
end
always @(posedge clk or posedge reset) begin
    if(reset)
        mm_lm<=0;
    else if(gray_req && block_counter==0)
        mm_lm<=mm;
    else
        mm_lm<=mm_lm;
end
always @(posedge clk or posedge reset) begin
    if(reset)
        block_counter<=0;
    else if(gray_ready && (gray_addr!=0 || block_counter==1) && block_counter!=8 && block_counter!=3)
        block_counter<=block_counter+1;
    else if(block_counter==3 && step_counter==0)
        block_counter<=block_counter+1;
    else if(block_counter==3 && step_counter!=0)
        block_counter<=block_counter+2;
    else if(block_counter==8)
        block_counter<=0;
    else
        block_counter<=block_counter;
end
always @(posedge clk or posedge reset) begin
    if(reset)
        step_counter<=0;
    else if(block_counter==8 && step_counter!=125)
        step_counter<=step_counter+1;
    else if(block_counter==8 && step_counter==125)
        step_counter<=0;
    else 
        step_counter<=step_counter;
end
always @(posedge clk or posedge reset) begin
    if(reset)
        finish<=0;
    else if(lbp_addr==16254 && lbp_valid)
        finish<=1;
    else
        finish<=finish;
end




//====================================================================
endmodule
