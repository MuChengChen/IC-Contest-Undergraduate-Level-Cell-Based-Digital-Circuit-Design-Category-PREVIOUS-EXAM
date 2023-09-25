module STI_DAC(clk ,reset, load, pi_data, pi_length, pi_fill, pi_msb, pi_low, pi_end,
	       so_data, so_valid,
	       oem_finish, oem_dataout, oem_addr,
	       odd1_wr, odd2_wr, odd3_wr, odd4_wr, even1_wr, even2_wr, even3_wr, even4_wr);

input		clk, reset;
input		load, pi_msb, pi_low, pi_end; 
input	[15:0]	pi_data;
input	[1:0]	pi_length;
input		pi_fill;
output		so_data, so_valid;

output  oem_finish, odd1_wr, odd2_wr, odd3_wr, odd4_wr, even1_wr, even2_wr, even3_wr, even4_wr;
output [4:0] oem_addr;
output [7:0] oem_dataout;

//==============================================================================
reg so_data;
reg so_valid;

reg oem_finish;
reg odd1_wr;
reg odd2_wr;
reg odd3_wr;
reg odd4_wr;
reg even1_wr;
reg even2_wr;
reg even3_wr;
reg even4_wr;
reg [4:0] oem_addr;
reg [7:0] oem_dataout;

reg [2:0] state ;
reg [2:0] next_state;

reg [15:0] pi_data_reg ;
reg [1:0] pi_length_reg;
reg pi_low_reg;
reg pi_fill_reg;
reg pi_msb_reg;

reg [7:0] pi_length_0_reg;
//reg [15:0] pi_length_1_reg;
reg [23:0] pi_length_2_reg;
reg [31:0] pi_length_3_reg ;

reg [8:0] mem_count;
reg [5:0] so_mem_count;

reg load_counter;
reg load_flag;

always @(posedge clk or posedge reset) begin
	if(reset)
		load_flag <= 0;
	else
		load_flag <= load;
end


integer n;

parameter IDLE = 0;
parameter GET_DATA = 1;
parameter PI_LOW = 2;
parameter PI_FILL = 3;
parameter PI_MSB = 4;
parameter STORE = 5;
parameter SO_OUT = 6;
parameter STORE_0 = 7;


always @(posedge clk or posedge reset) begin
	if(reset)
		load_counter <= 0;
	else if ((state == STORE || state == STORE_0 ))
		load_counter <= !load_counter;
	else if (state == SO_OUT && (!so_valid))
		load_counter <= load_counter + 1;
	else 
		load_counter <= 0;
end


always @(*) begin
	case(state)
		IDLE:next_state=GET_DATA;
		GET_DATA:begin
			if(load_flag && pi_length==0)
				next_state=PI_LOW;
			else if(load_flag && pi_length==1)
				next_state=PI_MSB;
			else if(load_flag && (pi_length==2 || pi_length==3))
				next_state=PI_FILL;
			else if(!load_flag && mem_count!=255)
				next_state=STORE_0;
			else
				next_state=GET_DATA;
		end
		PI_LOW:next_state=PI_MSB;
		PI_FILL:next_state=PI_MSB;
		PI_MSB:next_state=STORE;
		STORE:next_state=(so_mem_count>=pi_length_reg && (!load_counter)) ?SO_OUT:STORE;
		SO_OUT:next_state=(so_mem_count==0 && load_counter )?GET_DATA:SO_OUT;
		STORE_0:next_state=STORE_0;
		default:next_state=IDLE;
	endcase
end




always @(posedge clk or posedge reset) begin
	if(reset)
		state<=IDLE;
	else
		state<=next_state;
end

always @(posedge clk or posedge reset) begin
	if(reset)
		pi_length_reg<=0;
	else if(state==GET_DATA)
		pi_length_reg<=pi_length;
	else
		pi_length_reg<=pi_length_reg;
end

always @(posedge clk or posedge reset) begin
	if(reset)
		pi_low_reg<=0;
	else if(state==GET_DATA)
		pi_low_reg<=pi_low;
	else
		pi_low_reg<=pi_low_reg;
end

always @(posedge clk or posedge reset) begin
	if(reset)
		pi_msb_reg<=0;
	else if(state==GET_DATA)
		pi_msb_reg<=pi_msb;
	else
		pi_msb_reg<=pi_msb_reg;
end

always @(posedge clk or posedge reset) begin
	if(reset)
		pi_fill_reg<=0;
	else if(state==GET_DATA)
		pi_fill_reg<=pi_fill;
	else
		pi_fill_reg<=pi_fill_reg;
end

always @(posedge clk or posedge reset) begin
	if(reset)
		pi_data_reg<=0;
	else if(state==GET_DATA)
		pi_data_reg<=pi_data;
	else if(state==PI_MSB && !pi_msb_reg && pi_length_reg==1)begin
		for(n = 0; n < 16; n=n+1)begin
			pi_data_reg[n] <= pi_data_reg[15-n];
		end
	end
	else
		pi_data_reg<=pi_data_reg;
end

always @(posedge clk or posedge reset) begin
	if(reset)
		pi_length_0_reg<=0;
	else if(state==PI_LOW && pi_low_reg)
		pi_length_0_reg<=pi_data_reg[15:8];
	else if(state==PI_LOW && !pi_low_reg)
		pi_length_0_reg<=pi_data_reg[7:0];
	else if(state==PI_MSB && !pi_msb_reg && pi_length_reg==0)begin
		for(n = 0; n < 8; n=n+1)begin
			pi_length_0_reg[n] <= pi_length_0_reg[7-n];
		end
	end
	else
		pi_length_0_reg<=pi_length_0_reg;

end

always @(posedge clk or posedge reset) begin
	if(reset)
		pi_length_2_reg<=0;
	else if(state==PI_FILL && pi_length_reg==2 && pi_fill_reg)
		pi_length_2_reg<={pi_data_reg,{8{1'b0}}};
	else if(state==PI_FILL && pi_length_reg==2 && !pi_fill_reg)
		pi_length_2_reg<={{8{1'b0}},pi_data_reg};
	else if(state==PI_MSB && !pi_msb_reg && pi_length_reg==2)begin
		for(n = 0; n < 24; n=n+1)begin
			pi_length_2_reg[n] <= pi_length_2_reg[23 - n];
		end
	end
	else
		pi_length_2_reg<=pi_length_2_reg;
end

always @(posedge clk or posedge reset) begin
	if(reset)
		pi_length_3_reg<=0;
	else if(state==PI_FILL && pi_length_reg==3 && pi_fill_reg)
		pi_length_3_reg<={pi_data_reg,{16{1'b0}}};
	else if(state==PI_FILL && pi_length_reg==3 && !pi_fill_reg)
		pi_length_3_reg<={{16{1'b0}},pi_data_reg};
	else if(state==PI_MSB && !pi_msb_reg && pi_length_reg==3)begin
		for(n = 0; n < 32; n=n+1)begin
			pi_length_3_reg[n] <= pi_length_3_reg[31-n];
		end
	end
	else
		pi_length_3_reg<=pi_length_3_reg;
end

always @(posedge clk or posedge reset) begin
	if(reset)
		mem_count<=0;
	else if( (state==STORE || state == STORE_0) && load_counter)//!
		mem_count<=mem_count;
	else if(state==STORE || state == STORE_0)
		mem_count<=mem_count+1;
	
	else
		mem_count<=mem_count;
end

always @(posedge clk or posedge reset) begin
	if(reset)
		so_mem_count<=0;

	else if(state==STORE && so_mem_count==0 && pi_length_reg==0 && !load_counter)
		so_mem_count<=8;
	else if(state==STORE && so_mem_count==1 && pi_length_reg==1 && !load_counter)
		so_mem_count<=16;
	else if(state==STORE && so_mem_count==2 && pi_length_reg==2 && !load_counter)
		so_mem_count<=24;
	else if(state==STORE && so_mem_count==3 && pi_length_reg==3 && !load_counter)
		so_mem_count<=32;
	else if((state == STORE || state == STORE_0 ) && load_counter)//!
		so_mem_count <= so_mem_count;
	else if(state==STORE)
		so_mem_count<=so_mem_count+1;
	else if(state==SO_OUT && so_mem_count!=0)
		so_mem_count<=so_mem_count-1;
	else
		so_mem_count<=so_mem_count;
end

always @(posedge clk or posedge reset) begin
	if(reset)
		oem_addr<=0;
	else if(state==STORE|| state == STORE_0)
		oem_addr<=(mem_count[5:1]);
	
	else 
		oem_addr<=oem_addr;
end

always @(posedge clk or posedge reset) begin
	if(reset)
		oem_dataout<=0;
	else if(state==STORE && pi_length_reg==0)
		oem_dataout<=pi_length_0_reg;
	else if(state==STORE && pi_length_reg==1)begin
			for(n = 0; n < 8 ; n=n+1)begin
				oem_dataout[n] <= pi_data_reg[(8-(so_mem_count<<3)) + n];
		end
		end
		//oem_dataout<=pi_data_reg[(15-(so_mem_count<<3)):(15-(so_mem_count<<3)-7)];
	else if(state==STORE && pi_length_reg==2)begin
			for(n = 0; n < 8 ; n=n+1)begin
				oem_dataout[n] <= pi_length_2_reg[(16-(so_mem_count<<3)) + n];
		end
		end
		//oem_dataout<=pi_length_2_reg[(23-(so_mem_count<<3)):(23-(so_mem_count<<3)-7)];
	else if(state==STORE && pi_length_reg==3)begin
			for(n = 0; n < 8 ; n=n+1)begin
				oem_dataout[n] <= pi_length_3_reg[(24-(so_mem_count<<3)) + n];
		end
		end
		//oem_dataout<=pi_length_3_reg[(31-(so_mem_count<<3)):(31-(so_mem_count<<3)-7)];
	else if(state==STORE_0)
		oem_dataout<=0;
	else
		oem_dataout<=0;
end

wire [4:0] mem_count_shift;
assign mem_count_shift = mem_count>>3;

always @(posedge clk or posedge reset) begin
	if(reset)
		odd1_wr<=0;
	else if((state == STORE || state == STORE_0 ) && load_counter)
		odd1_wr <=0;
	else if((state==STORE || state==STORE_0) && (mem_count>>6)==0 && ((!mem_count[0] && (mem_count_shift[0]==0) || (mem_count[0] && (mem_count_shift[0]==1)))) )
		odd1_wr<=1;
	else 
		odd1_wr<=0;
end

always @(posedge clk or posedge reset) begin
	if(reset)
		odd2_wr<=0;
	else if((state == STORE || state == STORE_0 ) && load_counter)
		odd2_wr <=0;
	else if((state==STORE || state==STORE_0) && (mem_count>>6)==1 && ((!mem_count[0] && (mem_count_shift[0]==0) || (mem_count[0] && (mem_count_shift[0]==1)))))
		odd2_wr<=1;
	else 
		odd2_wr<=0;
end

always @(posedge clk or posedge reset) begin
	if(reset)
		odd3_wr<=0;
	else if((state == STORE || state == STORE_0 ) && load_counter)
		odd3_wr <=0;
	else if((state==STORE || state==STORE_0) && (mem_count>>6)==2 && ((!mem_count[0] && (mem_count_shift[0]==0) || (mem_count[0] && (mem_count_shift[0]==1)))))
		odd3_wr<=1;
	else 
		odd3_wr<=0;
end

always @(posedge clk or posedge reset) begin
	if(reset)
		odd4_wr<=0;
	else if((state == STORE || state == STORE_0 ) && load_counter)
		odd4_wr <=0;
	else if((state==STORE || state==STORE_0) && (mem_count>>6)==3 && ((!mem_count[0] && (mem_count_shift[0]==0) || (mem_count[0] && (mem_count_shift[0]==1)))))
		odd4_wr<=1;
	else 
		odd4_wr<=0;
end

always @(posedge clk or posedge reset) begin
	if(reset)
		even1_wr<=0;
	else if((state == STORE || state == STORE_0 ) && load_counter)
		even1_wr <=0;
	else if((state==STORE || state==STORE_0) && (mem_count>>6)==0 && ((!mem_count[0] && (mem_count_shift[0]==1) ) || (mem_count[0] && (mem_count_shift[0]==0))))
		even1_wr<=1;
	else 
		even1_wr<=0;
end

always @(posedge clk or posedge reset) begin
	if(reset)
		even2_wr<=0;
	else if((state == STORE || state == STORE_0 ) && load_counter)
		even2_wr <=0;
	else if((state==STORE || state==STORE_0) && (mem_count>>6)==1 && ((!mem_count[0] && (mem_count_shift[0]==1)) || (mem_count[0] && (mem_count_shift[0]==0))))
		even2_wr<=1;
	else 
		even2_wr<=0;
end

always @(posedge clk or posedge reset) begin
	if(reset)
		even3_wr<=0;
	else if((state == STORE || state == STORE_0 ) && load_counter)
		even3_wr <=0;
	else if((state==STORE || state==STORE_0) && (mem_count>>6)==2 && ((!mem_count[0] && (mem_count_shift[0]==1)) || (mem_count[0] && (mem_count_shift[0]==0))))
		even3_wr<=1;
	else 
		even3_wr<=0;
end

always @(posedge clk or posedge reset) begin
	if(reset)
		even4_wr<=0;
	else if((state == STORE || state == STORE_0 ) && load_counter)
		even4_wr <=0;
	else if((state==STORE || state==STORE_0) && (mem_count>>6)==3 && ((!mem_count[0] && (mem_count_shift[0]==1)) || (mem_count[0] && (mem_count_shift[0]==0))))
		even4_wr<=1;
	else 
		even4_wr<=0;
end

always @(posedge clk or posedge reset) begin
	if (reset)
		oem_finish<=0; 
	else if(mem_count==256)
		oem_finish<=1;
	else
		oem_finish<=0;
end

always @(posedge clk or posedge reset) begin
	if(reset)
		so_valid<=0;
	else if(so_mem_count==0)
		so_valid<=0;
	else if(state==SO_OUT)
		so_valid<=1;

	else 
		so_valid <= 0;
end

always @(posedge clk or posedge reset) begin
	if(reset)
		so_data<=0;
	else if(next_state==SO_OUT && pi_length_reg==0 )//&& (so_mem_count >= 1)
		so_data<=pi_length_0_reg[so_mem_count-1];
	else if(next_state==SO_OUT && pi_length_reg==1 )//&& (so_mem_count >= 1)
		so_data<=pi_data_reg[so_mem_count-1];
	else if(next_state==SO_OUT && pi_length_reg==2 )//&& (so_mem_count >= 1)
		so_data<=pi_length_2_reg[so_mem_count-1];
	else if(next_state==SO_OUT && pi_length_reg==3 )//&& (so_mem_count >= 1)
		so_data<=pi_length_3_reg[so_mem_count-1];
	else
		so_data<=0;
end

endmodule
