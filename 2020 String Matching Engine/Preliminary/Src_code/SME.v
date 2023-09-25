module SME(clk,reset,chardata,isstring,ispattern,valid,match,match_index);
input clk;
input reset;
input [7:0] chardata;
input isstring;
input ispattern;
output match;
output [4:0] match_index;
output valid;

reg match;
reg [4:0] match_index;
reg valid;

reg [7:0] string [0:31];
reg [7:0] pattern [0:8];
reg if_pattern;
reg hat_flag;// begginning is " ^ "
reg pre_hat_flag;

always @(posedge clk or posedge reset) begin
    if(reset)
        pre_hat_flag <=0;
    else
        pre_hat_flag <= hat_flag;
end

reg dot_front_flag;
reg money_flag;

reg [5:0] string_counter;
reg [3:0] pattern_counter;

reg [1:0] state;
reg [1:0] next_state;

integer i=0;

parameter IDLE = 0;
parameter STORE = 1;
parameter MATCH = 2;
parameter FINISH = 3;

always @(*) begin
    case(state)
        IDLE:next_state=STORE;
        STORE:begin
            if(isstring)
                next_state=STORE;
            else if(!isstring && !ispattern && !if_pattern)
                next_state=FINISH;
            else if((!isstring && !ispattern && if_pattern) || pattern_counter==8 )//|| chardata==36
                next_state=MATCH;
            else
                next_state=STORE; 
        end
        MATCH:next_state=(valid)?STORE:MATCH;
        FINISH:next_state=FINISH;
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
        if_pattern<=0;
    else if(ispattern )
        if_pattern<=1;
    else if(valid)
        if_pattern<=0;

    else
        if_pattern<=if_pattern;
end

always @(posedge clk or posedge reset) begin
    if(reset)
        for (i = 0;i<32 ; i=i+1) begin
            string[i]<=0;
        end
    else if(state==STORE && isstring && string_counter==1)begin
        string[string_counter]<=chardata;
        for (i = 2;i<32 ; i=i+1) begin
            string[i]<=0;
        end
    end
    else if(state==STORE && isstring && string_counter==0)begin
        string[string_counter]<=chardata;
        for (i = 1;i<32 ; i=i+1) begin
            string[i]<=0;
        end
    end
    else if(isstring && valid)begin
        string[0]<=chardata;
        for (i = 1;i<32 ; i=i+1) begin
            string[i]<=0;
        end
    end
        
    else if(isstring)
        string[string_counter]<=chardata;

    else 
        for (i = 0;i<32 ; i=i+1) begin
            string[i]<=string[i];
        end
end

always @(posedge clk or posedge reset) begin
    if(reset)
        for (i = 0;i<9 ; i=i+1) begin
            pattern[i]<=0;
        end
    else if(state==STORE && ispattern && pattern_counter==1)begin
        pattern[pattern_counter]<=chardata;
        for (i = 2;i<9 ; i=i+1) begin
            pattern[i]<=0;
        end
    end
        else if(state==STORE && ispattern && pattern_counter==0)begin
        pattern[pattern_counter]<=chardata;
        for (i = 1;i<9 ; i=i+1) begin
            pattern[i]<=0;
        end
    end
    else if (ispattern && valid)begin
        pattern[0]<=chardata;
        for (i = 1;i<9 ; i=i+1) begin
            pattern[i]<=0;
        end
    end

    else if(ispattern)
        pattern[pattern_counter]<=chardata;
    
    else
        for (i = 0;i<9 ;i=i+1) begin
            pattern[i]<=pattern[i];
        end
end

always @(posedge clk or posedge reset) begin
    if(reset)
        string_counter<=0;
    else if(valid && isstring)
        string_counter<=1;
    else if(valid)
        string_counter<=0;
    else if(isstring|| state==MATCH )
        string_counter<=string_counter+1;
    else 
        string_counter<=0;
end



//hat-flag
always @(posedge clk or posedge reset) begin
    if (reset)
        hat_flag <= 1'b0;
    else if (ispattern && (chardata == 8'h5E))//if patter[]== ' ^ '
        hat_flag <= 1'b1;
    else if (valid)
        hat_flag <= 1'b0;
    else
        hat_flag<=hat_flag;
end

always @(posedge clk or posedge reset) begin
    if(reset)
        dot_front_flag<=0;
    else if(ispattern && (pattern_counter==0 || (pattern_counter==1 && pattern[0] == 8'h5E)) && chardata==8'h2E)
        dot_front_flag<=1;
    else if(valid && chardata != 8'h2E)
        dot_front_flag<=0;
    else
        dot_front_flag<=dot_front_flag;
end


reg if_notdot;
always @(posedge clk or posedge reset) begin
    if(reset)
        if_notdot<=0;
    else if (ispattern  && pattern[pattern_counter -1] == 8'h2E && chardata != 8'h2E )
        if_notdot <= 1;
    else if (valid)
        if_notdot <= 0;
    else 
        if_notdot <= if_notdot;
end



reg [3:0] dot_number;
always @(posedge clk or posedge reset) begin
    if(reset)
        dot_number<=0;
    else if (ispattern && (pattern_counter==0 || (pattern_counter==1 && pattern[0] == 8'h5E)) && chardata==8'h2E)
        dot_number <= 1;
    else if ( !if_notdot && ispattern && dot_front_flag && pattern[pattern_counter -1] == 8'h2E && chardata == 8'h2E )
        dot_number <= dot_number + 1;
    else if (ispattern && (pattern_counter==1 || (pattern_counter==2 && pattern[0] == 8'h5E)) && chardata==8'h2E)
        dot_number <= 1;
    else if (valid && chardata == 8'h2E)
        dot_number <= 1;
    else if (valid)
        dot_number <= 0;
    else 
        dot_number <= dot_number;
end

always @(posedge clk or posedge reset) begin
    if(reset)
        money_flag<=0;
    else if(ispattern && chardata==8'h24)
        money_flag<=1;
    else if(valid)
        money_flag<=0;
    else
        money_flag<=money_flag;
end

wire [7:0] current_pattern;
assign current_pattern = pattern[pattern_counter];
wire [7:0] current_stirng;
assign current_stirng = string[string_counter];

//pattern_counter
always @(posedge clk or posedge reset) begin
    if(reset)
        pattern_counter<=0;
    //p+1
    else if (state == MATCH )begin
        if(valid)        
            pattern_counter<=1;
        // else if (string[string_counter] == 8'h20 && pattern[pattern_counter] != 8'h24 && money_flag && ( hat_flag) && dot_front_flag)// if string is space
        //     pattern_counter <= dot_number + 1;
        else if (string[string_counter] == 8'h20 && pattern[pattern_counter] != 8'h24 && money_flag && ( hat_flag))// if string is space
            pattern_counter <= 1;
        else if ( (string[string_counter] == 8'h20 || string[string_counter] == 8'h0) && pattern[pattern_counter] != 8'h24 && money_flag && dot_front_flag )// if string is space
            pattern_counter <= dot_number;
        else if ( (string[string_counter] == 8'h20 || string[string_counter] == 8'h0) && pattern[pattern_counter] != 8'h24 && money_flag )// if string is space
            pattern_counter <= 0;


        
        else if(pattern_counter == 1 &&( (string[string_counter - 1] == 8'h20) ||  (string_counter == 8'b0)  ) && hat_flag && (pattern[pattern_counter ] == string[string_counter]))//if previous one == " " && equal
            pattern_counter <= pattern_counter + 1;
        else if( pattern_counter == 1 && (!(string[string_counter - 1] == 8'h20)) && hat_flag && (pattern[pattern_counter ] == string[string_counter]))//if previous one == " " && equal
            pattern_counter <= 1;
        else if ((pattern[pattern_counter ] == string[string_counter]) )
            pattern_counter <= pattern_counter + 1;
        // last one if "$"
        else if ( (pattern[pattern_counter] == 8'h24) && (string[string_counter] == 8'h20 || string[string_counter] == 8'h0 ))
            pattern_counter <= pattern_counter + 1;
        else if(pattern[pattern_counter]==8'h24 && string_counter==32)
            pattern_counter <= pattern_counter + 1;
        
        else if ( state == MATCH &&hat_flag && pattern[pattern_counter ]==0)
            pattern_counter <= 4'd0;
        else if (current_pattern == 8'h2E && hat_flag && (string[string_counter -1] == 8'h20 || string_counter== 0) && pattern[pattern_counter -1] == 8'h5E)
            pattern_counter <= pattern_counter + 1 ; //!
        else if (current_pattern == 8'h2E && hat_flag && (string[string_counter -1] != 8'h20 || string_counter!= 0) && pattern[pattern_counter -1] == 8'h5E)
            pattern_counter <= 1 ; //!
        
        else if (current_pattern == 8'h2E  && (string[string_counter -1] != 8'h20 || string_counter!= 0) && pattern[pattern_counter -1] == 8'h5E)
            pattern_counter <= dot_number ; //!
        else if(pattern[pattern_counter]== 8'h2E) // " . ",
            pattern_counter <= pattern_counter + 1;
        else if( hat_flag)
            pattern_counter <= 4'd1;
        else if( pattern_counter == 1 && pattern[pattern_counter] != string[string_counter] && current_stirng == pattern[pattern_counter -1])
            pattern_counter <= 1; 
        else if (dot_front_flag )
            pattern_counter <= dot_number;//!
        
        else    
            pattern_counter <= 4'd0;
    end
    else if(state == STORE && ispattern && (chardata==8'h24 ||  pattern_counter == 4'd8) )//!
            pattern_counter <= 4'd0;
    else if(state==STORE && ispattern)
        pattern_counter<=pattern_counter+1;
    else if((!isstring && !ispattern && if_pattern) || pattern_counter==8 || chardata==36)
        pattern_counter<=0;
    else if (isstring)
        pattern_counter <= 0;
    else 
        pattern_counter<=pattern_counter;
end

//match
always @(posedge clk or posedge reset) begin
    if(reset)
        match <= 1'b0;
    // else if (match)
    //     match <= 1'b0;
    
    else if (state==MATCH &&( (pattern[pattern_counter] == 8'h24 )  ) && string_counter == 32)
        match <= 1'b1;
    else if ( state == MATCH && ((pattern[pattern_counter] == 8'h24) && (string[string_counter] != 8'h20 || string[string_counter] != 8'h0 || string_counter != 33)))
        match <= 1'b0;
    else if (state==MATCH &&(pattern[pattern_counter] == 8'h0 || pattern_counter == 4'd8 ))//(string_counter == 6'd32 ) && pattern[pattern_counter] == 8'h24
        match <= 1'b1;

    
    else 
        match <= 1'b0;
end



//match_index
always @(posedge clk or posedge reset) begin
    if(reset)
        match_index <= 5'b0;
    else if(state == MATCH  && dot_front_flag && ((pattern[pattern_counter] == 8'h2E)) && (pattern_counter == 4'd0)) // " . ",
            match_index <= string_counter;
    else if(state == MATCH  && hat_flag && ((pattern[pattern_counter] == 8'h2E)) && (pattern_counter == 4'd1)) // " . ",
            match_index <= string_counter;      
    else if (state == MATCH && (pattern_counter == 4'd1) && ( (string[string_counter - 1] == 8'h20) ||  (string_counter == 8'b0)  ) && hat_flag && (pattern[pattern_counter ] == string[string_counter]))
            match_index <= string_counter;
    else if (state == MATCH && (pattern_counter == 4'd0) && (pattern[pattern_counter ] == string[string_counter]) )begin
            match_index <= string_counter;
    end
    else if( state == MATCH && pattern_counter == 1 && pattern[pattern_counter] != string[string_counter] && current_stirng == pattern[pattern_counter -1])
            match_index <= string_counter ;
    else if(state ==MATCH && dot_front_flag && current_pattern == current_stirng && pattern_counter == dot_number)
        match_index <= string_counter - dot_number;//!
    else if (valid)
        match_index <= 5'b0;
    else 
        match_index <= match_index;
end

// //match_index
// always @(posedge clk or posedge reset) begin
//     if(reset)
//         match_index <= 5'b0;
//     else if (state == MATCH && (pattern_counter == 4'd1) && hat_flag)begin
//         if(pattern[pattern_counter] == 8'h2E) // " . ",
//             match_index <= string_counter - 6'b1;
//         else if(( (string[string_counter - 1] == 8'h20) ||  (string_counter == 8'b0)  ) && hat_flag && (pattern[pattern_counter ] == string[string_counter]))//if previous one == " " && equal
//             match_index <= string_counter ;
//         else if (pattern[pattern_counter ] == string[string_counter])
//             match_index <= string_counter - 6'b1;
//         // last one if "$"
//         else if ( (pattern[pattern_counter] == 8'h24) && (string[string_counter] != 8'h20 || string[string_counter] != 8'h0 ))
//             match_index <= string_counter - 6'b1;
//         else 
//             match_index <= 5'b0;
//     end
//     else if(state == MATCH && (pattern_counter == 4'd1) && dot_front_flag)begin
//         if(pattern[pattern_counter] == 8'h2E)
//             match_index <= string_counter-1;
        
//     end
//     else if (state == MATCH && (pattern_counter == 4'd0))begin
//         if(pattern[pattern_counter] == 8'h2E) // " . ",
//             match_index <= string_counter;
//         else if(( (string[string_counter - 1] == 8'h20) ||  (string_counter == 8'b0)  ) && hat_flag && (pattern[pattern_counter ] == string[string_counter]))//if previous one == " " && equal
//             match_index <= string_counter;
//         else if (pattern[pattern_counter ] == string[string_counter])
//             match_index <= string_counter;
//         // last one if "$"
//         else if ( (pattern[pattern_counter] == 8'h24) && (string[string_counter] != 8'h20 || string[string_counter] != 8'h0 ))
//             match_index <= string_counter;
//         else 
//             match_index <= 5'b0;
//     end
//     else if (valid)
//         match_index <= 5'b0;
//     else 
//         match_index <= match_index;
// end

always @(posedge clk or posedge reset) begin
    if(reset)
        valid<=0;
    else if(valid)
        valid<=0;
    else if(state == MATCH  && string_counter==31 && !money_flag)
        valid<=1;
    else if (money_flag && string_counter == 6'd32)
        valid <= 1;
    else if(state==MATCH && (pattern[pattern_counter] == 8'h0 || pattern_counter == 4'd8 || (string_counter == 6'd32 && pattern[pattern_counter] == 8'h24) || string_counter == 6'd32 ))
        valid<=1;
    else
        valid<=0;
end

endmodule