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

reg [9:0] target_x,target_y;
reg [9:0] hexagon_x [0:5];
reg [9:0] hexagon_y [0:5];

//reg [2:0] sort_counter ;
reg [2:0] counter_buffer;

reg [2:0] counter;
reg [1:0] state;
reg [1:0] next_state;

//reg if_positive;
//reg if_positive_buffer;






reg valid;
reg is_inside;

wire signed [10:0] Ax;
assign Ax=(hexagon_x[counter-1]-hexagon_x[0]);

wire signed [10:0] By;
assign By=(hexagon_y[counter]-hexagon_y[0]);

wire signed [10:0] Ay;
assign Ay=(hexagon_y[counter-1]-hexagon_y[0]);

wire signed [10:0] Bx;
assign Bx=(hexagon_x[counter]-hexagon_x[0]);

// wire signed [21:0] AxBy;
// assign AxBy=Ax*By;

// wire signed [21:0] AyBx;
// assign AyBx=Ay*Bx;

wire signed [10:0] tx ;
assign tx =(hexagon_x[counter_buffer]-target_x);

wire signed [10:0] ty;
assign ty=(hexagon_y[counter_buffer]-target_y);

wire signed [10:0] hx;
assign hx=(hexagon_x[counter_buffer + 3'b1]-hexagon_x[counter_buffer]);

wire signed [10:0] hy;
assign hy=(hexagon_y[counter_buffer + 3'b1]-hexagon_y[counter_buffer]);

// wire signed [21:0] txhy;
// assign txhy=tx*hy;

// wire signed [21:0] tyhx;
// assign tyhx=ty*hx;

//wire signed [10:0] tx5 ;
//assign tx5 =(hexagon_x[counter_buffer]-target_x);

//wire signed [10:0] ty5;
//assign ty5=(hexagon_y[counter_buffer]-target_y);

wire signed [10:0] hx5;
assign hx5=(hexagon_x[0]-hexagon_x[counter_buffer]);

wire signed [10:0] hy5;
assign hy5=(hexagon_y[0]-hexagon_y[counter_buffer]);

// wire signed [21:0] tx5hy5;
// assign tx5hy5=tx5*hy5;

// wire signed [21:0] ty5hx5;
// assign ty5hx5=ty5*hx5;

integer i;

wire signed [20:0] multiplication1;
wire signed [20:0] multiplication2;

reg signed [10:0] X1;
reg signed [10:0] Y1;

reg signed [10:0] X2;
reg signed [10:0] Y2;

assign multiplication1 = X1 * Y1;
assign multiplication2 = X2 * Y2;

// wire mul1_mul2;
// assign mul1_mul2 = (multiplication2 < multiplication1) ;

//X1 Y1
always @(*) begin
    if(state == CLOCKWISE_SORT )
        X1 = Ay;
    else if(state == IF_INSIDE)
        X1 = ty;
    //else if(state == IF_INSIDE && counter_buffer==5)
    //    X1 = ty5;
    else 
        X1 = 11'b0;
        
end

//X1 Y1
always @(*) begin
    if(state == CLOCKWISE_SORT )
        Y1 = Bx;
    else if(state == IF_INSIDE && counter_buffer<=4)
        Y1 = hx;
    else if(state == IF_INSIDE && counter_buffer==5)
        Y1 = hx5;
    else 
        Y1 = 11'b0;
        
end



//X1 Y1
always @(*) begin
    if(state == CLOCKWISE_SORT )
        X2 = Ax;
    else if(state == IF_INSIDE)
        X2 = tx;
    //else if(state == IF_INSIDE && counter_buffer==5)
    //    X2 = tx5;
    else 
        X2 = 11'b0;
        
end

//X1 Y1
always @(*) begin
    if(state == CLOCKWISE_SORT )
        Y2 = By;
    else if(state == IF_INSIDE && counter_buffer<=4)
        Y2 = hy;
    else if(state == IF_INSIDE && counter_buffer==5)
        Y2 = hy5;
    else 
        Y2 = 11'b0;
        
end



always @(*) begin
    case (state)
        IDLE:next_state=STORE;
        STORE:next_state=(counter==6)? CLOCKWISE_SORT:STORE;
        CLOCKWISE_SORT:next_state=(((multiplication2-multiplication1)<0 || counter==1) && counter_buffer==6) ? IF_INSIDE:CLOCKWISE_SORT;
        IF_INSIDE:next_state=(valid) ? STORE:IF_INSIDE; 
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
     else if(state==STORE && counter==6)
        counter<=2;
    else if(state==STORE)
        counter<=counter+1;
    else if(state==CLOCKWISE_SORT && ((multiplication2-multiplication1)<0 || counter==1) )
        counter<=counter_buffer;
    else if(state==CLOCKWISE_SORT && ((multiplication2-multiplication1)>0))
        counter<=counter-1;
   
    else if(valid)
        counter<=0;
    else
        counter<=counter;
end

always @(posedge clk or posedge reset) begin
    if(reset)
        target_x<=0;
    else if(state==STORE && counter==0)
        target_x<=X;
    else
        target_x<=target_x;
end

always @(posedge clk or posedge reset) begin
    if (reset) 
        target_y<=0;
    else if(state==STORE && counter==0)
        target_y<=Y;
    else
        target_y<=target_y;
end

always @(posedge clk or posedge reset) begin
    if(reset)
        for (i = 0;i<6 ; i=i+1) begin
            hexagon_x[i]<=0;
        end
    else if(state==STORE && counter>=1)//counter>=1
        hexagon_x[counter-1]<=X;
    else if(state==CLOCKWISE_SORT && (multiplication2-multiplication1)>0)begin
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
    else if(state==STORE && counter>=1)//counter>=1
        hexagon_y[counter-1]<=Y;
    else if(state==CLOCKWISE_SORT && (multiplication2-multiplication1)>0)begin
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
    else if(state==CLOCKWISE_SORT && ((multiplication2-multiplication1)<0 || counter==1) && counter_buffer==6)
        counter_buffer<=0;
    else if(state==CLOCKWISE_SORT && ((multiplication2-multiplication1)<0 || counter==1))
        counter_buffer<=counter_buffer+1;
    else if(state==IF_INSIDE)
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
    else if(state == IF_INSIDE && !valid && counter_buffer<=4)
        is_inside <= ((multiplication2-multiplication1)<0);
    else if(state == IF_INSIDE && !valid && counter_buffer==5)
        is_inside <= ((multiplication2-multiplication1)<0);
    else 
        is_inside <= 1'b1;
        
end

//valid
always @(posedge clk or posedge reset) begin
    if(reset)
        valid <= 1'b0;
    else if(valid)
        valid<=1'b0;
    else if(state == IF_INSIDE && ((multiplication2-multiplication1)>=0) && counter_buffer<=4)
        valid <= 1'b1;
    else if(state == IF_INSIDE && ((multiplication2-multiplication1)>=0) && counter_buffer==5)
        valid <= 1'b1;
    else if(state == IF_INSIDE && (counter_buffer == 3'd5))
        valid <= 1'b1;
    else 
        valid <= 1'b0;
        
end

endmodule

