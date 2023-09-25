module LASER (
input CLK,
input RST,
input [3:0] X,
input [3:0] Y,
output reg [3:0] C1X,
output reg [3:0] C1Y,
output reg [3:0] C2X,
output reg [3:0] C2Y,
output reg DONE);


integer i;
integer j;
reg [7:0] counter;
reg [5:0] p_counter;
reg [3:0] point_x [39:0];
reg [3:0] point_y [39:0];

reg [5:0] num_p;//coverage
reg [5:0] max_num_p;
reg [5:0] max_num_p_temp;
reg [5:0] C2_max_num_p;
reg [5:0] C1_max_num_p;
reg [5:0] C1_max_num_p2;
reg [5:0] C2_max_num_p2;

reg [3:0] C1X_reg;
reg [3:0] C1Y_reg;
reg [3:0] C2X_reg;
reg [3:0] C2Y_reg;

reg [3:0] C1X_temp;
reg [3:0] C1Y_temp;
reg [3:0] C2X_temp;
reg [3:0] C2Y_temp;

reg [ 1:0] state_flag;



parameter   IDLE=3'b0,
            STORE_POINT=3'd1,
            CORNER=3'd2,
            C_2=3'd3,
            C_1=3'd4,
            DONE1=3'd5;

reg [2:0] next_state,state;
reg [1:0] corner_counter;


wire [3:0] current_x = point_x[p_counter];
wire [3:0] current_y = point_y[p_counter];

wire signed [4:0] x_x1;
assign x_x1= (point_x[p_counter] - C1X_reg);

wire signed [9:0] x_x1_square;
assign x_x1_square= x_x1*x_x1;

wire signed [4:0] y_y1;
assign y_y1= point_y[p_counter] - C1Y_reg;

wire signed [9:0] y_y1_square;
assign y_y1_square=y_y1*y_y1;

wire signed [4:0] x_x2;
assign x_x2= point_x[p_counter]-C2X_reg;

wire signed [9:0] x_x2_square;
assign x_x2_square=x_x2*x_x2;

wire signed [4:0] y_y2;
assign y_y2= point_y[p_counter]-C2Y_reg;

wire signed [9:0] y_y2_square;
assign y_y2_square=y_y2*y_y2;


wire signed [4:0] x1_x2;
assign x1_x2= C1X_reg-C2X_reg;

wire signed [9:0] x1_x2_square;
assign x1_x2_square=x1_x2*x1_x2;

wire signed [4:0] y1_y2;
assign y1_y2= C1Y_reg - C2Y_reg;

wire signed [9:0] y1_y2_square;
assign y1_y2_square=y1_y2*y1_y2;





always @(*) begin
    case(state)
        IDLE:next_state=STORE_POINT;
        STORE_POINT:next_state=(counter==39)?CORNER:STORE_POINT;
        CORNER:next_state=(counter==3 && p_counter==40)?C_2:CORNER;
        C_2:begin
            if(counter==143 && p_counter==40 && (C1_max_num_p == C2_max_num_p)  && state_flag == 2 )
                next_state=DONE1;
            else if(counter==143 && p_counter==40 && ((C1_max_num_p != C2_max_num_p) || (C2_max_num_p != C2_max_num_p2)))
                next_state=C_1;
            else
                next_state=C_2;
        end
        C_1:begin
            if(counter==143 && p_counter==40 && (C1_max_num_p == C2_max_num_p)   && state_flag ==2)
                next_state = DONE1;
            else if(counter==143 && p_counter==40 && ((C1_max_num_p != C2_max_num_p) ||  (C1_max_num_p != C1_max_num_p2)))
                next_state=C_2;
            else
                next_state=C_1;
        end
        DONE1:next_state=STORE_POINT;
        default:next_state=IDLE;
    endcase
end



always @(posedge CLK or posedge RST) begin
    if(RST)
        state_flag<=0;
    else if (state == DONE1)
        state_flag <= 0;
    else if( (state != next_state ) && p_counter == 40  && (C1_max_num_p == C2_max_num_p) && counter == 143)
        state_flag<= state_flag + 2'b1;
    else 
        state_flag <= state_flag;

end


always @(posedge CLK or posedge RST) begin
    if(RST)
        state<=3'b0;
    else 
        state<=next_state;
end

always @(posedge CLK or posedge RST) begin
    if(RST)
        corner_counter<=0;
    else if(corner_counter==3 && p_counter==40)
        corner_counter<=0;
    else if(state==CORNER && p_counter==40)
        corner_counter<=corner_counter+1; 
    else
        corner_counter<=corner_counter;
end

always @(posedge CLK or posedge RST) begin
    if(RST)
        C1X<=0;
    else if (state == STORE_POINT)
        C1X <= 0;
    else if(counter==143 && p_counter==40 && (C1_max_num_p == C2_max_num_p) &&  (state != next_state ) && state_flag)
        C1X <= max_num_p > max_num_p_temp ? C1X : C1X_temp;
    else if(state==CORNER && p_counter==40 && (num_p > max_num_p))
        C1X<=C1X_reg;
    else if ( p_counter == 40 && (num_p > max_num_p))begin
        C1X <=  C1X_reg;
    end
    else 
        C1X <= C1X;
end

always @(posedge CLK or posedge RST) begin
    if(RST)
        C1Y<=0;
    else if (state == STORE_POINT)
        C1Y <= 0;
    else if(counter==143 && p_counter==40 && (C1_max_num_p == C2_max_num_p) &&  (state != next_state ) && state_flag)
        C1Y <= max_num_p > max_num_p_temp ? C1Y : C1Y_temp;
    else if(state==CORNER && p_counter==40 && (num_p > max_num_p))
    C1Y <=  C1Y_reg ;
    else if (  p_counter == 40 && (num_p > max_num_p) )begin
        C1Y <=  C1Y_reg ;
    end
    else 
        C1Y <= C1Y;
end


//C2X
always @(posedge CLK or posedge RST) begin
    if(RST)
        C2X<=0;
    else if (state == STORE_POINT)
        C2X <= 0;
    else if(counter==143 && p_counter==40 && (C1_max_num_p == C2_max_num_p) &&  (state != next_state ) && state_flag)
        C2X <= max_num_p > max_num_p_temp ? C2X : C2X_temp;
    else if ( p_counter == 40 && (num_p > max_num_p) )begin
        C2X <= C2X_reg;
    end
    else 
        C2X <= C2X;
end

//C2Y
always @(posedge CLK or posedge RST) begin
    if(RST)
        C2Y<=0;
    else if (state == STORE_POINT)
        C2Y <= 0;
    else if(counter==143 && p_counter==40 && (C1_max_num_p == C2_max_num_p) &&  (state != next_state ) && state_flag)
        C2Y <= max_num_p > max_num_p_temp ? C2Y : C2Y_temp;
    
    else if ( p_counter == 40 && (num_p > max_num_p))begin
        C2Y <= C2Y_reg ;
    end
    else 
        C2Y <= C2Y;
end

always @(posedge CLK or posedge RST) begin
    if(RST)
        C1X_reg<=0;
    else if (state == STORE_POINT)
        C1X_reg <= 0;
    else if(state==CORNER && p_counter==40 && corner_counter==2'b00)
        C1X_reg<=15;
    else if(state==CORNER && p_counter==40 && corner_counter==2'b01)
        C1X_reg<=15;
    else if(state==CORNER && p_counter==40 && corner_counter==2'b10)
        C1X_reg<=0;
    else if(state==CORNER && p_counter==40 && corner_counter==2'b11)
        C1X_reg<=C1X;
    else if ( (state == C_1)  && next_state == C_2 && (C1_max_num_p == C2_max_num_p) && counter == 143)//!
        C1X_reg <= C1X > 4'd10 ? C1X - 4'd10  : C1X + 4'd3 ;
    else if(state==CORNER && p_counter==40 && corner_counter==2'b11)
        C1X_reg<=C1X;
    else if ( (state == C_1 )  && next_state == C_2)
        C1X_reg <= C1X;
    else if (state == C_2 && next_state == C_1)
        C1X_reg <= 4'd2;
    else if (state == C_1 && p_counter == 40)begin
        C1X_reg <= C1X_reg == 4'd13 ? 4'd2 :  C1X_reg + 4'd1;
    end
    else 
        C1X_reg <= C1X_reg;
end

always @(posedge CLK or posedge RST) begin
    if(RST)
        C1Y_reg<=0;
    else if (state == STORE_POINT)
        C1Y_reg <= 0;
    else if(state==CORNER && p_counter==40 && corner_counter==2'b00)
        C1Y_reg<=0;
    else if(state==CORNER && p_counter==40 && corner_counter==2'b01)
        C1Y_reg<=15;
    else if(state==CORNER && p_counter==40 && corner_counter==2'b10)
        C1Y_reg<=15;
    else if(state==CORNER && p_counter==40 && corner_counter==2'b11)
        C1Y_reg<=C1Y;
    else if ( (state == C_1)  && next_state == C_2 && (C1_max_num_p == C2_max_num_p) && counter == 143)//!
        C1Y_reg <= C1Y > 4'd10 ? C1Y - 4'd10 : C1Y + 4'd3 ;
    else if ( (state == C_1)  && next_state == C_2)
        C1Y_reg <= C1Y;
    else if (state == C_2 && next_state == C_1 )
        C1Y_reg <= 4'd2;
    else if (state == C_1 && p_counter == 40)begin
        C1Y_reg <= C1X_reg == 4'd13 ?  C1Y_reg + 4'd1 : C1Y_reg ;
    end
    else 
        C1Y_reg <= C1Y_reg;
end


//C2X
always @(posedge CLK or posedge RST) begin
    if(RST)
        C2X_reg<=0;
    else if (state == STORE_POINT)
        C2X_reg <= 0;
    else if ( (state == CORNER || state == C_1 )  && next_state == C_2)
        C2X_reg <= 4'd2;
     else if ( (state == C_2)  && next_state == C_1 && (C1_max_num_p == C2_max_num_p) && counter == 143)//!
        C2X_reg <= C2X > 4'd10 ? C2X - 4'd10 : C2X + 4'd3 ;
    else if (state == C_2 && next_state == C_1 )
        C2X_reg <= C2X;
    else if (state == C_2 && p_counter ==40 )begin
        C2X_reg <= C2X_reg == 4'd13 ? 4'd2 :  C2X_reg + 4'd1;
    end
    else 
        C2X_reg <= C2X_reg;
end

//C2Y
always @(posedge CLK or posedge RST) begin
    if(RST)
        C2Y_reg<=0;
    else if (state == STORE_POINT)
        C2Y_reg <= 0;
    else if ((state == CORNER || state == C_1 )  && next_state == C_2)
        C2Y_reg <= 4'd2;
    else if ( (state == C_2)  && next_state == C_1 && (C1_max_num_p == C2_max_num_p) && counter == 143)//!
        C2Y_reg <= C2Y > 4'd10 ? C2Y - 4'd10 : C2Y + 4'd3 ;
    else if (state == C_2 && next_state == C_1 )
        C2Y_reg <= C2Y;
    else if (state == C_2 && p_counter == 40 )begin
        C2Y_reg <= C2X_reg == 4'd13 ?  C2Y_reg + 4'd1 : C2Y_reg ;
    end
    else 
        C2Y_reg <= C2Y_reg;
end

// reg [3:0] C1X_temp;
// reg [3:0] C1Y_temp;
// reg [3:0] C2X_temp;
// reg [3:0] C2Y_temp;
always @(posedge CLK or posedge RST) begin
    if(RST)
        C1X_temp<=0;
    else if (state == STORE_POINT)
        C1X_temp <= 0;
    else if ( (state != next_state ) && p_counter == 40  && (C1_max_num_p == C2_max_num_p) && counter == 143)begin
        C1X_temp <=  (max_num_p_temp > max_num_p) ? C1X_temp : C1X;
    end
    else 
        C1X_temp <= C1X_temp;
end

always @(posedge CLK or posedge RST) begin
    if(RST)
        C1Y_temp<=0;
    else if (state == STORE_POINT)
        C1Y_temp <= 0;
    else if (  (state != next_state ) && p_counter == 40  && (C1_max_num_p == C2_max_num_p) && counter == 143 )begin
        C1Y_temp <= (max_num_p_temp > max_num_p) ? C1Y_temp : C1Y;
    end
    else 
        C1Y_temp <= C1Y_temp;
end

//max_num_p_temp

always @(posedge CLK or posedge RST) begin
    if(RST)
        max_num_p_temp<=0;
    else if (state == STORE_POINT)
        max_num_p_temp <= 0;
    else if ( (state != next_state ) && p_counter == 40  && (C1_max_num_p == C2_max_num_p) && counter == 143 )begin
        max_num_p_temp <=  (max_num_p_temp > max_num_p) ? max_num_p_temp : max_num_p;
    end
    else 
        max_num_p_temp <= max_num_p_temp;
end

//C2X
always @(posedge CLK or posedge RST) begin
    if(RST)
        C2X_temp<=0;
    else if (state == STORE_POINT)
        C2X_temp <= 0;
    else if ( (state != next_state ) && p_counter == 40  && (C1_max_num_p == C2_max_num_p) && counter == 143 )begin
        C2X_temp <= (max_num_p_temp > max_num_p) ? C2X_temp : C2X;
    end
    else 
        C2X_temp <= C2X_temp;
end

//C2Y
always @(posedge CLK or posedge RST) begin
    if(RST)
        C2Y_temp<=0;
    else if (state == STORE_POINT)
        C2Y_temp <= 0;
    else if (  (state != next_state ) && p_counter == 40  && (C1_max_num_p == C2_max_num_p) && counter == 143)begin
        C2Y_temp <= (max_num_p_temp > max_num_p) ? C2Y_temp : C2Y ;
    end
    else 
        C2Y_temp <= C2Y_temp;
end

//counter
always @(posedge CLK or posedge RST) begin
    if(RST)
        counter<=0;
    else if (DONE)
        counter <= 0;
    else if(state == IDLE)
        counter <= counter + 8'd1;
    else if(state == STORE_POINT)
        counter <= counter == 8'd39 ? 8'd0 : counter + 8'd1;
    // else if ( state == CORNER && p_counter==40)
    //     counter <= counter == 8'd3 ? 8'd0 : counter + 8'd1;
    // else if ( state == C_2 && p_counter==40)
    //     counter<= counter == 8'd143 ? 8'd0 : counter + 8'd1;
    // else if ( state == C_1 && p_counter==40)
    //     counter<= counter == 8'd143 ? 8'd0 : counter + 8'd1;
    else if ((state != next_state ) )
        counter <= 0;
    else if(p_counter == 40)
        counter<= counter == 8'd143 ? 8'd0 : counter + 8'd1;
    else 
        counter <= counter; 
end

//wire test2 = ( x1_x2_square + y1_y2_square) <= 16 ;

//counter
always @(posedge CLK or posedge RST) begin
    if(RST)
        p_counter<=0;
    else if (DONE)
        p_counter <= 0;
    else if(state == IDLE)
        p_counter <= p_counter + 6'd1;
    else if(state == STORE_POINT)
        p_counter <= p_counter == 6'd39 ? 6'd0 : p_counter + 6'd1;
    else if ((state == C_1 || state == C_2 ) && ( x1_x2_square + y1_y2_square) <= 16 )
        p_counter <=  6'd40;
    else 
        p_counter<= p_counter == 6'd40 ? 6'd0 : p_counter + 6'd1;

end

//point_x
always @(posedge CLK or posedge RST) begin
    if(RST)
    for(i = 0 ; i < 40 ; i = i+1)begin
        point_x[i] <= 4'b0;
    end
    else if(state == STORE_POINT || state == IDLE)
        point_x[counter]<=X;

end

//point_y
always @(posedge CLK or posedge RST) begin
    if(RST)
    for(i = 0 ; i < 40 ; i = i+1)begin
        point_y[i] <= 4'b0;
    end
    else if(state == STORE_POINT || state == IDLE)
        point_y[counter]<= Y;
end



//num_p
always @(posedge CLK or posedge RST) begin
    if(RST)
        num_p<=6'b0;
    else if(state == STORE_POINT)
        num_p <= 0;
    // else if (state != next_state)
    //     num_p <= 0;
    else if (p_counter== 40)
        num_p <= 0;
    else if (state == CORNER )begin
        if( (x_x1_square + y_y1_square) <=16 )
            num_p <= num_p + 6'b1;
        else 
            num_p <= num_p;
    end
    else if ( state == C_2 || state == C_1)begin
        // if(( (x_x1_square + y_y1_square) > 16) && ((x_x2_square + y_y2_square) <= 16))
        //     num_p <= num_p + 6'b1;
        // else if( ((x_x1_square + y_y1_square) <=16) && ((x_x2_square + y_y2_square) <= 16))
        //     num_p <= num_p + 6'b1;
        // else if( ((x_x1_square + y_y1_square) <= 16) && ((x_x2_square + y_y2_square) > 16))
        //     num_p <= num_p + 6'b1;
        if( ((x_x1_square + y_y1_square) <= 16) || ((x_x2_square + y_y2_square) <= 16))
            num_p <= num_p + 6'b1;
        else 
            num_p <= num_p;
    end
    else 
        num_p <= num_p;
end


//[5:0] C2_max_num_p
always @(posedge CLK or posedge RST) begin
    if(RST)
        C2_max_num_p<=6'b0;
    else if(state == STORE_POINT)
        C2_max_num_p <= 6'd0;
    else if ( (state != next_state ) && p_counter == 40  && (C1_max_num_p == C2_max_num_p) && counter == 143)
        C2_max_num_p <=  6'd0;
    else if ( state == C_2  && p_counter==40)
        C2_max_num_p <= C2_max_num_p < num_p ?  num_p: C2_max_num_p;
end

//[5:0] C1_max_num_p
always @(posedge CLK or posedge RST) begin
    if(RST)
        C1_max_num_p<=6'b0;
    else if(state == STORE_POINT)
        C1_max_num_p <= 6'd0;
    else if ( (state != next_state )  && p_counter == 40  && (C1_max_num_p == C2_max_num_p) && counter ==143)
        C1_max_num_p <= 6'd0;
    else if ((state == CORNER  || state == C_1) && p_counter==40)
        C1_max_num_p <= C1_max_num_p < num_p ?  num_p: C1_max_num_p;
end

//[5:0] C2_max_num_p2
always @(posedge CLK or posedge RST) begin
    if(RST)
        C2_max_num_p2<=6'b0;
    else if(state == STORE_POINT)
        C2_max_num_p2 <= 6'd0;
    
    else if ( ( state == C_1) &&  p_counter==0 )//state == C_2
        C2_max_num_p2 <=  C2_max_num_p;
end

//[5:0] C1_max_num_p2
always @(posedge CLK or posedge RST) begin
    if(RST)
        C1_max_num_p2<=6'b0;
    else if(state == STORE_POINT)
        C1_max_num_p2 <= 6'd0;
    else if (state == C_2 &&  p_counter==0)
        C1_max_num_p2 <= C1_max_num_p;
end

//max_num_p
always @(posedge CLK or posedge RST) begin
    if(RST)
        max_num_p<=6'b0;
    else if(state == STORE_POINT)
        max_num_p <= 6'd0;
    else if ( (state != next_state ) && p_counter == 40  && (C1_max_num_p == C2_max_num_p) && counter == 143)
        max_num_p <= 6'd0;    
    else if ((state == CORNER  || state == C_1 ) && p_counter==40)
        max_num_p <= num_p < max_num_p ?  max_num_p : num_p;
    else if ( state == C_2 && p_counter==40)
        max_num_p <= num_p < max_num_p ?  max_num_p :num_p;
    else 
        max_num_p <= max_num_p;
end

//DONE
always @(posedge CLK or posedge RST) begin
    if(RST)
        DONE<=1'b0;
    else if(state == DONE1)
        DONE <= 1'b1;
    else 
        DONE <= 1'b0;

    
end


endmodule


