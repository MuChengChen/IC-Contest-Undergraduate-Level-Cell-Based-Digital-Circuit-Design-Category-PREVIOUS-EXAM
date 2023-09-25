`timescale 1ns/10ps
module  CONV(clk,reset,cdata_rd,ready,idata,iaddr,cwr,caddr_wr,cdata_wr,crd,caddr_rd,busy,csel);

input clk;
input reset;
input [19:0] cdata_rd;
input ready;	
input signed [19:0] idata;	

output reg [11:0] iaddr;	
output reg cwr;
output reg [11:0] caddr_wr;
output reg  [19:0] cdata_wr;
output reg crd;
output reg [11:0] caddr_rd;
output reg busy;
output reg [2:0] csel;

reg [2:0] state;
reg [3:0] next_state;

reg [3:0] c_counter;
reg [11:0] iaddr_temp;
//reg signed [19:0] c_buffer [0:8]; 
reg signed [19:0] kvtemp;
wire signed [19:0] biastemp;

reg signed [44:0] convsum;//20+20+4=44,4 is about amount of pixel we accumulate
reg signed [44:0] convsum_buffer;
wire signed [20:0] round_convsum; //4 bits int + 16 bits float + 1 bit rounding float
assign round_convsum=$signed(convsum[35:15]+20'd1);

wire [5:0] caddr_wr_x;
assign caddr_wr_x=caddr_wr[5:0];

reg signed [44:0] mul;


reg [2:0] m_counter;
reg [11:0] caddr_rd_temp;

parameter IDLE = 0;
parameter READ_CONV = 1;
parameter RELU_L0_OUT = 2;
parameter L0_READ_MAXPOOL = 3;
parameter L1_OUT = 4;
parameter FINISH = 5;

parameter KV0 = 20'h0A89E;
parameter KV1 = 20'h092D5;
parameter KV2 = 20'h06D43;
parameter KV3 = 20'h01004;
parameter KV4 = 20'hF8F71;
parameter KV5 = 20'hF6E54;
parameter KV6 = 20'hFA6D7;
parameter KV7 = 20'hFC834;
parameter KV8 = 20'hFAC19;
parameter bias = 20'h01310;

assign biastemp=bias;

always @(*) begin
    case(c_counter)
        0:iaddr_temp=(caddr_wr_x==0 || caddr_wr<=64)?caddr_wr:caddr_wr-65;
        1:iaddr_temp=(caddr_wr<=63)?caddr_wr:caddr_wr-64;
        2:iaddr_temp=(caddr_wr_x==63 || caddr_wr<=63)?caddr_wr:caddr_wr-63;
        3:iaddr_temp=(caddr_wr_x==0)?caddr_wr:caddr_wr-1;
        4:iaddr_temp=caddr_wr;
        5:iaddr_temp=(caddr_wr_x==63)?caddr_wr:caddr_wr+1;
        6:iaddr_temp=(caddr_wr_x==0 || caddr_wr>=4032)?caddr_wr:caddr_wr+63;
        7:iaddr_temp=(caddr_wr>=4032)?caddr_wr:caddr_wr+64;
        8:iaddr_temp=(caddr_wr_x==63 || caddr_wr>=4032)?caddr_wr:caddr_wr+65;
        default:iaddr_temp=caddr_wr;
    endcase
end

always @(posedge clk or posedge reset) begin
    if(reset)
        iaddr<=0;
    else 
        iaddr<=iaddr_temp;
end

//always @(*) begin
//  biastemp=bias;
//end

always @(*) begin
    case(c_counter)
        1:kvtemp=KV0;
        2:kvtemp=KV1;
        3:kvtemp=KV2;
        4:kvtemp=KV3;
        5:kvtemp=KV4;
        6:kvtemp=KV5;
        7:kvtemp=KV6;
        8:kvtemp=KV7;
        9:kvtemp=KV8;
        default:kvtemp=20'd0;
    endcase
end

//assign mul=idata*kvtemp;
always @(posedge clk or posedge reset) begin
    if(reset)
        mul<=0;
    else 
        mul<=idata*kvtemp;
end

always @(*) begin
    case(c_counter)
        2:convsum_buffer=(caddr_wr_x==0 || caddr_wr<=64)?0:mul;
        3:convsum_buffer=(caddr_wr<=63)?convsum:convsum+mul;
        4:convsum_buffer=(caddr_wr_x==63 || caddr_wr<=63)?convsum:convsum+mul;
        5:convsum_buffer=(caddr_wr_x==0)?convsum:convsum+mul;
        6:convsum_buffer=convsum+mul;
        7:convsum_buffer=(caddr_wr_x==63)?convsum:convsum+mul;
        8:convsum_buffer=(caddr_wr_x==0 || caddr_wr>=4032)?convsum:convsum+mul;
        9:convsum_buffer=(caddr_wr>=4032)?convsum:convsum+mul;
        10:convsum_buffer=(caddr_wr_x==63 || caddr_wr>=4032)?convsum:convsum+mul;
        11:convsum_buffer=convsum+$signed({{8{biastemp[19]}},biastemp,16'h0});
        12:convsum_buffer=convsum;
        default:convsum_buffer=0;
    endcase
end

always @(posedge clk or posedge reset) begin
    if(reset)
        convsum<=0;
    /*else if(c_counter==0)
        convsum<=0;
    else if(c_counter>=2 && c_counter<=10)
        convsum<=convsum+mul;
    else if(c_counter==11)
        convsum<=convsum+$signed({{8{biastemp[19]}},biastemp,16'd0});*/
    else
        convsum<=convsum_buffer;
end

always @(posedge clk or posedge reset) begin
    if(reset)
        busy<=0;
    else if(ready)
        busy<=1;
    else if(state==FINISH)
        busy<=0;
    else
        busy<=busy;
end

always @(posedge clk or posedge reset) begin
    if(reset)
        csel<=3'b000;
    else if(next_state==RELU_L0_OUT || next_state==L0_READ_MAXPOOL)
        csel<=3'b001;
    else if(next_state==L1_OUT)
        csel<=3'b011;
    else 
        csel<=csel;
end

always @(posedge clk or posedge reset) begin
    if(reset)
        c_counter<=0;
    else if(c_counter==12)
        c_counter<=0;
    else if(state==READ_CONV)
        c_counter<=c_counter+1;
    else
        c_counter<=c_counter;
end

always @(posedge clk or posedge reset) begin
    if(reset)
        caddr_wr<=0;
    else if(cwr)
        caddr_wr<=caddr_wr+1;
    else
        caddr_wr<=caddr_wr;
end

always @(posedge clk or posedge reset) begin
    if(reset)
        cdata_wr<=0;
    else if(c_counter==12)
    begin
        if(convsum[35])
            cdata_wr<=0;
        else
            cdata_wr<=round_convsum[20:1];
    end
    else if(state==L0_READ_MAXPOOL)
    begin
        if(m_counter==1)
            cdata_wr<=cdata_rd;
        else if(m_counter==2 && cdata_wr<=cdata_rd)
            cdata_wr<=cdata_rd;
        else if(m_counter==3 && cdata_wr<=cdata_rd)
            cdata_wr<=cdata_rd;
        else if(m_counter==4 && cdata_wr<=cdata_rd)
            cdata_wr<=cdata_rd;
        else
            cdata_wr<=cdata_wr;
    end
    else
        cdata_wr<=cdata_wr;
end

always @(posedge clk or posedge reset) begin
    if(reset)
        cwr<=0;
    else if(next_state==RELU_L0_OUT || next_state==L1_OUT)
        cwr<=1;
    else
        cwr<=0;
end

always @(posedge clk or posedge reset) begin
    if(reset)
        crd<=0;
    else if(next_state==L1_OUT || caddr_rd==4033)
        crd<=0;
    else
        crd<=1;
end

always @(*) begin
    case(m_counter)
        1:caddr_rd_temp=caddr_rd+1;
        2:caddr_rd_temp=caddr_rd+63;
        3:caddr_rd_temp=caddr_rd+1;
        5:caddr_rd_temp=(caddr_rd[5:0]==63)?caddr_rd+1:caddr_rd-63;
        default:caddr_rd_temp=caddr_rd;
    endcase
end

always @(posedge clk or posedge reset) begin
    if(reset)
        caddr_rd<=0;
    else if(caddr_rd==4095)
        caddr_rd<=0;
    else if(state==L0_READ_MAXPOOL)
        caddr_rd<=caddr_rd_temp;
    else
        caddr_rd<=caddr_rd;
end

always @(posedge clk or posedge reset) begin
    if(reset)
        m_counter<=0;
    else if(m_counter==5)
        m_counter<=0;
    else if(state==L0_READ_MAXPOOL)
        m_counter<=m_counter+1;
    else
        m_counter<=m_counter;
end

always @(posedge clk or posedge reset) begin
    if(reset)
        state<=IDLE;
    else
        state<=next_state;
end

always @(*) begin
    case(state)
        IDLE:next_state=(ready)?READ_CONV:IDLE;
        READ_CONV:next_state=(c_counter==12)?RELU_L0_OUT:READ_CONV;
        RELU_L0_OUT:next_state=(caddr_wr==4095)?L0_READ_MAXPOOL:READ_CONV;
        L0_READ_MAXPOOL:next_state=(m_counter==5)?L1_OUT:L0_READ_MAXPOOL;
        L1_OUT:next_state=(caddr_wr==1023)?FINISH:L0_READ_MAXPOOL;
        FINISH:next_state=FINISH;
        default:next_state=IDLE;
    endcase
end

endmodule