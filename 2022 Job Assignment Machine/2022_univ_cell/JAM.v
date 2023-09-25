module JAM (
input CLK,
input RST,
output reg [2:0] W,
output reg [2:0] J,
input [6:0] Cost,
output reg [3:0] MatchCount,
output reg [9:0] MinCost,
output reg Valid );

parameter IDLE = 0;
parameter FIND = 1;
parameter SMALL = 2;
parameter TURN = 3;
parameter CALC = 4;
parameter OUT = 5;
parameter FINISH = 6;

reg [2:0] next_state,state;
reg[2:0] counter;
reg [2:0] change_point_index;
reg [2:0] dictionary [7:0];
reg [2:0] min_bigger_index;
reg [9:0] Cost_sum;
integer i,j;

always @(*) begin
    case (state)
        IDLE:next_state=CALC;
        FIND: //next_state=(dictionary[counter]<dictionary[counter-1])?SMALL:FIND;
        begin
        if(dictionary[counter]<dictionary[counter-1])
            next_state=SMALL;
        else if(counter == 3'd7 && !change_point_index)
            next_state=OUT;
        else
            next_state=FIND;
        end
        SMALL:begin
        if(counter==change_point_index)
            next_state=TURN;
        // else if(!change_point_index)
        //     next_state=OUT;
        else
            next_state=SMALL;
        end
        TURN:next_state=CALC;
        CALC:next_state=(counter == 3'd7)?FIND:CALC;
        OUT:next_state= FINISH;
        default: next_state = IDLE;
    endcase
end

always @(posedge CLK or posedge RST) begin
    if(RST)
        state<=3'b0;
    else 
        state<=next_state;
end



//counter
always @(posedge CLK or posedge RST ) begin
    if(RST)begin
        counter <= 3'b0;
    end
    else if(state == CALC && state != next_state)
        counter <=  3'd1 ; 
    else if( state != next_state)
        counter <=  3'd0 ; 
    else 
        counter <= counter == 3'd7 ? 3'd0 : counter + 3'd1;
    
    
end



//find_change_point

always @(posedge CLK or posedge RST ) begin
    if(RST)begin
        for (i = 0; i <= 3'd7; i=i+1)
            dictionary[i] <= 3'd7 - i;
    end
    else if(state == SMALL && counter == change_point_index  )begin //!check(-1)
        dictionary[min_bigger_index] <= dictionary[change_point_index];
        dictionary[change_point_index] <= dictionary[min_bigger_index];
    end
    else if(state == TURN)begin
            for( j=0; j<change_point_index; j=j+1)
                dictionary[j] <= dictionary[ change_point_index - j -3'd1];
    end
        

end

//change_point_index
always @(posedge CLK or posedge RST ) begin
    if(RST)begin
        change_point_index <= 3'd7;
    end
    else if( state == FIND && (dictionary[counter] < dictionary[counter - 1])) // find_change point
        change_point_index <= counter ;
    else if(state == CALC)
        change_point_index <= 3'd0;
    else 
        change_point_index <= change_point_index;
end


reg find_small_flag;
//min bigger
always @(posedge CLK or posedge RST ) begin
    if(RST)begin
        find_small_flag <= 1'd0;
    end
    else if (state == FIND)
        find_small_flag <= 1'b0;
    else if(state == SMALL && (dictionary[counter] > dictionary[change_point_index])) // find minimum bigger than change_number
        find_small_flag <= 1'b1;
end

//min bigger
always @(posedge CLK or posedge RST ) begin
    if(RST)begin
        min_bigger_index <= 3'd0;
    end
    else if (state == SMALL && !find_small_flag && (dictionary[counter] > dictionary[change_point_index]))
        min_bigger_index <= counter;        
    else if(state == SMALL && (dictionary[counter] > dictionary[change_point_index]) ) // find minimum bigger than change_number
        min_bigger_index <= dictionary[min_bigger_index] < dictionary[counter] ? min_bigger_index : counter;
end

//Cost_sum

always @(posedge CLK or posedge RST ) begin
    if(RST)begin
        Cost_sum <= 10'd1023;
    end
    else if (state == CALC && counter == 3'd0)
        Cost_sum <= Cost;
    else if(state == CALC) // 
        Cost_sum <= Cost_sum + Cost;
end

//MinCount


always @(posedge CLK or posedge RST ) begin
    if(RST)begin
        MinCost <= 10'd1023;
    end
    else if(state == FIND && counter == 3'd1)  
        MinCost <= MinCost < Cost_sum ? MinCost : Cost_sum;
end

//MatchCount
always @(posedge CLK or posedge RST ) begin
    if(RST)begin
        MatchCount <= 4'd1;
    end
    else if(state == FIND && counter == 3'd1)  
        MatchCount <=  MinCost > Cost_sum ? 4'd1 : (MinCost == Cost_sum ? MatchCount + 4'd1 : MatchCount);
end

//W
always @(posedge CLK or posedge RST ) begin
    if(RST)begin
        W <= 3'd0;
    end
    else if (state == CALC )
        W <= counter;

end

//J
always @(posedge CLK or posedge RST ) begin
    if(RST)begin
        J <= 3'd0;
    end
    else if (state == CALC )
        J <= dictionary[counter];

end

//valid
always @(posedge CLK or posedge RST ) begin
    if(RST)begin
        Valid <= 1'd0;
    end
    else if (state == OUT )
        Valid <= 1'b1;

end
endmodule


