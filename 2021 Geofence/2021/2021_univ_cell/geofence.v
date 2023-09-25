module geofence ( clk,reset,X,Y,valid,is_inside);
input clk;
input reset;
input [9:0] X;
input [9:0] Y;
output valid;
output is_inside;

parameter IDLE = 0;
parameter STORE = 1;
parameter CLOCKWISE_SORT = 2;
parameter IF_INSIDE = 3;




parameter DATAWIDTH=11;
parameter DATAWIDTH_MINUS_1 = 10;
parameter DATAWIDTH_MINUS_2 = 9;
parameter DOUBLE_DATAWIDTH = 22;
parameter DOUBLE_DATAWIDTH_MINUS_2 = 20;
parameter DOUBLE_DATAWIDTH_MINUS_3 = 19;
parameter s0 = 0, s1 = 1, s2 = 2,s3=3,s4=4,s5=5;
/*
wire [3:0] w;
assign w=DATAWIDTH;

wire [4:0] ws ;
assign ws=w<<2;
*/
reg [DATAWIDTH_MINUS_1:0] x1, y1/*,x2,y2*/;
reg [DOUBLE_DATAWIDTH_MINUS_2:0] result1;
wire [DOUBLE_DATAWIDTH_MINUS_2:0]result2;
reg [DOUBLE_DATAWIDTH_MINUS_2:0] result_reg1/*,result_reg2*/;

reg  [4:0] count;
reg  [2:0] mul_state;
reg  [DOUBLE_DATAWIDTH_MINUS_3:0] P1, T1/*,P2,T2*/;
wire [DATAWIDTH_MINUS_2:0] x_reg1/*,x_reg2*/;
reg   [DATAWIDTH_MINUS_2:0] y_reg1/*,y_reg2*/;
reg   msb1;
//reg   msb2=0;





reg [9:0] target_x,target_y;
reg [9:0] hexagon_x [0:5];
reg [9:0] hexagon_y [0:5];

//reg [2:0] sort_counter ;
reg [2:0] counter_buffer;

//reg mul_count;

reg [2:0] counter;
reg [1:0] state;
reg [1:0] next_state;

//reg if_positive;
//reg if_positive_buffer;

reg valid;
reg is_inside;

//reg signed [21:0] multiplication1;
//reg signed [21:0] multiplication2;

wire signed[10:0] Ax;
assign Ax=(hexagon_x[counter-1]-hexagon_x[0]);

wire signed[10:0] By;
assign By=(hexagon_y[counter]-hexagon_y[0]);

wire signed[10:0] Ay;
assign Ay=(hexagon_y[counter-1]-hexagon_y[0]);

wire signed[10:0] Bx;
assign Bx=(hexagon_x[counter]-hexagon_x[0]);

//wire signed [21:0] AxBy;
//assign AxBy=Ax*By;

//wire signed [21:0] AyBx;
//assign AyBx=Ay*Bx;

wire signed[10:0] tx ;
assign tx =(hexagon_x[counter_buffer]-target_x);

wire signed[10:0] ty;
assign ty=(hexagon_y[counter_buffer]-target_y);

wire signed[10:0] hx;
assign hx=(hexagon_x[counter_buffer + 3'b1]-hexagon_x[counter_buffer]);

wire signed[10:0] hy;
assign hy=(hexagon_y[counter_buffer + 3'b1]-hexagon_y[counter_buffer]);

//wire signed [21:0] txhy;
//assign txhy=tx*hy;

//wire signed [21:0] tyhx;
//assign tyhx=ty*hx;

//wire signed[10:0] tx5 ;
//assign tx5 =(hexagon_x[counter_buffer]-target_x);

//wire signed[10:0] ty5;
//assign ty5=(hexagon_y[counter_buffer]-target_y);

wire signed[10:0] hx5;
assign hx5=(hexagon_x[0]-hexagon_x[counter_buffer]);

wire signed[10:0] hy5;
assign hy5=(hexagon_y[0]-hexagon_y[counter_buffer]);

//wire signed [21:0] tx5hy5;
//assign tx5hy5=tx5*hy5;

//wire signed [21:0] ty5hx5;
//assign ty5hx5=ty5*hx5;

integer i;


always @(*) begin
    if(!(state ^ CLOCKWISE_SORT) && mul_state<=2)
        x1 =  Ax;
    else if(!(state ^ CLOCKWISE_SORT) )
        x1 =Bx;
    else if(!(state ^ IF_INSIDE) && (counter_buffer^5) && mul_state>=3)
        x1 = hx;
    else if(!(state ^ IF_INSIDE) && !(counter_buffer^5) && mul_state>=3)
        x1 = hx5;
    else if(!(state ^ IF_INSIDE))
        x1 = tx;
    //else if(state == IF_INSIDE && counter_buffer==5)
    //    x1 = tx5;
    else 
        x1 = 11'b0;
        
end

always @(*) begin
    if(!(state ^ CLOCKWISE_SORT) && mul_state<=2)
        y1 =By;
    else if(!(state ^ CLOCKWISE_SORT))
        y1 =Ay;
    else if(!(state ^ IF_INSIDE) && (counter_buffer^5) && mul_state<=2)
        y1 =hy;
    else if(!(state ^ IF_INSIDE) && !(counter_buffer^5) && mul_state<=2)
        y1 =hy5;
    else if(!(state ^ IF_INSIDE) )
        y1 = ty;
    else 
        y1 = 11'b0;
        
end

/*always @(*) begin
    if(state == CLOCKWISE_SORT )
        x2 =Bx;
    else if(state == IF_INSIDE && counter_buffer<=4)
        x2 = hx;
    else if(state == IF_INSIDE && counter_buffer==5)
        x2 = hx5;
    else 
        x2 = 11'b0;
        
end

always @(*) begin
    if(state == CLOCKWISE_SORT )
        y2 =Ay;
    else if(state == IF_INSIDE)
        y2 = ty;
    //else if(state == IF_INSIDE && counter_buffer==5)
    //    y2 = ty5;
    else 
        y2 = 11'b0;
        
end
*/

always @(*) begin
    if(!(x1 && y1))
        result_reg1 = 0;
    else 
        result_reg1 = {msb1,P1[DOUBLE_DATAWIDTH_MINUS_3:0]};
end

always @(posedge clk or posedge reset) begin
    if (reset) begin
        y_reg1<=0; 
        msb1 <= 0;
        P1 <= 0;
        T1 <= 0;
/*
        y_reg2<=0; 
        msb2 <= 0;
        P2 <= 0;
        T2 <= 0;
*/
        count <= 0;
        mul_state <= s0;
    end
    else if ((!(state^CLOCKWISE_SORT) && (counter^1)) || !(state^IF_INSIDE)) begin
        case (mul_state)
            s0: begin
                y_reg1<=(~|y1[DATAWIDTH_MINUS_1])?y1[DATAWIDTH_MINUS_2:0]:~y1[DATAWIDTH_MINUS_2:0]+1'b1; 
                msb1 <= x1[DATAWIDTH_MINUS_1] ^ y1[DATAWIDTH_MINUS_1];
                P1 <= 0;
                T1 <= {{(DATAWIDTH_MINUS_1){1'b0}}, x_reg1};
/*
                y_reg2<=(y2[DATAWIDTH-1]==0)?y2[DATAWIDTH-2:0]:~y2[DATAWIDTH-2:0]+1'b1; 
                msb2 <= x2[DATAWIDTH-1] ^ y2[DATAWIDTH-1];
                P2 <= 0;
                T2 <= {{(DATAWIDTH-1){1'b0}}, x_reg2};
*/
                count <= 0;
                mul_state <= s1;
            end
            s1: begin
                if(!(count^(DATAWIDTH_MINUS_1)))
                    mul_state <= s2;
                else begin
                    if(!(y_reg1[0]^1'b1))
                        P1 <= P1 + T1;
                    else
                        P1 <= P1;
                    y_reg1 <= y_reg1 >> 1;
                    T1 <= T1 << 1;
/*
                    if(y_reg2[0] == 1'b1)
                        P2 <= P2 + T2;
                    else
                        P2<= P2;
                    y_reg2 <= y_reg2 >> 1;
                    T2 <= T2 << 1;
*/
                    count <= count + 1;
                    mul_state <= s1;
                end
            end
            s2: begin
                
                result1 <= (~|result_reg1[DOUBLE_DATAWIDTH_MINUS_2])? (result_reg1) : 
                ({result_reg1[DOUBLE_DATAWIDTH_MINUS_2],~result_reg1[(DOUBLE_DATAWIDTH_MINUS_3):0]+1'b1});
/*
                if(!x2 || !y2)
                    result_reg2 <= 0;
                else
                    result_reg2 <= {msb2,P2[DATAWIDTH*2-3:0]};
*/
                mul_state <= s3;
            end
            s3:begin
                

                y_reg1<=(~|y1[DATAWIDTH_MINUS_1])?y1[DATAWIDTH_MINUS_2:0]:~y1[DATAWIDTH_MINUS_2:0]+1'b1; 
                msb1 <= x1[DATAWIDTH_MINUS_1] ^ y1[DATAWIDTH_MINUS_1];
                P1 <= 0;
                T1 <= {{(DATAWIDTH_MINUS_1){1'b0}}, x_reg1};

                count <= 0;
                mul_state <= s4;
            end
            s4:begin
                if(!(count ^ (DATAWIDTH_MINUS_1)))
                    mul_state <= s5;
                else begin
                    if(!(y_reg1[0] ^ 1'b1))
                        P1 <= P1 + T1;
                    else
                        P1 <= P1;
                    y_reg1 <= y_reg1 >> 1;
                    T1 <= T1 << 1;
                
                count <= count + 1;
                mul_state <= s4;
                end
            end
            s5:begin
                
                mul_state <= s0;
            end
            default:mul_state <= s0;
        endcase
    end
    else begin
        y_reg1<=0; 
        msb1 <= 0;
        P1 <= 0;
        T1 <= 0;
/*
        y_reg2<=0; 
        msb2 <= 0;
        P2 <= 0;
        T2 <= 0;
*/
        count <= 0;
        mul_state <= s0;
    end
        
    end
   assign x_reg1 = (~|x1[DATAWIDTH_MINUS_1])?  x1[DATAWIDTH_MINUS_2:0]  : ~x1[DATAWIDTH_MINUS_2:0]+1'b1;

 //  assign x_reg2 = (x2[DATAWIDTH-1]==0)?  x2[DATAWIDTH-2:0]  : ~x2[DATAWIDTH-2:0]+1'b1;

 //  assign result1 = (result_reg1[DOUBLE_DATAWIDTH-2]==0)? (result_reg1) : 
 //               ({result_reg1[DOUBLE_DATAWIDTH-2],~result_reg1[(DOUBLE_DATAWIDTH-3):0]+1'b1});

   assign result2 = (~|result_reg1[DOUBLE_DATAWIDTH_MINUS_2])? (result_reg1) : 
                ({result_reg1[DOUBLE_DATAWIDTH_MINUS_2],~result_reg1[(DOUBLE_DATAWIDTH_MINUS_3):0]+1'b1});


wire signed [(DOUBLE_DATAWIDTH_MINUS_2):0] result;
assign result=$signed(result1-result2);


/*always @(posedge clk or posedge reset) begin
    if(reset)
        mul_count<=0;
    else if(state==CLOCKWISE_SORT )
end*/
/*
//multiplication1
always @(*) begin
    if(state == CLOCKWISE_SORT )
        multiplication1 = Ax*By;
    else if(state == IF_INSIDE && counter_buffer<=4)
        multiplication1 = tx*hy;
    else if(state == IF_INSIDE && counter_buffer==5)
        multiplication1 = tx5*hy5;
    else 
        multiplication1 = 21'b0;
        
end

//multiplication2
always @(*) begin
    if(state == CLOCKWISE_SORT )
        multiplication2 =Ay*Bx;
    else if(state == IF_INSIDE && counter_buffer<=4)
        multiplication2 = ty*hx;
    else if(state == IF_INSIDE && counter_buffer==5)
        multiplication2 = ty5*hx5;
    else 
        multiplication2 = 21'b0;
        
end
*/
always @(*) begin
    case (state)
        IDLE:next_state=STORE;
        STORE:next_state=(!(counter^6))?CLOCKWISE_SORT:STORE;
        CLOCKWISE_SORT:next_state=(((result[DOUBLE_DATAWIDTH_MINUS_2] && !(mul_state^s5))|| !(counter^1)) && !(counter_buffer^6) )?IF_INSIDE:CLOCKWISE_SORT;
        IF_INSIDE:next_state=(valid)?STORE:IF_INSIDE; 
        default: next_state=IDLE;
    endcase
end

always @(posedge clk or posedge reset) begin
    if(reset)
        state<=STORE;
    else 
        state<=next_state;
end

always @(posedge clk or posedge reset) begin
    if(reset)
        counter<=0;
     else if(!(state^STORE) && !(counter^6))
        counter<=2;
    else if(!(state^STORE))
        counter<=counter+1;
    else if(!(state^CLOCKWISE_SORT) && ((result[DOUBLE_DATAWIDTH_MINUS_2] && !(mul_state^s5)) || !(counter^1)) )
        counter<=counter_buffer;
    else if(!(state^CLOCKWISE_SORT) && (!result[DOUBLE_DATAWIDTH_MINUS_2]) && !(mul_state^s5))
        counter<=counter-1;
    else if(valid)
        counter<=0;
    else
        counter<=counter;
end

always @(posedge clk or posedge reset) begin
    if(reset)
        target_x<=0;
    else if(!(state^STORE) && !counter)
        target_x<=X;
    else
        target_x<=target_x;
end

always @(posedge clk or posedge reset) begin
    if (reset) 
        target_y<=0;
    else if(!(state^STORE) && !counter)
        target_y<=Y;
    else
        target_y<=target_y;
end

always @(posedge clk or posedge reset) begin
    if(reset)
        for (i = 0;i<6 ; i=i+1) begin
            hexagon_x[i]<=0;
        end
    else if(!(state^STORE) && counter)//counter>=1
        hexagon_x[counter-1]<=X;
    else if(!(state^CLOCKWISE_SORT) && !result[DOUBLE_DATAWIDTH_MINUS_2] && !(mul_state^s5))begin
        hexagon_x[counter-1]<=hexagon_x[counter];
        hexagon_x[counter]<=hexagon_x[counter-1];
    end
    else
        for (i = 0;i<6 ; i=i+1) begin
            hexagon_x[i]<=hexagon_x[i];
        end
end

always @(posedge clk or posedge reset) begin
    if(reset)
        for (i = 0;i<6 ; i=i+1) begin
            hexagon_y[i]<=0;
        end
    else if(!(state^STORE) && counter)//counter>=1
        hexagon_y[counter-1]<=Y;
    else if(!(state^CLOCKWISE_SORT) && !result[DOUBLE_DATAWIDTH_MINUS_2] && !(mul_state^s5))begin
        hexagon_y[counter-1]<=hexagon_y[counter];
        hexagon_y[counter]<=hexagon_y[counter-1];
    end
    else
        for (i = 0;i<6 ; i=i+1) begin
            hexagon_y[i]<=hexagon_y[i];
        end
end


always @(posedge clk or posedge reset) begin
    if(reset)
        counter_buffer<=3;
     else if(valid)
        counter_buffer<=3;
    else if(!(state^CLOCKWISE_SORT) && ((result[DOUBLE_DATAWIDTH_MINUS_2] && !(mul_state^s5))|| !(counter^1)) && !(counter_buffer^6) )
        counter_buffer<=0;
    else if(!(state^CLOCKWISE_SORT) && ((result[DOUBLE_DATAWIDTH_MINUS_2] && !(mul_state^s5))|| !(counter^1)) )
        counter_buffer<=counter_buffer+1;
    else if(!(state ^ IF_INSIDE) && !(mul_state^s5))
        counter_buffer<=counter_buffer+1;
    else 
        counter_buffer<=counter_buffer;
end


/*always @(posedge clk or posedge reset) begin
    if(reset)
        if_positive <= 1'b0;
    else if(valid)
        if_positive<=0;
    else if(state==IF_INSIDE && counter_buffer!=5 )//counter>=1
        if_positive <= (txhy-tyhx)> 0 ;
    else
        if_positive <= if_positive;
end*/

/*// if_positive_buffer
always @(posedge clk or posedge reset) begin
    if(reset)
        if_positive_buffer <= 1'b0;
    else if(valid)
        if_positive_buffer<=0;
    else if(state == IF_INSIDE)
        if_positive_buffer <= if_positive;
    else 
        if_positive_buffer <= if_positive_buffer;
end*/

//is_inside
always @(posedge clk or posedge reset) begin
    if(reset)
        is_inside <= 1'b0;
    else if(!(state ^ IF_INSIDE) && !valid  && !(mul_state^s5))
        is_inside <= (result[DOUBLE_DATAWIDTH_MINUS_2]);
    //else if(state == IF_INSIDE && !valid && counter_buffer==5 && mul_state==s6)
    //    is_inside <= (result[DOUBLE_DATAWIDTH_MINUS_2]);
    else 
        is_inside <= 1'b1;
        
end

//valid
always @(posedge clk or posedge reset) begin
    if(reset)
        valid <= 1'b0;
    else if(valid)
        valid<=1'b0;
    else if(!(state ^ IF_INSIDE) && (!result[DOUBLE_DATAWIDTH_MINUS_2]) && !(mul_state^s5))
        valid <= 1'b1;
    //else if(state == IF_INSIDE && (!result[DOUBLE_DATAWIDTH_MINUS_2]) && counter_buffer==5 && mul_state==s6)
    //    valid <= 1'b1;
    else if(!(state ^ IF_INSIDE) && !(counter_buffer^3'd5))
        valid <= 1'b1;
    else 
        valid <= 1'b0;
        
end

endmodule

