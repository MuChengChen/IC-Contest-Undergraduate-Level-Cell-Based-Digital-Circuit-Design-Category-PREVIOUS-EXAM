module ate00(clk,reset,pix_data,bin,threshold);

////////////////
//input&output//
////////////////

input 		 clk;
input 	     reset;
input [7:0]   pix_data;
output reg		 bin;
output reg   [7:0] threshold;

//////////////////////////////////
reg [7:0] pix_data_reg [63:0] ;
reg [7:0] threshold_min = 0,threshold_max = 0;
reg [7:0] point_counter = 0;
reg [5:0] block_counter = 0;
integer i;

always@(posedge clk or posedge reset)
	if(reset)
		point_counter <= 0;
	else if(point_counter==63)
		point_counter <= 0;
	else if(point_counter!=63)
		point_counter <= point_counter+1;
	else
		point_counter <= point_counter;

always@(posedge clk or posedge reset)
	if(reset)
		block_counter <= 0;
	else if(block_counter==23 && point_counter==63)
		block_counter <= 0;
	else if(point_counter==63 && block_counter!=23)
		block_counter <= block_counter+1;
	else
		block_counter <= block_counter;

always@(posedge clk or posedge reset)
	if(reset)
		for(i=0;i<64;i=i+1)
			pix_data_reg [i] <= 0;
	else if(block_counter==0 || block_counter==5 || block_counter==6 || block_counter==11  || block_counter==12  || block_counter==17  || block_counter==18  || block_counter==23 )
		pix_data_reg [point_counter] <= 0;
	else if(!(block_counter==0 || block_counter==5 || block_counter==6 || block_counter==11  || block_counter==12  || block_counter==17  || block_counter==18  || block_counter==23 ) && block_counter<24 )
		pix_data_reg [point_counter] <= pix_data;
	else
		for(i=0;i<64;i=i+1)
			pix_data_reg [i] <= pix_data_reg [i];

always@(posedge clk or posedge reset)
	if(reset)
		threshold_min <= 0;
	else if(!(block_counter==0 || block_counter==5 || block_counter==6 || block_counter==11  || block_counter==12  || block_counter==17  || block_counter==18  || block_counter==23) && point_counter==0)
		threshold_min <= pix_data;
	else if(block_counter==0 || block_counter==5 || block_counter==6 || block_counter==11  || block_counter==12  || block_counter==17  || block_counter==18  || block_counter==23 )
		threshold_min <= 0;
	else if(!(block_counter==0 || block_counter==5 || block_counter==6 || block_counter==11  || block_counter==12  || block_counter==17  || block_counter==18  || block_counter==23) && pix_data<threshold_min && point_counter!=0)
		threshold_min <= pix_data;
	else
		threshold_min <= threshold_min;

always@(posedge clk or posedge reset)
	if(reset)
		threshold_max <= 0;
	else if(!(block_counter==0 || block_counter==5 || block_counter==6 || block_counter==11  || block_counter==12  || block_counter==17  || block_counter==18  || block_counter==23) && point_counter==0)
		threshold_max <= pix_data;
	else if(block_counter==0 || block_counter==5 || block_counter==6 || block_counter==11  || block_counter==12  || block_counter==17  || block_counter==18  || block_counter==23)
		threshold_max <= 0;
	else if(!(block_counter==0 || block_counter==5 || block_counter==6 || block_counter==11  || block_counter==12  || block_counter==17  || block_counter==18  || block_counter==23) && pix_data>threshold_max && point_counter!=0)
		threshold_max <= pix_data;
	else
		threshold_max <= threshold_max;

always@(posedge clk or posedge reset)
	if(reset)
		bin <= 0;
	else if(threshold==0)
		bin <= 0;
	else if(pix_data_reg [point_counter]<threshold && point_counter!=0)
		bin <= 0;
	else if(pix_data_reg [point_counter]>=threshold && point_counter!=0)
		bin <= 1;
	else if(point_counter==0)
   	begin
		if(!(threshold_min==0 && threshold_max==0)  && ((threshold_min+threshold_max)%2==1))
         	begin
			if(pix_data_reg [point_counter]<(((threshold_min+threshold_max)/2)+1))
				bin <= 0;
			else if(pix_data_reg [point_counter]>=(((threshold_min+threshold_max)/2)+1))
				bin <= 1;
         	end
		else if(!(threshold_min==0 && threshold_max==0)  && (threshold_min+threshold_max)%2==0)
         	begin
			if(pix_data_reg [point_counter]<((threshold_min+threshold_max)/2))
				bin <= 0;
			else if(pix_data_reg [point_counter]>=((threshold_min+threshold_max)/2))
				bin <= 1;
         	end
		else if(threshold_min==0 && threshold_max==0)
			bin <= 0;
   	end
	else
		bin <= 0;

always@(posedge clk or posedge reset)
	if(reset)
		threshold <= 0;
	else if(point_counter==0)
   	begin
		if((threshold_min+threshold_max)%2==1)
			threshold <= ((threshold_min+threshold_max)/2)+1;
		else
			threshold <= (threshold_min+threshold_max)/2;
   	end
	else
		threshold <= threshold;

endmodule