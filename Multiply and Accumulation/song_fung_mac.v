module mac(in_a, in_b, in_valid_a, in_valid_b, clk, 
			reset, mac_out, out_valid);

//input output declartion			
input signed [3:0] 	 in_a, in_b;
input 			     in_valid_a, in_valid_b;
input			     clk, reset;
output signed [10:0] mac_out;
output 		         out_valid;
/////////////////////////////////////////////

reg out_valid = 1'b0;
reg if_aInvalid = 1'b0; //標記a已經有一筆valid的數據
reg if_bInvalid = 1'b0; //標記b已經有一筆valid的數據
reg signed [10:0] mac_out = 11'b0;
reg signed [10:0] mul = 11'b0;
reg signed [4:0] in_a_ex = 5'b0;
reg signed [4:0] in_b_ex = 5'b0;
reg [3:0] counter = 4'b0; //算mac計算了幾次


//counter
always@( posedge clk or posedge reset) begin
	if(reset)begin
		counter <= 4'b0;
	end 
	else if(counter === 4'b1000 )
		if(if_aInvalid && if_bInvalid)
			counter <= 4'b1;
		else
			counter <= 4'b0;
	else if(if_aInvalid && if_bInvalid) begin
		counter <=  counter + 4'b1;
	end
	
end



always@( posedge clk or posedge reset) begin //deal with input，avoid overflow, extentend a&b
	if(reset)begin
		in_a_ex <= 5'b0;
	end 
	else if(in_valid_a) begin
		in_a_ex <= { in_a[3], in_a[3:0]};
		if_aInvalid <= 1'b1;

	end else if(if_aInvalid && if_bInvalid) begin
		if_aInvalid <= 1'b0;
	end
	
end

always@( posedge clk or posedge reset) begin
	if(reset)begin
		in_b_ex <= 5'b0;
	end 
	else if( in_valid_b) begin
		in_b_ex <= { in_b[3], in_b[3:0]};
		if_bInvalid <= 1'b1;
	end else if(if_aInvalid && if_bInvalid) begin
		if_bInvalid <= 1'b0;
	end
	
end


//calculate mac_out
always@ (posedge clk or posedge reset) begin
	if(reset)begin
		mac_out <= 10'b0;	
	end 
	else if(counter < 4'b1000 && if_aInvalid  && if_bInvalid )begin
		mul <= mul + in_a_ex *in_b_ex;
	end 
	else if( counter === 4'b1000) begin
		mac_out <= mul;

		if(if_aInvalid  && if_bInvalid )
		mul <= in_a_ex *in_b_ex;
		else
		mul <= 10'b0;

		
	end
end

//out_valid
always@(posedge clk or posedge reset) begin
	if(reset)begin
		out_valid <= 1'b0;
	end 
	else if(counter < 4'b1000 )begin
		out_valid <= 1'b0 ; 
	end 
	else if( counter === 4'b1000) begin
		out_valid <= 1'b1 ; 
		
	end
end






endmodule