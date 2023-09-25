module SET ( clk , rst, en, central, radius, mode, busy, valid, candidate );

input clk, rst;
input en;
input [23:0] central;
input [11:0] radius;
input [1:0] mode;
output busy;
output valid;
output [7:0] candidate;

reg busy;
reg valid;
reg [7:0] candidate;

reg [2:0] state;
reg [2:0] next_state;


reg [3:0] x1;
reg [3:0] y1;
reg [3:0] x2;
reg [3:0] y2;
reg [3:0] x3;
reg [3:0] y3;
reg [7:0] radius_square_reg1;
reg [7:0] radius_square_reg2;
reg [7:0] radius_square_reg3;

reg [4:0] x;
reg [4:0] y;

wire signed [4:0] x_x1;
assign x_x1=x-x1;

wire signed [9:0] x_x1_square;
assign x_x1_square=x_x1*x_x1;

wire signed [4:0] y_y1;
assign y_y1=y-y1;

wire signed [9:0] y_y1_square;
assign y_y1_square=y_y1*y_y1;

wire signed [4:0] x_x2;
assign x_x2=x-x2;

wire signed [9:0] x_x2_square;
assign x_x2_square=x_x2*x_x2;

wire signed [4:0] y_y2;
assign y_y2=y-y2;

wire signed [9:0] y_y2_square;
assign y_y2_square=y_y2*y_y2;

wire signed [4:0] x_x3;
assign x_x3=x-x3;

wire signed [9:0] x_x3_square;
assign x_x3_square=x_x3*x_x3;

wire signed [4:0] y_y3;
assign y_y3=y-y3;

wire signed [9:0] y_y3_square;
assign y_y3_square=y_y3*y_y3;

reg [2:0] counter;
reg right_wrong1;
reg right_wrong2;
reg right_wrong3;

parameter IDLE = 0;
parameter STORE = 1;
parameter MODE0 = 2;
parameter MODE1 = 3;
parameter MODE2 = 4;
parameter MODE3 = 5;

always @(*) begin
    case(state)
        IDLE:next_state=STORE;
        STORE:begin
            if( mode==0)
                next_state=MODE0;
            else if( mode== 1)
                next_state=MODE1;
            else if( mode==2)
                next_state=MODE2;
            else if( mode==3)
                next_state=MODE3; 
            else
                next_state=STORE;
        end
        MODE0:next_state=(valid)?STORE:MODE0;
        MODE1:next_state=(valid)?STORE:MODE1;
        MODE2:next_state=(valid)?STORE:MODE2;
        MODE3:next_state=(valid)?STORE:MODE3;
        default:next_state=IDLE;
    endcase
end

always @(posedge clk or posedge rst) begin
    if(rst)
        state<=IDLE;
    else
        state<=next_state;
end

always @(posedge clk or posedge rst) begin
    if(rst)
        x<=1;
    else if(state==STORE)
        x<=1;
    else if(state==MODE0 && x<=7 && counter==2)
        x<=x+1;
    else if(state==MODE0 && x==8 && counter==2)
        x<=1;
    else if((state==MODE1 || state==MODE2) && x<=7 && counter==3 )
        x<=x+1;
    else if((state==MODE1 || state==MODE2) && x==8 && counter==3 )
        x<=1;
    else if(state==MODE3 && x<=7 && counter==4 )
        x<=x+1;
    else if(state==MODE3 && x==8 && counter==4 )
        x<=1;
    else
        x<=x;
end

always @(posedge clk or posedge rst) begin
    if(rst)
        y<=1;
    else if(state==STORE)
        y<=1;
    else if(state==MODE0 && x==8 && counter==2)
        y<=y+1;
    else if((state==MODE1 || state==MODE2) && x==8 && counter==3 )
        y<=y+1;
    else if(state==MODE3 && x==8 && counter==4)
        y<=y+1;
    else
        y<=y;
end

always @(posedge clk or posedge rst) begin
    if (rst)
        x1<=0;
    else if(en)
        x1<=central[23:20];
    else
        x1<=x1;
end

always @(posedge clk or posedge rst) begin
    if (rst)
        y1<=0;
    else if(en)
        y1<=central[19:16];
    else
        y1<=y1;
end

always @(posedge clk or posedge rst) begin
    if (rst)
        x2<=0;
    else if(en)
        x2<=central[15:12];
    else
        x2<=x2;
end

always @(posedge clk or posedge rst) begin
    if (rst)
        y2<=0;
    else if(en)
        y2<=central[11:8];
    else
        y2<=y2;
end

always @(posedge clk or posedge rst) begin
    if (rst)
        x3<=0;
    else if(en)
        x3<=central[7:4];
    else
        x3<=x3;
end

always @(posedge clk or posedge rst) begin
    if (rst)
        y3<=0;
    else if(en)
        y3<=central[3:0];
    else
        y3<=y3;
end


always @(posedge clk or posedge rst) begin
    if(rst)
        radius_square_reg1<=0;
    else if(en)
        radius_square_reg1<=radius[11:8]*radius[11:8];
    else
        radius_square_reg1<=radius_square_reg1;
end

always @(posedge clk or posedge rst) begin
    if(rst)
        radius_square_reg2<=0;
    else if(en)
        radius_square_reg2<=radius[7:4]*radius[7:4];
    else
        radius_square_reg2<=radius_square_reg2;
end

always @(posedge clk or posedge rst) begin
    if(rst)
        radius_square_reg3<=0;
    else if(en)
        radius_square_reg3<=radius[3:0]*radius[3:0];
    else
        radius_square_reg3<=radius_square_reg3;
end

always @(posedge clk or posedge rst) begin
    if(rst)
        candidate<=0;
    else if(valid)
        candidate<=0;
    else if(state==MODE0 && right_wrong1 && counter==2 )
        candidate<=candidate+1;
    else if(state==MODE1 && right_wrong1 && right_wrong2 && counter==3)
        candidate<=candidate+1;
    else if(state==MODE2 && ((right_wrong1 && !right_wrong2) || (!right_wrong1 && right_wrong2)) && counter==3)
        candidate<=candidate+1;
    else if(state==MODE3 && ((!right_wrong1 && right_wrong2 && right_wrong3) || (right_wrong1 && !right_wrong2 && right_wrong3) || (right_wrong1 && right_wrong2 && !right_wrong3)) && counter==4)
        candidate<=candidate+1;
    else
        candidate<=candidate;
end

always @(posedge clk or posedge rst) begin
    if(rst)
        counter<=0;
    else if(valid)
        counter<=0;
    else if(state==MODE0 && counter==2)
        counter<=0;
    else if(state==MODE0)
        counter<=counter+1;
    else if((state==MODE1 || state==MODE2) && counter==3 )
        counter<=0;
    else if(state==MODE1 || state==MODE2)
        counter<=counter+1;
    else if(state==MODE3 && counter==4)
        counter<=0;
    else if(state==MODE3)
        counter<=counter+1;
    else
        counter<=counter;
end

always @(posedge clk or posedge rst) begin
    if(rst)
        right_wrong1<=0;
    else if((state==MODE0 || state==MODE1 || state==MODE2 || state==MODE3) && counter==1 && (x_x1_square+y_y1_square)<=radius_square_reg1)
        right_wrong1<=1;
    else if((state==MODE0 && counter==2) || ((state==MODE1 || state==MODE2) && counter==3) || (state==MODE3 && counter==4))
        right_wrong1<=0;
    else if(en)
        right_wrong1<=0;
    else
        right_wrong1<=right_wrong1;
end

always @(posedge clk or posedge rst) begin
    if(rst)
        right_wrong2<=0;
    else if((state==MODE1 || state==MODE2 || state==MODE3) && counter==2 && (x_x2_square+y_y2_square)<=radius_square_reg2)
        right_wrong2<=1;
    else if(((state==MODE1 || state==MODE2) && counter==3) || (state==MODE3 && counter==4))
        right_wrong2<=0;
    else if(en)
        right_wrong2<=0;
    else
        right_wrong2<=right_wrong2;
end

always @(posedge clk or posedge rst) begin
    if(rst)
        right_wrong3<=0;
    else if(state==MODE3 && counter==3 && (x_x3_square+y_y3_square)<=radius_square_reg3)
        right_wrong3<=1;
    else if(state==MODE3 && counter==4)
        right_wrong3<=0;
    else if(en)
        right_wrong3<=0;
    else
        right_wrong3<=right_wrong3;
end

always @(posedge clk or posedge rst) begin
    if(rst)
        busy<=0;
    else if(en)
        busy<=1;
    else if(valid)
        busy<=0;
    else
        busy<=busy;
end

always @(posedge clk or posedge rst) begin
    if(rst)
        valid<=0;
    else if(state==MODE0 && x==8 && y==8 && counter==2)
        valid<=1;
    else if((state==MODE1 || state==MODE2) && x==8 && y==8 && counter==3)
        valid<=1;
    else if(state==MODE3 && x==8 && y==8 && counter==4)
        valid<=1;
    else if(valid)
        valid<=0;
    else
        valid<=0;
end

endmodule


