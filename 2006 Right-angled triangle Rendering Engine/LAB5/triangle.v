module triangle (clk, reset, nt, xi, yi, busy, po, xo, yo);
  input clk, reset, nt;
  input [2:0] xi, yi;
  output busy, po;
  output [2:0] xo, yo;
reg busy,po;
reg [1:0] count;
reg [2:0] xo, yo;
reg [2:0] xc, yc;
reg [2:0] xi1, yi1,xi2, yi2,xi3, yi3;
reg signed [6:0] cal1,cal2;

always@(*)
if(reset)
	cal1<=0;
else if(busy)
	cal1<=(yc-yi2)*(xi3-xi2);
else
	cal1<=0;

always@(*)
if(reset)
	cal2<=0;
else if(busy)
	cal2<=(yi3-yi2)*(xc-xi2);
else
	cal2<=0;

always@(posedge clk or posedge reset)
if(reset)
	busy<=0;
else if(xi1>0 && yi1>0 && xo==0 && yo==0) 
	busy<=1; 
else if(xo>0 && yo>0 && xo==xi3 && yo==yi3)
	busy<=0;
else
	busy<=busy;

always@(posedge clk or posedge reset)
if(reset)
	po<=0;
else if(xc>0 && yc>0 && (cal1>=cal2) && busy)
	po<=1;
else
	po<=0;

always@(posedge clk or posedge reset)
if(reset)
	count<=0;
else if(nt)
	count<=1;
else if(xi1>0 && yi1>0 && xi2==0 && yi2==0 && xi3==0 && yi3==0)
	count<=2;
else if(xi2>0 && yi2>0 && xi3==0 && yi3==0)
	count<=3;
else if(xi3>0 && yi3>0)
	count<=0;
else
	count<=0;

always@(posedge clk or posedge reset)
if(reset)
	xi1<=0;
else if(nt)
	xi1<=xi;
else if(xo==xi3 && yo==yi3 && xi3>0 && yi3>0)
	xi1<=0;
else
	xi1<=xi1;

always@(posedge clk or posedge reset)
if(reset)
	yi1<=0;
else if(nt)
	yi1<=yi;
else if(xo==xi3 && yo==yi3 && xi3>0 && yi3>0)
	yi1<=0;
else
	yi1<=yi1;

always@(posedge clk or posedge reset)
if(reset)
	xi2<=0;
else if(xi1>0 && yi1>0 && count==1)
	xi2<=xi;
else if(xo==xi3 && yo==yi3 && xi3>0 && yi3>0)
	xi2<=0;
else
	xi2<=xi2;
	

always@(posedge clk or posedge reset)
if(reset)
	yi2<=0;
else if(xi1>0 && yi1>0 && count==1)
	yi2<=yi;
else if(xo==xi3 && yo==yi3 && xi3>0 && yi3>0)
	yi2<=0;
else
	yi2<=yi2;

always@(posedge clk or posedge reset)
if(reset)
	xi3<=0;
else if(xi2>0 && yi2>0 && count==2)
	xi3<=xi;
else if(xo==xi3 && yo==yi3 && xi3>0 && yi3>0)
	xi3<=0;
else
	xi3<=xi3;

always@(posedge clk or posedge reset)
if(reset)
	yi3<=0;
else if(xi2>0 && yi2>0 && count==2)
	yi3<=yi;
else if(xo==xi3 && yo==yi3 && xi3>0 && yi3>0)
	yi3<=0;
else
	yi3<=yi3;

always@(posedge clk or posedge reset)
if(reset)
	xc<=0;
else if(xi3>0 && yi3>0 && xc==0 && busy)
	xc<=xi1;
else if(xi3>0 && yi3>0 && xc>0 && yc>0 && xc<xi2 && !(xc==xi3 && yc==yi3) && busy)
	xc<=xc+1;
else if(xi3>0 && yi3>0 && xc>0 && yc>0 && xc==xi2 && busy)
	xc<=xi1;
else if(xi3>0 && yi3>0 && xc>0 && yc>0 && xc==xi3 && yc==yi3 && busy)
	xc<=0;
else
	xc<=xc;

always@(posedge clk or posedge reset)
if(reset)
	yc<=0;
else if(xi3>0 && yi3>0 && yc==0 && busy)
	yc<=yi1;
else if(xi3>0 && yi3>0 && xc>0 && yc>0 && xc==xi2 && busy)
	yc<=yc+1;
else if(xi3>0 && yi3>0 && xc>0 && yc>0 && xc==xi3 && yc==yi3 && busy)
	yc<=0;
else
	yc<=yc;

always@(posedge clk or posedge reset)
if(reset)
	xo<=0;
else if(xc>0 && yc>0 && (cal1>=cal2) && busy)
	xo<=xc;
else
	xo<=0;

always@(posedge clk or posedge reset)
if(reset)
	yo<=0;
else if(xc>0 && yc>0 && (cal1>=cal2) && busy)
	yo<=yc;
else
	yo<=0;
                   

endmodule
