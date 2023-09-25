/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : P-2019.03
// Date      : Sat Oct  8 23:34:06 2022
/////////////////////////////////////////////////////////////


module LBP_DW01_inc_0 ( A, SUM );
  input [7:0] A;
  output [7:0] SUM;

  wire   [7:2] carry;

  ADDHXL U1_1_6 ( .A(A[6]), .B(carry[6]), .CO(carry[7]), .S(SUM[6]) );
  ADDHXL U1_1_4 ( .A(A[4]), .B(carry[4]), .CO(carry[5]), .S(SUM[4]) );
  ADDHXL U1_1_5 ( .A(A[5]), .B(carry[5]), .CO(carry[6]), .S(SUM[5]) );
  ADDHXL U1_1_3 ( .A(A[3]), .B(carry[3]), .CO(carry[4]), .S(SUM[3]) );
  ADDHXL U1_1_2 ( .A(A[2]), .B(carry[2]), .CO(carry[3]), .S(SUM[2]) );
  ADDHXL U1_1_1 ( .A(A[1]), .B(A[0]), .CO(carry[2]), .S(SUM[1]) );
  CLKINVX1 U1 ( .A(A[0]), .Y(SUM[0]) );
  XOR2X1 U2 ( .A(carry[7]), .B(A[7]), .Y(SUM[7]) );
endmodule


module LBP_DW01_inc_1 ( A, SUM );
  input [13:0] A;
  output [13:0] SUM;

  wire   [13:2] carry;

  ADDHXL U1_1_12 ( .A(A[12]), .B(carry[12]), .CO(carry[13]), .S(SUM[12]) );
  ADDHXL U1_1_2 ( .A(A[2]), .B(carry[2]), .CO(carry[3]), .S(SUM[2]) );
  ADDHXL U1_1_3 ( .A(A[3]), .B(carry[3]), .CO(carry[4]), .S(SUM[3]) );
  ADDHXL U1_1_4 ( .A(A[4]), .B(carry[4]), .CO(carry[5]), .S(SUM[4]) );
  ADDHXL U1_1_5 ( .A(A[5]), .B(carry[5]), .CO(carry[6]), .S(SUM[5]) );
  ADDHXL U1_1_6 ( .A(A[6]), .B(carry[6]), .CO(carry[7]), .S(SUM[6]) );
  ADDHXL U1_1_11 ( .A(A[11]), .B(carry[11]), .CO(carry[12]), .S(SUM[11]) );
  ADDHXL U1_1_10 ( .A(A[10]), .B(carry[10]), .CO(carry[11]), .S(SUM[10]) );
  ADDHXL U1_1_9 ( .A(A[9]), .B(carry[9]), .CO(carry[10]), .S(SUM[9]) );
  ADDHXL U1_1_8 ( .A(A[8]), .B(carry[8]), .CO(carry[9]), .S(SUM[8]) );
  ADDHXL U1_1_7 ( .A(A[7]), .B(carry[7]), .CO(carry[8]), .S(SUM[7]) );
  ADDHXL U1_1_1 ( .A(A[1]), .B(A[0]), .CO(carry[2]), .S(SUM[1]) );
  XOR2XL U1 ( .A(carry[13]), .B(A[13]), .Y(SUM[13]) );
  CLKINVX1 U2 ( .A(A[0]), .Y(SUM[0]) );
endmodule


module LBP ( clk, reset, gray_addr, gray_req, gray_ready, gray_data, lbp_addr, 
        lbp_valid, lbp_data, finish );
  output [13:0] gray_addr;
  input [7:0] gray_data;
  output [13:0] lbp_addr;
  output [7:0] lbp_data;
  input clk, reset, gray_ready;
  output gray_req, lbp_valid, finish;
  wire   n638, n639, n640, n641, n642, n643, n644, n645, n646, n647, n648,
         n649, n650, n651, n652, n653, n654, n655, n656, n657, n658, n659,
         n660, n661, N33, N34, N35, N36, N37, N38, N39, N40, N41, N42, N43,
         N44, N45, N47, N48, N49, N50, N51, N52, N53, N54, N55, N56, N57, N58,
         N59, N60, N77, N79, N80, N81, N82, N83, N84, N85, N86, N87, N88, N89,
         N90, N93, N94, N95, N96, N97, N98, N100, N101, N102, N103, N104, N105,
         N109, N110, N111, N112, N113, N114, N115, N116, N117, N118, N119,
         N120, N175, N176, N177, N178, N179, N180, N184, N185, N186, N187,
         N188, N189, N190, N191, N192, N193, N194, N195, N196, N197, N198,
         N199, N200, N201, N202, N203, N204, N205, N206, N207, N208, N209,
         N246, N252, N291, N293, N294, N295, N296, N297, N298, N301, N303,
         N304, N305, N306, N307, N311, N313, N314, N315, N316, N321, N323,
         N324, N325, N331, N333, N334, N341, N343, N351, N353, N354, N355,
         N356, N357, N358, N359, N360, N416, N417, N418, N419, N434, N435,
         N436, N437, N438, N439, N440, N441, N442, N443, N444, N445, N446,
         N447, N448, N449, n265, n266, n267, n268, n269, n270, n271, n272,
         n273, n274, n275, n276, n277, n278, n279, n280, n281, n282, n283,
         n284, n285, n286, n287, n288, n289, n290, n291, n292, n293, n294,
         n295, n296, n297, n298, n299, n300, n301, n302, n303, n304, n305,
         n306, n307, n308, n309, n310, n311, n312, n313, n314, n319, n320,
         n321, n322, n323, n324, n325, n326, n327, n328, n329, n330, n331,
         n332, n333, n334, n335, n336, n337, n338, n339, n340, n341, n342,
         n343, n344, n345, n346, n347, n348, n349, n350, n351,
         \add_102/carry[7] , \sub_30/carry[2] , \sub_30/carry[3] ,
         \sub_30/carry[4] , \sub_30/carry[5] , \sub_30/carry[6] ,
         \sub_30/carry[7] , \sub_30/carry[8] , \sub_30/carry[9] ,
         \sub_30/carry[10] , \sub_30/carry[11] , \sub_30/carry[12] ,
         \sub_30/carry[13] , n353, n354, n355, n356, n357, n358, n359, n360,
         n361, n362, n363, n364, n381, n384, n385, n386, n387, n388, n389,
         n390, n391, n392, n393, n394, n395, n396, n397, n398, n399, n400,
         n401, n402, n403, n404, n405, n406, n407, n408, n409, n410, n431,
         n432, n433, n434, n435, n436, n437, n438, n439, n440, n441, n442,
         n443, n444, n445, n446, n447, n448, n449, n450, n451, n452, n453,
         n454, n455, n456, n457, n458, n459, n460, n461, n462, n463, n464,
         n465, n466, n467, n468, n469, n470, n471, n472, n473, n474, n475,
         n476, n477, n478, n479, n480, n481, n482, n483, n484, n485, n486,
         n487, n488, n489, n490, n491, n492, n493, n494, n495, n496, n497,
         n498, n499, n500, n501, n502, n503, n504, n505, n506, n507, n508,
         n509, n510, n511, n512, n513, n514, n515, n516, n517, n518, n519,
         n520, n521, n522, n523, n524, n525, n526, n527, n528, n529, n530,
         n531, n532, n533, n534, n535, n536, n537, n538, n539, n540, n541,
         n542, n543, n544, n545, n546, n547, n548, n549, n550, n551, n553,
         n554, n555, n556, n557, n558, n559, n560, n561, n562, n563, n564,
         n565, n566, n567, n568, n569, n570, n571, n572, n573, n574, n575,
         n576, n577, n578, n579, n580, n581, n582, n583, n584, n585, n586,
         n587, n588, n589, n590, n591, n592, n593, n594, n595, n596, n597,
         n598, n599, n600, n601, n602, n603, n604, n605, n606, n607, n608,
         n609, n610, n611, n612, n613, n614, n615, n616, n617, n618, n619,
         n620, n621, n622, n623, n624, n625, n626, n627, n628, n629, n630,
         n631, n632, n633, n634, n635, n636, n637;
  wire   [7:0] step_counter;
  wire   [7:1] \add_100/carry ;
  wire   [7:1] \add_98/carry ;
  wire   [7:1] \add_96/carry ;
  wire   [7:1] \add_94/carry ;
  wire   [14:0] \sub_50/carry ;
  wire   [14:0] \sub_48/carry ;
  wire   [13:1] \add_40/carry ;
  wire   [13:1] \add_38/carry ;
  wire   [13:1] \r436/carry ;

  LBP_DW01_inc_0 add_146 ( .A(step_counter), .SUM({N441, N440, N439, N438, 
        N437, N436, N435, N434}) );
  LBP_DW01_inc_1 r435 ( .A({n638, gray_addr[12:0]}), .SUM({N60, N59, N58, N57, 
        N56, N55, N54, N53, N52, N51, N50, N49, N48, N47}) );
  DFFRX1 \lbp_data_reg[0]  ( .D(N353), .CK(clk), .RN(n431), .Q(N291) );
  DFFRX1 \lbp_data_reg[6]  ( .D(N359), .CK(clk), .RN(n431), .Q(N351), .QN(n269) );
  DFFRX1 \lbp_data_reg[5]  ( .D(N358), .CK(clk), .RN(n431), .Q(N341), .QN(n268) );
  DFFRX1 \lbp_data_reg[4]  ( .D(N357), .CK(clk), .RN(n431), .Q(N331), .QN(n267) );
  DFFRX1 \lbp_data_reg[3]  ( .D(N356), .CK(clk), .RN(n431), .Q(N321), .QN(n364) );
  DFFRX1 \lbp_data_reg[2]  ( .D(N355), .CK(clk), .RN(n431), .Q(N311), .QN(n266) );
  DFFRX1 \lbp_data_reg[1]  ( .D(N354), .CK(clk), .RN(n431), .Q(N301), .QN(n265) );
  DFFRX1 \mm_lm_reg[6]  ( .D(n336), .CK(clk), .RN(n433), .QN(n286) );
  DFFRX1 \mm_lm_reg[7]  ( .D(n322), .CK(clk), .RN(n431), .QN(n272) );
  DFFRX1 \mm_lm_reg[4]  ( .D(n332), .CK(clk), .RN(n432), .QN(n282) );
  DFFRX1 \mm_lm_reg[5]  ( .D(n334), .CK(clk), .RN(n432), .Q(n363), .QN(n284)
         );
  DFFRX1 \mm_reg[7]  ( .D(n323), .CK(clk), .RN(n431), .Q(n354), .QN(n273) );
  DFFRX1 \mm_reg[5]  ( .D(n335), .CK(clk), .RN(n432), .Q(n362), .QN(n285) );
  DFFRX1 \mm_reg[6]  ( .D(n337), .CK(clk), .RN(n433), .Q(n361), .QN(n288) );
  DFFRX1 \block_counter_reg[2]  ( .D(N418), .CK(clk), .RN(n435), .Q(n633), 
        .QN(n355) );
  DFFRX1 \gray_addr_reg[12]  ( .D(N208), .CK(clk), .RN(n435), .Q(n639), .QN(
        n309) );
  DFFRX1 \gray_addr_reg[11]  ( .D(N207), .CK(clk), .RN(n434), .Q(n640), .QN(
        n307) );
  DFFRX1 \gray_addr_reg[10]  ( .D(N206), .CK(clk), .RN(n434), .Q(n641), .QN(
        n305) );
  DFFRX1 \gray_addr_reg[9]  ( .D(N205), .CK(clk), .RN(n434), .Q(n642), .QN(
        n303) );
  DFFRX1 \gray_addr_reg[8]  ( .D(N204), .CK(clk), .RN(n434), .Q(n643), .QN(
        n301) );
  DFFRX1 \gray_addr_reg[7]  ( .D(N203), .CK(clk), .RN(n435), .Q(n644), .QN(
        n313) );
  DFFRX1 \gray_addr_reg[6]  ( .D(N202), .CK(clk), .RN(n433), .Q(N98), .QN(n289) );
  DFFRX1 \mm_lm_reg[2]  ( .D(n328), .CK(clk), .RN(n432), .QN(n278) );
  DFFRX1 \mm_lm_reg[3]  ( .D(n330), .CK(clk), .RN(n432), .QN(n280) );
  DFFRX1 \mm_reg[2]  ( .D(n329), .CK(clk), .RN(n432), .Q(n359), .QN(n279) );
  DFFRX1 \step_counter_reg[7]  ( .D(N449), .CK(clk), .RN(n435), .Q(
        step_counter[7]) );
  DFFRX1 \block_counter_reg[3]  ( .D(N419), .CK(clk), .RN(n433), .Q(n636) );
  DFFRX1 \block_counter_reg[0]  ( .D(N416), .CK(clk), .RN(n435), .Q(n635), 
        .QN(n360) );
  DFFRX1 \step_counter_reg[4]  ( .D(N446), .CK(clk), .RN(n435), .Q(
        step_counter[4]) );
  DFFRX1 \step_counter_reg[5]  ( .D(N447), .CK(clk), .RN(n435), .Q(
        step_counter[5]) );
  DFFRX1 \step_counter_reg[3]  ( .D(N445), .CK(clk), .RN(n431), .Q(
        step_counter[3]) );
  DFFRX1 \step_counter_reg[6]  ( .D(N448), .CK(clk), .RN(n435), .Q(
        step_counter[6]) );
  DFFRX1 \step_counter_reg[2]  ( .D(N444), .CK(clk), .RN(n434), .Q(
        step_counter[2]) );
  DFFRX1 \step_counter_reg[1]  ( .D(N443), .CK(clk), .RN(n432), .Q(
        step_counter[1]) );
  DFFRX1 \step_counter_reg[0]  ( .D(N442), .CK(clk), .RN(n433), .Q(
        step_counter[0]) );
  DFFRX1 \mm_lm_reg[0]  ( .D(n324), .CK(clk), .RN(n432), .QN(n274) );
  DFFRX1 \gray_addr_reg[3]  ( .D(N199), .CK(clk), .RN(n433), .Q(N95), .QN(n295) );
  DFFRX1 \gray_addr_reg[4]  ( .D(N200), .CK(clk), .RN(n433), .Q(N96), .QN(n293) );
  DFFRX1 \gray_addr_reg[5]  ( .D(N201), .CK(clk), .RN(n433), .Q(N97), .QN(n291) );
  DFFRX1 \mm_lm_reg[1]  ( .D(n326), .CK(clk), .RN(n432), .QN(n276) );
  DFFRX1 \mm_reg[0]  ( .D(n325), .CK(clk), .RN(n432), .Q(n356), .QN(n275) );
  DFFRX1 \mm_reg[3]  ( .D(n331), .CK(clk), .RN(n432), .Q(n353), .QN(n281) );
  DFFRX1 \gray_addr_reg[0]  ( .D(N196), .CK(clk), .RN(n637), .Q(N77), .QN(n319) );
  DFFRX1 \gray_addr_reg[1]  ( .D(N197), .CK(clk), .RN(n434), .Q(N93), .QN(n299) );
  DFFRX1 \gray_addr_reg[2]  ( .D(N198), .CK(clk), .RN(n434), .Q(N94), .QN(n297) );
  DFFRX1 \mm_reg[4]  ( .D(n333), .CK(clk), .RN(n432), .Q(n357), .QN(n283) );
  DFFRX1 \mm_reg[1]  ( .D(n327), .CK(clk), .RN(n432), .Q(n358), .QN(n277) );
  DFFRX1 \gray_addr_reg[13]  ( .D(N209), .CK(clk), .RN(n435), .Q(n638), .QN(
        n311) );
  DFFRX1 \lbp_data_reg[7]  ( .D(N360), .CK(clk), .RN(n431), .Q(n660), .QN(n270) );
  DFFRX1 lbp_valid_reg ( .D(N252), .CK(clk), .RN(n431), .QN(n381) );
  DFFRX1 finish_reg ( .D(n321), .CK(clk), .RN(n431), .Q(n661), .QN(n271) );
  DFFRX1 gray_req_reg ( .D(N246), .CK(clk), .RN(n433), .Q(n645), .QN(n287) );
  DFFRX1 \lbp_addr_reg[5]  ( .D(n339), .CK(clk), .RN(n433), .Q(n654), .QN(n292) );
  DFFRX1 \lbp_addr_reg[4]  ( .D(n340), .CK(clk), .RN(n433), .Q(n655), .QN(n294) );
  DFFRX1 \lbp_addr_reg[3]  ( .D(n341), .CK(clk), .RN(n433), .Q(n656), .QN(n296) );
  DFFRX1 \lbp_addr_reg[2]  ( .D(n342), .CK(clk), .RN(n433), .Q(n657), .QN(n298) );
  DFFRX1 \lbp_addr_reg[6]  ( .D(n338), .CK(clk), .RN(n433), .Q(n653), .QN(n290) );
  DFFRX1 \lbp_addr_reg[1]  ( .D(n343), .CK(clk), .RN(n434), .Q(n658), .QN(n300) );
  DFFRX1 \lbp_addr_reg[8]  ( .D(n344), .CK(clk), .RN(n434), .Q(n651), .QN(n302) );
  DFFRX1 \lbp_addr_reg[9]  ( .D(n345), .CK(clk), .RN(n434), .Q(n650), .QN(n304) );
  DFFRX1 \lbp_addr_reg[10]  ( .D(n346), .CK(clk), .RN(n434), .Q(n649), .QN(
        n306) );
  DFFRX1 \lbp_addr_reg[11]  ( .D(n347), .CK(clk), .RN(n434), .Q(n648), .QN(
        n308) );
  DFFRX1 \lbp_addr_reg[12]  ( .D(n348), .CK(clk), .RN(n434), .Q(n647), .QN(
        n310) );
  DFFRX1 \lbp_addr_reg[13]  ( .D(n349), .CK(clk), .RN(n435), .Q(n646), .QN(
        n312) );
  DFFRX1 \lbp_addr_reg[7]  ( .D(n350), .CK(clk), .RN(n435), .Q(n652), .QN(n314) );
  DFFRX1 \lbp_addr_reg[0]  ( .D(n351), .CK(clk), .RN(n435), .Q(n659), .QN(n320) );
  DFFRX2 \block_counter_reg[1]  ( .D(N417), .CK(clk), .RN(n435), .Q(n634) );
  AND2X4 U290 ( .A(n525), .B(n529), .Y(n526) );
  NOR3X2 U291 ( .A(n399), .B(n406), .C(n477), .Y(n509) );
  BUFX4 U292 ( .A(n474), .Y(n398) );
  NOR2BX1 U293 ( .AN(n526), .B(n457), .Y(n474) );
  BUFX6 U294 ( .A(n476), .Y(n399) );
  NOR2BX4 U295 ( .AN(n526), .B(n450), .Y(n472) );
  AOI221X4 U296 ( .A0(lbp_data[3]), .A1(n470), .B0(n386), .B1(lbp_data[3]), 
        .C0(n494), .Y(n493) );
  INVX12 U297 ( .A(n386), .Y(n471) );
  NOR2X8 U298 ( .A(n392), .B(n387), .Y(n386) );
  AOI2BB2X2 U299 ( .B0(n288), .B1(gray_data[6]), .A0N(n535), .A1N(n536), .Y(
        n533) );
  NOR2X2 U300 ( .A(n390), .B(n358), .Y(n384) );
  AND2X2 U301 ( .A(n391), .B(n543), .Y(n542) );
  OR2X1 U302 ( .A(n384), .B(n385), .Y(n543) );
  OR2X1 U303 ( .A(n275), .B(gray_data[0]), .Y(n385) );
  NOR3X1 U304 ( .A(n393), .B(n394), .C(n395), .Y(n536) );
  AND2X2 U305 ( .A(n537), .B(n538), .Y(n394) );
  CLKINVX1 U306 ( .A(gray_data[1]), .Y(n390) );
  NAND2X2 U307 ( .A(n634), .B(n635), .Y(n450) );
  BUFX12 U308 ( .A(n659), .Y(lbp_addr[0]) );
  BUFX12 U309 ( .A(n652), .Y(lbp_addr[7]) );
  BUFX12 U310 ( .A(n646), .Y(lbp_addr[13]) );
  BUFX12 U311 ( .A(n647), .Y(lbp_addr[12]) );
  BUFX12 U312 ( .A(n648), .Y(lbp_addr[11]) );
  BUFX12 U313 ( .A(n649), .Y(lbp_addr[10]) );
  BUFX12 U314 ( .A(n650), .Y(lbp_addr[9]) );
  BUFX12 U315 ( .A(n651), .Y(lbp_addr[8]) );
  BUFX12 U316 ( .A(n658), .Y(lbp_addr[1]) );
  BUFX12 U317 ( .A(n653), .Y(lbp_addr[6]) );
  BUFX12 U318 ( .A(n657), .Y(lbp_addr[2]) );
  BUFX12 U319 ( .A(n656), .Y(lbp_addr[3]) );
  BUFX12 U320 ( .A(n655), .Y(lbp_addr[4]) );
  BUFX12 U321 ( .A(n654), .Y(lbp_addr[5]) );
  BUFX12 U322 ( .A(n645), .Y(gray_req) );
  BUFX12 U323 ( .A(n661), .Y(finish) );
  INVX12 U324 ( .A(n381), .Y(lbp_valid) );
  INVX12 U325 ( .A(n270), .Y(lbp_data[7]) );
  INVX16 U326 ( .A(n311), .Y(gray_addr[13]) );
  AOI32X2 U327 ( .A0(n539), .A1(n540), .A2(n541), .B0(n439), .B1(n353), .Y(
        n537) );
  OR3X2 U328 ( .A(n397), .B(n398), .C(n473), .Y(n387) );
  CLKBUFX3 U329 ( .A(n472), .Y(n397) );
  AND2X1 U330 ( .A(n386), .B(lbp_data[0]), .Y(n389) );
  MXI2XL U331 ( .A(n277), .B(n390), .S0(n396), .Y(n327) );
  NAND2X1 U332 ( .A(n542), .B(gray_data[2]), .Y(n539) );
  NAND4X1 U333 ( .A(n503), .B(n504), .C(n505), .D(n506), .Y(N353) );
  NOR2X1 U334 ( .A(n470), .B(n494), .Y(n510) );
  AND2X2 U335 ( .A(N252), .B(n525), .Y(n470) );
  AND2XL U336 ( .A(n464), .B(n525), .Y(n507) );
  NOR3X1 U337 ( .A(n388), .B(n389), .C(n507), .Y(n506) );
  BUFX16 U338 ( .A(N291), .Y(lbp_data[0]) );
  CLKINVX1 U339 ( .A(gray_data[0]), .Y(n440) );
  AND2XL U340 ( .A(lbp_data[0]), .B(n470), .Y(n388) );
  AOI22XL U341 ( .A0(N324), .A1(n398), .B0(N315), .B1(n475), .Y(n479) );
  AOI22XL U342 ( .A0(lbp_data[3]), .A1(n398), .B0(n364), .B1(n475), .Y(n491)
         );
  AOI22XL U343 ( .A0(lbp_data[0]), .A1(n398), .B0(lbp_data[0]), .B1(n475), .Y(
        n504) );
  AOI22XL U344 ( .A0(N323), .A1(n398), .B0(N314), .B1(n475), .Y(n483) );
  AOI22XL U345 ( .A0(n267), .A1(n398), .B0(N313), .B1(n475), .Y(n487) );
  NAND3X2 U346 ( .A(n509), .B(n508), .C(n510), .Y(n392) );
  AOI22XL U347 ( .A0(lbp_data[3]), .A1(n397), .B0(lbp_data[3]), .B1(n473), .Y(
        n492) );
  AOI22XL U348 ( .A0(lbp_data[0]), .A1(n397), .B0(lbp_data[0]), .B1(n473), .Y(
        n505) );
  AOI22XL U349 ( .A0(n269), .A1(n397), .B0(N333), .B1(n473), .Y(n480) );
  AOI2BB1XL U350 ( .A0N(n450), .A1N(n449), .B0(n456), .Y(n455) );
  NOR2XL U351 ( .A(n453), .B(n450), .Y(n454) );
  NOR3XL U352 ( .A(n514), .B(n531), .C(n450), .Y(n619) );
  AND2XL U353 ( .A(n283), .B(gray_data[4]), .Y(n395) );
  AND2X2 U354 ( .A(n285), .B(gray_data[5]), .Y(n393) );
  XOR2XL U355 ( .A(n638), .B(\add_40/carry [13]), .Y(N120) );
  AOI2BB1XL U356 ( .A0N(n355), .A1N(n450), .B0(n449), .Y(n452) );
  XOR2XL U357 ( .A(n638), .B(\r436/carry [13]), .Y(N90) );
  XNOR2XL U358 ( .A(n638), .B(\sub_30/carry[13] ), .Y(N45) );
  XNOR2XL U359 ( .A(n638), .B(\sub_50/carry [13]), .Y(N195) );
  MXI2XL U360 ( .A(n281), .B(n439), .S0(n396), .Y(n331) );
  MXI2XL U361 ( .A(n283), .B(n438), .S0(n396), .Y(n333) );
  XOR2XL U362 ( .A(n638), .B(\add_38/carry [13]), .Y(N105) );
  XOR2XL U363 ( .A(n660), .B(\add_94/carry [7]), .Y(N298) );
  XNOR2XL U364 ( .A(n638), .B(\sub_48/carry [13]), .Y(N180) );
  XOR2XL U365 ( .A(n660), .B(lbp_data[6]), .Y(N343) );
  XOR2XL U366 ( .A(n660), .B(\add_100/carry [7]), .Y(N325) );
  XOR2XL U367 ( .A(lbp_data[7]), .B(\add_96/carry [7]), .Y(N307) );
  XOR2XL U368 ( .A(n660), .B(\add_102/carry[7] ), .Y(N334) );
  XOR2XL U369 ( .A(n660), .B(\add_98/carry [7]), .Y(N316) );
  AOI22XL U370 ( .A0(N306), .A1(n399), .B0(N297), .B1(n477), .Y(n478) );
  AOI22XL U371 ( .A0(lbp_data[0]), .A1(n399), .B0(lbp_data[0]), .B1(n477), .Y(
        n503) );
  AOI22XL U372 ( .A0(N303), .A1(n399), .B0(N294), .B1(n477), .Y(n490) );
  NAND2X1 U373 ( .A(n390), .B(n358), .Y(n391) );
  OAI21X4 U374 ( .A0(n542), .A1(gray_data[2]), .B0(n279), .Y(n540) );
  NOR3BXL U375 ( .AN(n525), .B(n531), .C(n450), .Y(n476) );
  AND3X2 U376 ( .A(n527), .B(n528), .C(n526), .Y(n475) );
  MXI2XL U377 ( .A(n275), .B(n440), .S0(n396), .Y(n325) );
  MX2XL U378 ( .A(n359), .B(gray_data[2]), .S0(n396), .Y(n329) );
  AOI2BB2XL U379 ( .B0(lbp_data[6]), .B1(n470), .A0N(n269), .A1N(n471), .Y(
        n481) );
  AOI2BB2XL U380 ( .B0(lbp_data[4]), .B1(n470), .A0N(n267), .A1N(n471), .Y(
        n489) );
  AOI2BB2XL U381 ( .B0(lbp_data[1]), .B1(n470), .A0N(n265), .A1N(n471), .Y(
        n502) );
  AOI2BB2XL U382 ( .B0(lbp_data[5]), .B1(n470), .A0N(n268), .A1N(n471), .Y(
        n485) );
  AOI2BB2XL U383 ( .B0(lbp_data[2]), .B1(n470), .A0N(n266), .A1N(n471), .Y(
        n498) );
  AOI2BB2XL U384 ( .B0(n270), .B1(n470), .A0N(n270), .A1N(n471), .Y(n469) );
  CLKBUFX3 U385 ( .A(n637), .Y(n431) );
  CLKBUFX3 U386 ( .A(n637), .Y(n432) );
  CLKBUFX3 U387 ( .A(n637), .Y(n433) );
  CLKBUFX3 U388 ( .A(n637), .Y(n434) );
  CLKBUFX3 U389 ( .A(n637), .Y(n435) );
  CLKBUFX3 U390 ( .A(n563), .Y(n408) );
  NOR2BX1 U391 ( .AN(n409), .B(n547), .Y(n563) );
  CLKBUFX3 U392 ( .A(n564), .Y(n407) );
  NOR3X1 U393 ( .A(n547), .B(n410), .C(n630), .Y(n564) );
  CLKBUFX3 U394 ( .A(n436), .Y(n406) );
  AND2X2 U395 ( .A(n528), .B(n530), .Y(n436) );
  CLKBUFX3 U396 ( .A(n446), .Y(n409) );
  NOR2BX1 U397 ( .AN(n630), .B(n410), .Y(n446) );
  AND3X2 U398 ( .A(n634), .B(n360), .C(n526), .Y(n473) );
  AND4X2 U399 ( .A(n634), .B(n530), .C(n525), .D(n360), .Y(n477) );
  CLKBUFX3 U400 ( .A(n558), .Y(n403) );
  OA21XL U401 ( .A0(n464), .A1(n622), .B0(gray_ready), .Y(n558) );
  CLKBUFX3 U402 ( .A(n559), .Y(n402) );
  NOR4BBX1 U403 ( .AN(n620), .BN(n621), .C(n408), .D(n407), .Y(n559) );
  BUFX16 U404 ( .A(N93), .Y(gray_addr[1]) );
  BUFX16 U405 ( .A(N94), .Y(gray_addr[2]) );
  BUFX16 U406 ( .A(N77), .Y(gray_addr[0]) );
  CLKBUFX3 U407 ( .A(n561), .Y(n405) );
  AND3X2 U408 ( .A(n406), .B(n465), .C(gray_ready), .Y(n561) );
  CLKBUFX3 U409 ( .A(n562), .Y(n404) );
  AND2X2 U410 ( .A(n456), .B(gray_ready), .Y(n562) );
  CLKBUFX3 U411 ( .A(n557), .Y(n400) );
  AND2X2 U412 ( .A(n618), .B(gray_ready), .Y(n557) );
  CLKBUFX3 U413 ( .A(n560), .Y(n401) );
  AND3X2 U414 ( .A(n528), .B(gray_ready), .C(n529), .Y(n560) );
  BUFX16 U415 ( .A(N95), .Y(gray_addr[3]) );
  BUFX16 U416 ( .A(N96), .Y(gray_addr[4]) );
  BUFX16 U417 ( .A(N97), .Y(gray_addr[5]) );
  BUFX16 U418 ( .A(n644), .Y(gray_addr[7]) );
  BUFX16 U419 ( .A(N98), .Y(gray_addr[6]) );
  CLKBUFX3 U420 ( .A(n447), .Y(n410) );
  NAND3X1 U421 ( .A(n528), .B(n355), .C(n636), .Y(n447) );
  BUFX16 U422 ( .A(n643), .Y(gray_addr[8]) );
  BUFX16 U423 ( .A(n642), .Y(gray_addr[9]) );
  BUFX16 U424 ( .A(n641), .Y(gray_addr[10]) );
  BUFX16 U425 ( .A(N321), .Y(lbp_data[3]) );
  BUFX16 U426 ( .A(N311), .Y(lbp_data[2]) );
  BUFX16 U427 ( .A(N301), .Y(lbp_data[1]) );
  BUFX16 U428 ( .A(n640), .Y(gray_addr[11]) );
  BUFX16 U429 ( .A(n639), .Y(gray_addr[12]) );
  BUFX16 U430 ( .A(N351), .Y(lbp_data[6]) );
  BUFX16 U431 ( .A(N341), .Y(lbp_data[5]) );
  BUFX16 U432 ( .A(N331), .Y(lbp_data[4]) );
  CLKBUFX3 U433 ( .A(n437), .Y(n396) );
  NOR2BX1 U434 ( .AN(n406), .B(n287), .Y(n437) );
  OAI32X4 U435 ( .A0(n532), .A1(n533), .A2(n534), .B0(n441), .B1(n354), .Y(
        n525) );
  AND2X1 U436 ( .A(lbp_data[5]), .B(lbp_data[6]), .Y(\add_102/carry[7] ) );
  XOR2X1 U437 ( .A(lbp_data[6]), .B(lbp_data[5]), .Y(N333) );
  AND2X1 U438 ( .A(\add_98/carry [6]), .B(lbp_data[6]), .Y(\add_98/carry [7])
         );
  XOR2X1 U439 ( .A(lbp_data[6]), .B(\add_98/carry [6]), .Y(N315) );
  AND2X1 U440 ( .A(\add_98/carry [5]), .B(lbp_data[5]), .Y(\add_98/carry [6])
         );
  XOR2X1 U441 ( .A(lbp_data[5]), .B(\add_98/carry [5]), .Y(N314) );
  AND2X1 U442 ( .A(lbp_data[3]), .B(lbp_data[4]), .Y(\add_98/carry [5]) );
  XOR2X1 U443 ( .A(lbp_data[4]), .B(lbp_data[3]), .Y(N313) );
  AND2X1 U444 ( .A(\add_100/carry [6]), .B(lbp_data[6]), .Y(\add_100/carry [7]) );
  XOR2X1 U445 ( .A(lbp_data[6]), .B(\add_100/carry [6]), .Y(N324) );
  AND2X1 U446 ( .A(lbp_data[4]), .B(lbp_data[5]), .Y(\add_100/carry [6]) );
  XOR2X1 U447 ( .A(lbp_data[5]), .B(lbp_data[4]), .Y(N323) );
  AND2X1 U448 ( .A(\add_94/carry [6]), .B(lbp_data[6]), .Y(\add_94/carry [7])
         );
  XOR2X1 U449 ( .A(lbp_data[6]), .B(\add_94/carry [6]), .Y(N297) );
  AND2X1 U450 ( .A(\add_94/carry [5]), .B(lbp_data[5]), .Y(\add_94/carry [6])
         );
  XOR2X1 U451 ( .A(lbp_data[5]), .B(\add_94/carry [5]), .Y(N296) );
  AND2X1 U452 ( .A(\add_94/carry [4]), .B(lbp_data[4]), .Y(\add_94/carry [5])
         );
  XOR2X1 U453 ( .A(lbp_data[4]), .B(\add_94/carry [4]), .Y(N295) );
  AND2X1 U454 ( .A(\add_94/carry [3]), .B(lbp_data[3]), .Y(\add_94/carry [4])
         );
  XOR2X1 U455 ( .A(lbp_data[3]), .B(\add_94/carry [3]), .Y(N294) );
  AND2X1 U456 ( .A(lbp_data[1]), .B(lbp_data[2]), .Y(\add_94/carry [3]) );
  XOR2X1 U457 ( .A(lbp_data[2]), .B(lbp_data[1]), .Y(N293) );
  AND2X1 U458 ( .A(\add_96/carry [6]), .B(lbp_data[6]), .Y(\add_96/carry [7])
         );
  XOR2X1 U459 ( .A(lbp_data[6]), .B(\add_96/carry [6]), .Y(N306) );
  AND2X1 U460 ( .A(\add_96/carry [5]), .B(lbp_data[5]), .Y(\add_96/carry [6])
         );
  XOR2X1 U461 ( .A(lbp_data[5]), .B(\add_96/carry [5]), .Y(N305) );
  AND2X1 U462 ( .A(\add_96/carry [4]), .B(lbp_data[4]), .Y(\add_96/carry [5])
         );
  XOR2X1 U463 ( .A(lbp_data[4]), .B(\add_96/carry [4]), .Y(N304) );
  AND2X1 U464 ( .A(lbp_data[2]), .B(lbp_data[3]), .Y(\add_96/carry [4]) );
  XOR2X1 U465 ( .A(lbp_data[3]), .B(lbp_data[2]), .Y(N303) );
  AND2X1 U466 ( .A(\r436/carry [12]), .B(gray_addr[12]), .Y(\r436/carry [13])
         );
  XOR2X1 U467 ( .A(gray_addr[12]), .B(\r436/carry [12]), .Y(N89) );
  AND2X1 U468 ( .A(\r436/carry [11]), .B(gray_addr[11]), .Y(\r436/carry [12])
         );
  XOR2X1 U469 ( .A(gray_addr[11]), .B(\r436/carry [11]), .Y(N88) );
  AND2X1 U470 ( .A(\r436/carry [10]), .B(gray_addr[10]), .Y(\r436/carry [11])
         );
  XOR2X1 U471 ( .A(gray_addr[10]), .B(\r436/carry [10]), .Y(N87) );
  AND2X1 U472 ( .A(\r436/carry [9]), .B(gray_addr[9]), .Y(\r436/carry [10]) );
  XOR2X1 U473 ( .A(gray_addr[9]), .B(\r436/carry [9]), .Y(N86) );
  AND2X1 U474 ( .A(\r436/carry [8]), .B(gray_addr[8]), .Y(\r436/carry [9]) );
  XOR2X1 U475 ( .A(gray_addr[8]), .B(\r436/carry [8]), .Y(N85) );
  AND2X1 U476 ( .A(\add_40/carry [12]), .B(gray_addr[12]), .Y(
        \add_40/carry [13]) );
  XOR2X1 U477 ( .A(gray_addr[12]), .B(\add_40/carry [12]), .Y(N119) );
  AND2X1 U478 ( .A(\add_40/carry [11]), .B(gray_addr[11]), .Y(
        \add_40/carry [12]) );
  XOR2X1 U479 ( .A(gray_addr[11]), .B(\add_40/carry [11]), .Y(N118) );
  AND2X1 U480 ( .A(\add_40/carry [10]), .B(gray_addr[10]), .Y(
        \add_40/carry [11]) );
  XOR2X1 U481 ( .A(gray_addr[10]), .B(\add_40/carry [10]), .Y(N117) );
  AND2X1 U482 ( .A(\add_40/carry [9]), .B(gray_addr[9]), .Y(\add_40/carry [10]) );
  XOR2X1 U483 ( .A(gray_addr[9]), .B(\add_40/carry [9]), .Y(N116) );
  AND2X1 U484 ( .A(\add_40/carry [8]), .B(gray_addr[8]), .Y(\add_40/carry [9])
         );
  XOR2X1 U485 ( .A(gray_addr[8]), .B(\add_40/carry [8]), .Y(N115) );
  AND2X1 U486 ( .A(\add_38/carry [12]), .B(gray_addr[12]), .Y(
        \add_38/carry [13]) );
  XOR2X1 U487 ( .A(gray_addr[12]), .B(\add_38/carry [12]), .Y(N104) );
  AND2X1 U488 ( .A(\add_38/carry [11]), .B(gray_addr[11]), .Y(
        \add_38/carry [12]) );
  XOR2X1 U489 ( .A(gray_addr[11]), .B(\add_38/carry [11]), .Y(N103) );
  AND2X1 U490 ( .A(\add_38/carry [10]), .B(gray_addr[10]), .Y(
        \add_38/carry [11]) );
  XOR2X1 U491 ( .A(gray_addr[10]), .B(\add_38/carry [10]), .Y(N102) );
  AND2X1 U492 ( .A(\add_38/carry [9]), .B(gray_addr[9]), .Y(\add_38/carry [10]) );
  XOR2X1 U493 ( .A(gray_addr[9]), .B(\add_38/carry [9]), .Y(N101) );
  AND2X1 U494 ( .A(gray_addr[7]), .B(gray_addr[8]), .Y(\add_38/carry [9]) );
  XOR2X1 U495 ( .A(gray_addr[8]), .B(gray_addr[7]), .Y(N100) );
  OR2X1 U496 ( .A(gray_addr[12]), .B(\sub_30/carry[12] ), .Y(
        \sub_30/carry[13] ) );
  XNOR2X1 U497 ( .A(\sub_30/carry[12] ), .B(gray_addr[12]), .Y(N44) );
  OR2X1 U498 ( .A(gray_addr[11]), .B(\sub_30/carry[11] ), .Y(
        \sub_30/carry[12] ) );
  XNOR2X1 U499 ( .A(\sub_30/carry[11] ), .B(gray_addr[11]), .Y(N43) );
  OR2X1 U500 ( .A(gray_addr[10]), .B(\sub_30/carry[10] ), .Y(
        \sub_30/carry[11] ) );
  XNOR2X1 U501 ( .A(\sub_30/carry[10] ), .B(gray_addr[10]), .Y(N42) );
  OR2X1 U502 ( .A(gray_addr[9]), .B(\sub_30/carry[9] ), .Y(\sub_30/carry[10] )
         );
  XNOR2X1 U503 ( .A(\sub_30/carry[9] ), .B(gray_addr[9]), .Y(N41) );
  OR2X1 U504 ( .A(gray_addr[8]), .B(\sub_30/carry[8] ), .Y(\sub_30/carry[9] )
         );
  XNOR2X1 U505 ( .A(\sub_30/carry[8] ), .B(gray_addr[8]), .Y(N40) );
  OR2X1 U506 ( .A(gray_addr[12]), .B(\sub_50/carry [12]), .Y(
        \sub_50/carry [13]) );
  XNOR2X1 U507 ( .A(\sub_50/carry [12]), .B(gray_addr[12]), .Y(N194) );
  OR2X1 U508 ( .A(gray_addr[11]), .B(\sub_50/carry [11]), .Y(
        \sub_50/carry [12]) );
  XNOR2X1 U509 ( .A(\sub_50/carry [11]), .B(gray_addr[11]), .Y(N193) );
  OR2X1 U510 ( .A(gray_addr[10]), .B(\sub_50/carry [10]), .Y(
        \sub_50/carry [11]) );
  XNOR2X1 U511 ( .A(\sub_50/carry [10]), .B(gray_addr[10]), .Y(N192) );
  OR2X1 U512 ( .A(gray_addr[9]), .B(\sub_50/carry [9]), .Y(\sub_50/carry [10])
         );
  XNOR2X1 U513 ( .A(\sub_50/carry [9]), .B(gray_addr[9]), .Y(N191) );
  OR2X1 U514 ( .A(gray_addr[8]), .B(\sub_50/carry [8]), .Y(\sub_50/carry [9])
         );
  XNOR2X1 U515 ( .A(\sub_50/carry [8]), .B(gray_addr[8]), .Y(N190) );
  OR2X1 U516 ( .A(gray_addr[12]), .B(\sub_48/carry [12]), .Y(
        \sub_48/carry [13]) );
  XNOR2X1 U517 ( .A(\sub_48/carry [12]), .B(gray_addr[12]), .Y(N179) );
  OR2X1 U518 ( .A(gray_addr[11]), .B(\sub_48/carry [11]), .Y(
        \sub_48/carry [12]) );
  XNOR2X1 U519 ( .A(\sub_48/carry [11]), .B(gray_addr[11]), .Y(N178) );
  OR2X1 U520 ( .A(gray_addr[10]), .B(\sub_48/carry [10]), .Y(
        \sub_48/carry [11]) );
  XNOR2X1 U521 ( .A(\sub_48/carry [10]), .B(gray_addr[10]), .Y(N177) );
  OR2X1 U522 ( .A(gray_addr[9]), .B(\sub_48/carry [9]), .Y(\sub_48/carry [10])
         );
  XNOR2X1 U523 ( .A(\sub_48/carry [9]), .B(gray_addr[9]), .Y(N176) );
  OR2X1 U524 ( .A(gray_addr[8]), .B(gray_addr[7]), .Y(\sub_48/carry [9]) );
  XNOR2X1 U525 ( .A(gray_addr[7]), .B(gray_addr[8]), .Y(N175) );
  AND2X1 U526 ( .A(\r436/carry [7]), .B(gray_addr[7]), .Y(\r436/carry [8]) );
  XOR2X1 U527 ( .A(gray_addr[7]), .B(\r436/carry [7]), .Y(N84) );
  OR2X1 U528 ( .A(gray_addr[6]), .B(\r436/carry [6]), .Y(\r436/carry [7]) );
  XNOR2X1 U529 ( .A(\r436/carry [6]), .B(gray_addr[6]), .Y(N83) );
  OR2X1 U530 ( .A(gray_addr[5]), .B(\r436/carry [5]), .Y(\r436/carry [6]) );
  XNOR2X1 U531 ( .A(\r436/carry [5]), .B(gray_addr[5]), .Y(N82) );
  OR2X1 U532 ( .A(gray_addr[4]), .B(\r436/carry [4]), .Y(\r436/carry [5]) );
  XNOR2X1 U533 ( .A(\r436/carry [4]), .B(gray_addr[4]), .Y(N81) );
  OR2X1 U534 ( .A(gray_addr[3]), .B(\r436/carry [3]), .Y(\r436/carry [4]) );
  XNOR2X1 U535 ( .A(\r436/carry [3]), .B(gray_addr[3]), .Y(N80) );
  OR2X1 U536 ( .A(gray_addr[2]), .B(gray_addr[1]), .Y(\r436/carry [3]) );
  XNOR2X1 U537 ( .A(gray_addr[1]), .B(gray_addr[2]), .Y(N79) );
  AND2X1 U538 ( .A(\add_40/carry [7]), .B(gray_addr[7]), .Y(\add_40/carry [8])
         );
  XOR2X1 U539 ( .A(gray_addr[7]), .B(\add_40/carry [7]), .Y(N114) );
  AND2X1 U540 ( .A(\add_40/carry [6]), .B(gray_addr[6]), .Y(\add_40/carry [7])
         );
  XOR2X1 U541 ( .A(gray_addr[6]), .B(\add_40/carry [6]), .Y(N113) );
  AND2X1 U542 ( .A(\add_40/carry [5]), .B(gray_addr[5]), .Y(\add_40/carry [6])
         );
  XOR2X1 U543 ( .A(gray_addr[5]), .B(\add_40/carry [5]), .Y(N112) );
  AND2X1 U544 ( .A(\add_40/carry [4]), .B(gray_addr[4]), .Y(\add_40/carry [5])
         );
  XOR2X1 U545 ( .A(gray_addr[4]), .B(\add_40/carry [4]), .Y(N111) );
  AND2X1 U546 ( .A(\add_40/carry [3]), .B(gray_addr[3]), .Y(\add_40/carry [4])
         );
  XOR2X1 U547 ( .A(gray_addr[3]), .B(\add_40/carry [3]), .Y(N110) );
  AND2X1 U548 ( .A(gray_addr[1]), .B(gray_addr[2]), .Y(\add_40/carry [3]) );
  XOR2X1 U549 ( .A(gray_addr[2]), .B(gray_addr[1]), .Y(N109) );
  AND2X1 U550 ( .A(\sub_30/carry[7] ), .B(gray_addr[7]), .Y(\sub_30/carry[8] )
         );
  XOR2X1 U551 ( .A(gray_addr[7]), .B(\sub_30/carry[7] ), .Y(N39) );
  OR2X1 U552 ( .A(gray_addr[6]), .B(\sub_30/carry[6] ), .Y(\sub_30/carry[7] )
         );
  XNOR2X1 U553 ( .A(\sub_30/carry[6] ), .B(gray_addr[6]), .Y(N38) );
  OR2X1 U554 ( .A(gray_addr[5]), .B(\sub_30/carry[5] ), .Y(\sub_30/carry[6] )
         );
  XNOR2X1 U555 ( .A(\sub_30/carry[5] ), .B(gray_addr[5]), .Y(N37) );
  OR2X1 U556 ( .A(gray_addr[4]), .B(\sub_30/carry[4] ), .Y(\sub_30/carry[5] )
         );
  XNOR2X1 U557 ( .A(\sub_30/carry[4] ), .B(gray_addr[4]), .Y(N36) );
  OR2X1 U558 ( .A(gray_addr[3]), .B(\sub_30/carry[3] ), .Y(\sub_30/carry[4] )
         );
  XNOR2X1 U559 ( .A(\sub_30/carry[3] ), .B(gray_addr[3]), .Y(N35) );
  OR2X1 U560 ( .A(gray_addr[2]), .B(\sub_30/carry[2] ), .Y(\sub_30/carry[3] )
         );
  XNOR2X1 U561 ( .A(\sub_30/carry[2] ), .B(gray_addr[2]), .Y(N34) );
  OR2X1 U562 ( .A(gray_addr[1]), .B(gray_addr[0]), .Y(\sub_30/carry[2] ) );
  XNOR2X1 U563 ( .A(gray_addr[0]), .B(gray_addr[1]), .Y(N33) );
  OR2X1 U564 ( .A(gray_addr[7]), .B(\sub_50/carry [7]), .Y(\sub_50/carry [8])
         );
  XNOR2X1 U565 ( .A(\sub_50/carry [7]), .B(gray_addr[7]), .Y(N189) );
  AND2X1 U566 ( .A(\sub_50/carry [6]), .B(gray_addr[6]), .Y(\sub_50/carry [7])
         );
  XOR2X1 U567 ( .A(gray_addr[6]), .B(\sub_50/carry [6]), .Y(N188) );
  AND2X1 U568 ( .A(\sub_50/carry [5]), .B(gray_addr[5]), .Y(\sub_50/carry [6])
         );
  XOR2X1 U569 ( .A(gray_addr[5]), .B(\sub_50/carry [5]), .Y(N187) );
  AND2X1 U570 ( .A(\sub_50/carry [4]), .B(gray_addr[4]), .Y(\sub_50/carry [5])
         );
  XOR2X1 U571 ( .A(gray_addr[4]), .B(\sub_50/carry [4]), .Y(N186) );
  AND2X1 U572 ( .A(\sub_50/carry [3]), .B(gray_addr[3]), .Y(\sub_50/carry [4])
         );
  XOR2X1 U573 ( .A(gray_addr[3]), .B(\sub_50/carry [3]), .Y(N185) );
  AND2X1 U574 ( .A(gray_addr[1]), .B(gray_addr[2]), .Y(\sub_50/carry [3]) );
  XOR2X1 U575 ( .A(gray_addr[2]), .B(gray_addr[1]), .Y(N184) );
  CLKINVX1 U576 ( .A(reset), .Y(n637) );
  MXI2X1 U577 ( .A(n320), .B(n319), .S0(n406), .Y(n351) );
  MXI2X1 U578 ( .A(n314), .B(n313), .S0(n406), .Y(n350) );
  MXI2X1 U579 ( .A(n312), .B(n311), .S0(n406), .Y(n349) );
  MXI2X1 U580 ( .A(n310), .B(n309), .S0(n406), .Y(n348) );
  MXI2X1 U581 ( .A(n308), .B(n307), .S0(n406), .Y(n347) );
  MXI2X1 U582 ( .A(n306), .B(n305), .S0(n406), .Y(n346) );
  MXI2X1 U583 ( .A(n304), .B(n303), .S0(n406), .Y(n345) );
  MXI2X1 U584 ( .A(n302), .B(n301), .S0(n406), .Y(n344) );
  MXI2X1 U585 ( .A(n300), .B(n299), .S0(n406), .Y(n343) );
  MXI2X1 U586 ( .A(n298), .B(n297), .S0(n406), .Y(n342) );
  MXI2X1 U587 ( .A(n296), .B(n295), .S0(n406), .Y(n341) );
  MXI2X1 U588 ( .A(n294), .B(n293), .S0(n406), .Y(n340) );
  MXI2X1 U589 ( .A(n292), .B(n291), .S0(n406), .Y(n339) );
  MXI2X1 U590 ( .A(n290), .B(n289), .S0(n406), .Y(n338) );
  CLKMX2X2 U591 ( .A(n361), .B(gray_data[6]), .S0(n396), .Y(n337) );
  MXI2X1 U592 ( .A(n286), .B(n288), .S0(n396), .Y(n336) );
  CLKMX2X2 U593 ( .A(n362), .B(gray_data[5]), .S0(n396), .Y(n335) );
  MXI2X1 U594 ( .A(n284), .B(n285), .S0(n396), .Y(n334) );
  MXI2X1 U595 ( .A(n282), .B(n283), .S0(n396), .Y(n332) );
  MXI2X1 U596 ( .A(n280), .B(n281), .S0(n396), .Y(n330) );
  MXI2X1 U597 ( .A(n278), .B(n279), .S0(n396), .Y(n328) );
  MXI2X1 U598 ( .A(n276), .B(n277), .S0(n396), .Y(n326) );
  MXI2X1 U599 ( .A(n274), .B(n275), .S0(n396), .Y(n324) );
  MXI2X1 U600 ( .A(n273), .B(n441), .S0(n396), .Y(n323) );
  MXI2X1 U601 ( .A(n272), .B(n273), .S0(n396), .Y(n322) );
  OAI31XL U602 ( .A0(n442), .A1(n443), .A2(n444), .B0(n271), .Y(n321) );
  OR4X1 U603 ( .A(n300), .B(n302), .C(n304), .D(n306), .Y(n444) );
  OR4X1 U604 ( .A(n308), .B(n310), .C(n312), .D(n381), .Y(n443) );
  NAND4BX1 U605 ( .AN(n290), .B(n314), .C(n320), .D(n445), .Y(n442) );
  NOR4X1 U606 ( .A(n298), .B(n296), .C(n294), .D(n292), .Y(n445) );
  AO22X1 U607 ( .A0(N441), .A1(n409), .B0(step_counter[7]), .B1(n410), .Y(N449) );
  AO22X1 U608 ( .A0(N440), .A1(n409), .B0(step_counter[6]), .B1(n410), .Y(N448) );
  AO22X1 U609 ( .A0(N439), .A1(n409), .B0(step_counter[5]), .B1(n410), .Y(N447) );
  AO22X1 U610 ( .A0(N438), .A1(n409), .B0(step_counter[4]), .B1(n410), .Y(N446) );
  AO22X1 U611 ( .A0(N437), .A1(n409), .B0(step_counter[3]), .B1(n410), .Y(N445) );
  AO22X1 U612 ( .A0(N436), .A1(n409), .B0(step_counter[2]), .B1(n410), .Y(N444) );
  AO22X1 U613 ( .A0(N435), .A1(n409), .B0(step_counter[1]), .B1(n410), .Y(N443) );
  AO22X1 U614 ( .A0(N434), .A1(n409), .B0(step_counter[0]), .B1(n410), .Y(N442) );
  OAI31XL U615 ( .A0(n448), .A1(n449), .A2(n450), .B0(n451), .Y(N419) );
  OAI21XL U616 ( .A0(n452), .A1(n453), .B0(n636), .Y(n451) );
  MXI2X1 U617 ( .A(n454), .B(n455), .S0(n355), .Y(N418) );
  OAI21XL U618 ( .A0(n449), .A1(n457), .B0(n458), .Y(N417) );
  OAI21XL U619 ( .A0(n453), .A1(n360), .B0(n634), .Y(n458) );
  MXI2X1 U620 ( .A(n459), .B(n449), .S0(n360), .Y(N416) );
  CLKINVX1 U621 ( .A(n460), .Y(n449) );
  NOR2X1 U622 ( .A(n453), .B(n456), .Y(n459) );
  NOR3X1 U623 ( .A(n456), .B(n461), .C(n460), .Y(n453) );
  NAND2X1 U624 ( .A(n462), .B(n463), .Y(n460) );
  OAI211X1 U625 ( .A0(n464), .A1(n465), .B0(n410), .C0(gray_ready), .Y(n463)
         );
  NAND4X1 U626 ( .A(n466), .B(n467), .C(n468), .D(n469), .Y(N360) );
  AOI22X1 U627 ( .A0(N343), .A1(n397), .B0(N334), .B1(n473), .Y(n468) );
  AOI22X1 U628 ( .A0(N325), .A1(n398), .B0(N316), .B1(n475), .Y(n467) );
  AOI22X1 U629 ( .A0(N307), .A1(n399), .B0(N298), .B1(n477), .Y(n466) );
  NAND4X1 U630 ( .A(n478), .B(n479), .C(n480), .D(n481), .Y(N359) );
  NAND4X1 U631 ( .A(n482), .B(n483), .C(n484), .D(n485), .Y(N358) );
  AOI22X1 U632 ( .A0(lbp_data[5]), .A1(n397), .B0(n268), .B1(n473), .Y(n484)
         );
  AOI22X1 U633 ( .A0(N305), .A1(n399), .B0(N296), .B1(n477), .Y(n482) );
  NAND4X1 U634 ( .A(n486), .B(n487), .C(n488), .D(n489), .Y(N357) );
  AOI22X1 U635 ( .A0(lbp_data[4]), .A1(n397), .B0(lbp_data[4]), .B1(n473), .Y(
        n488) );
  AOI22X1 U636 ( .A0(N304), .A1(n399), .B0(N295), .B1(n477), .Y(n486) );
  NAND4X1 U637 ( .A(n490), .B(n491), .C(n492), .D(n493), .Y(N356) );
  NAND4X1 U638 ( .A(n495), .B(n496), .C(n497), .D(n498), .Y(N355) );
  AOI22X1 U639 ( .A0(lbp_data[2]), .A1(n397), .B0(lbp_data[2]), .B1(n473), .Y(
        n497) );
  AOI22X1 U640 ( .A0(lbp_data[2]), .A1(n398), .B0(lbp_data[2]), .B1(n475), .Y(
        n496) );
  AOI22X1 U641 ( .A0(n266), .A1(n399), .B0(N293), .B1(n477), .Y(n495) );
  NAND4X1 U642 ( .A(n499), .B(n500), .C(n501), .D(n502), .Y(N354) );
  AOI22X1 U643 ( .A0(lbp_data[1]), .A1(n397), .B0(lbp_data[1]), .B1(n473), .Y(
        n501) );
  AOI22X1 U644 ( .A0(lbp_data[1]), .A1(n398), .B0(lbp_data[1]), .B1(n475), .Y(
        n500) );
  AOI22X1 U645 ( .A0(lbp_data[1]), .A1(n399), .B0(n265), .B1(n477), .Y(n499)
         );
  CLKINVX1 U646 ( .A(n511), .Y(n494) );
  OAI211X1 U647 ( .A0(n512), .A1(n513), .B0(n514), .C0(n464), .Y(n511) );
  NOR2X1 U648 ( .A(n272), .B(n354), .Y(n513) );
  AOI222XL U649 ( .A0(n286), .A1(n361), .B0(n515), .B1(n516), .C0(n272), .C1(
        n354), .Y(n512) );
  NAND2BX1 U650 ( .AN(n286), .B(n288), .Y(n516) );
  OAI32X1 U651 ( .A0(n517), .A1(n518), .A2(n519), .B0(n285), .B1(n363), .Y(
        n515) );
  NOR2X1 U652 ( .A(n282), .B(n357), .Y(n519) );
  AOI221XL U653 ( .A0(n282), .A1(n357), .B0(n280), .B1(n353), .C0(n520), .Y(
        n518) );
  CLKINVX1 U654 ( .A(n521), .Y(n520) );
  OAI222XL U655 ( .A0(n353), .A1(n280), .B0(n359), .B1(n522), .C0(n523), .C1(
        n278), .Y(n521) );
  AND2X1 U656 ( .A(n278), .B(n523), .Y(n522) );
  OAI2BB1X1 U657 ( .A0N(n358), .A1N(n276), .B0(n524), .Y(n523) );
  OAI211X1 U658 ( .A0(n276), .A1(n358), .B0(n356), .C0(n274), .Y(n524) );
  NOR2X1 U659 ( .A(n284), .B(n362), .Y(n517) );
  NOR2X1 U660 ( .A(n475), .B(n507), .Y(n508) );
  CLKINVX1 U661 ( .A(gray_data[7]), .Y(n441) );
  NOR2X1 U662 ( .A(n288), .B(gray_data[6]), .Y(n534) );
  NAND2X1 U663 ( .A(n438), .B(n357), .Y(n538) );
  CLKINVX1 U664 ( .A(gray_data[4]), .Y(n438) );
  CLKINVX1 U665 ( .A(gray_data[3]), .Y(n439) );
  NAND2X1 U666 ( .A(n281), .B(gray_data[3]), .Y(n541) );
  NOR2X1 U667 ( .A(n285), .B(gray_data[5]), .Y(n535) );
  NOR2X1 U668 ( .A(n273), .B(gray_data[7]), .Y(n532) );
  AND4X1 U669 ( .A(n461), .B(n271), .C(n544), .D(n465), .Y(N252) );
  NAND3X1 U670 ( .A(gray_addr[7]), .B(gray_addr[0]), .C(n545), .Y(n544) );
  CLKINVX1 U671 ( .A(n410), .Y(n461) );
  MXI2X1 U672 ( .A(n546), .B(n287), .S0(n547), .Y(N246) );
  NOR4X1 U673 ( .A(n548), .B(n549), .C(n550), .D(n551), .Y(n546) );
  NAND3X1 U674 ( .A(gray_addr[5]), .B(gray_addr[4]), .C(gray_addr[6]), .Y(n551) );
  NAND4X1 U675 ( .A(gray_addr[3]), .B(gray_addr[2]), .C(gray_addr[1]), .D(
        gray_addr[8]), .Y(n550) );
  NAND3X1 U676 ( .A(gray_addr[10]), .B(gray_addr[11]), .C(gray_addr[9]), .Y(
        n549) );
  NAND4X1 U677 ( .A(gray_addr[12]), .B(gray_addr[13]), .C(gray_addr[7]), .D(
        gray_addr[0]), .Y(n548) );
  NAND4X1 U678 ( .A(n553), .B(n554), .C(n555), .D(n556), .Y(N209) );
  AOI22X1 U679 ( .A0(N90), .A1(n400), .B0(N60), .B1(n403), .Y(n556) );
  AOI22X1 U680 ( .A0(n402), .A1(gray_addr[13]), .B0(N120), .B1(n401), .Y(n555)
         );
  AOI22X1 U681 ( .A0(N45), .A1(n405), .B0(N105), .B1(n404), .Y(n554) );
  AOI22X1 U682 ( .A0(N180), .A1(n408), .B0(N195), .B1(n407), .Y(n553) );
  NAND4X1 U683 ( .A(n565), .B(n566), .C(n567), .D(n568), .Y(N208) );
  AOI22X1 U684 ( .A0(N89), .A1(n400), .B0(N59), .B1(n403), .Y(n568) );
  AOI22X1 U685 ( .A0(n402), .A1(gray_addr[12]), .B0(N119), .B1(n401), .Y(n567)
         );
  AOI22X1 U686 ( .A0(N44), .A1(n405), .B0(N104), .B1(n404), .Y(n566) );
  AOI22X1 U687 ( .A0(N179), .A1(n408), .B0(N194), .B1(n407), .Y(n565) );
  NAND4X1 U688 ( .A(n569), .B(n570), .C(n571), .D(n572), .Y(N207) );
  AOI22X1 U689 ( .A0(N88), .A1(n400), .B0(N58), .B1(n403), .Y(n572) );
  AOI22X1 U690 ( .A0(n402), .A1(gray_addr[11]), .B0(N118), .B1(n401), .Y(n571)
         );
  AOI22X1 U691 ( .A0(N43), .A1(n405), .B0(N103), .B1(n404), .Y(n570) );
  AOI22X1 U692 ( .A0(N178), .A1(n408), .B0(N193), .B1(n407), .Y(n569) );
  NAND4X1 U693 ( .A(n573), .B(n574), .C(n575), .D(n576), .Y(N206) );
  AOI22X1 U694 ( .A0(N87), .A1(n400), .B0(N57), .B1(n403), .Y(n576) );
  AOI22X1 U695 ( .A0(n402), .A1(gray_addr[10]), .B0(N117), .B1(n401), .Y(n575)
         );
  AOI22X1 U696 ( .A0(N42), .A1(n405), .B0(N102), .B1(n404), .Y(n574) );
  AOI22X1 U697 ( .A0(N177), .A1(n408), .B0(N192), .B1(n407), .Y(n573) );
  NAND4X1 U698 ( .A(n577), .B(n578), .C(n579), .D(n580), .Y(N205) );
  AOI22X1 U699 ( .A0(N86), .A1(n400), .B0(N56), .B1(n403), .Y(n580) );
  AOI22X1 U700 ( .A0(n402), .A1(gray_addr[9]), .B0(N116), .B1(n401), .Y(n579)
         );
  AOI22X1 U701 ( .A0(N41), .A1(n405), .B0(N101), .B1(n404), .Y(n578) );
  AOI22X1 U702 ( .A0(N176), .A1(n408), .B0(N191), .B1(n407), .Y(n577) );
  NAND4X1 U703 ( .A(n581), .B(n582), .C(n583), .D(n584), .Y(N204) );
  AOI22X1 U704 ( .A0(N85), .A1(n400), .B0(N55), .B1(n403), .Y(n584) );
  AOI22X1 U705 ( .A0(n402), .A1(gray_addr[8]), .B0(N115), .B1(n401), .Y(n583)
         );
  AOI22X1 U706 ( .A0(N40), .A1(n405), .B0(N100), .B1(n404), .Y(n582) );
  AOI22X1 U707 ( .A0(N175), .A1(n408), .B0(N190), .B1(n407), .Y(n581) );
  NAND4X1 U708 ( .A(n585), .B(n586), .C(n587), .D(n588), .Y(N203) );
  AOI221XL U709 ( .A0(N54), .A1(n403), .B0(N84), .B1(n400), .C0(n589), .Y(n588) );
  AOI22X1 U710 ( .A0(n402), .A1(gray_addr[7]), .B0(N114), .B1(n401), .Y(n587)
         );
  AOI22X1 U711 ( .A0(N39), .A1(n405), .B0(n313), .B1(n404), .Y(n586) );
  AOI22X1 U712 ( .A0(n313), .A1(n408), .B0(N189), .B1(n407), .Y(n585) );
  NAND4X1 U713 ( .A(n590), .B(n591), .C(n592), .D(n593), .Y(N202) );
  AOI22X1 U714 ( .A0(N83), .A1(n400), .B0(N53), .B1(n403), .Y(n593) );
  AOI22X1 U715 ( .A0(n402), .A1(gray_addr[6]), .B0(N113), .B1(n401), .Y(n592)
         );
  AOI22X1 U716 ( .A0(N38), .A1(n405), .B0(gray_addr[6]), .B1(n404), .Y(n591)
         );
  AOI22X1 U717 ( .A0(gray_addr[6]), .A1(n408), .B0(N188), .B1(n407), .Y(n590)
         );
  NAND4X1 U718 ( .A(n594), .B(n595), .C(n596), .D(n597), .Y(N201) );
  AOI22X1 U719 ( .A0(N82), .A1(n400), .B0(N52), .B1(n403), .Y(n597) );
  AOI22X1 U720 ( .A0(n402), .A1(gray_addr[5]), .B0(N112), .B1(n401), .Y(n596)
         );
  AOI22X1 U721 ( .A0(N37), .A1(n405), .B0(gray_addr[5]), .B1(n404), .Y(n595)
         );
  AOI22X1 U722 ( .A0(gray_addr[5]), .A1(n408), .B0(N187), .B1(n407), .Y(n594)
         );
  NAND4X1 U723 ( .A(n598), .B(n599), .C(n600), .D(n601), .Y(N200) );
  AOI22X1 U724 ( .A0(N81), .A1(n400), .B0(N51), .B1(n403), .Y(n601) );
  AOI22X1 U725 ( .A0(n402), .A1(gray_addr[4]), .B0(N111), .B1(n401), .Y(n600)
         );
  AOI22X1 U726 ( .A0(N36), .A1(n405), .B0(gray_addr[4]), .B1(n404), .Y(n599)
         );
  AOI22X1 U727 ( .A0(gray_addr[4]), .A1(n408), .B0(N186), .B1(n407), .Y(n598)
         );
  NAND4X1 U728 ( .A(n602), .B(n603), .C(n604), .D(n605), .Y(N199) );
  AOI22X1 U729 ( .A0(N80), .A1(n400), .B0(N50), .B1(n403), .Y(n605) );
  AOI22X1 U730 ( .A0(n402), .A1(gray_addr[3]), .B0(N110), .B1(n401), .Y(n604)
         );
  AOI22X1 U731 ( .A0(N35), .A1(n405), .B0(gray_addr[3]), .B1(n404), .Y(n603)
         );
  AOI22X1 U732 ( .A0(gray_addr[3]), .A1(n408), .B0(N185), .B1(n407), .Y(n602)
         );
  NAND4X1 U733 ( .A(n606), .B(n607), .C(n608), .D(n609), .Y(N198) );
  AOI22X1 U734 ( .A0(N79), .A1(n400), .B0(N49), .B1(n403), .Y(n609) );
  AOI22X1 U735 ( .A0(n402), .A1(gray_addr[2]), .B0(N109), .B1(n401), .Y(n608)
         );
  AOI22X1 U736 ( .A0(N34), .A1(n405), .B0(gray_addr[2]), .B1(n404), .Y(n607)
         );
  AOI22X1 U737 ( .A0(gray_addr[2]), .A1(n408), .B0(N184), .B1(n407), .Y(n606)
         );
  NAND4X1 U738 ( .A(n610), .B(n611), .C(n612), .D(n613), .Y(N197) );
  AOI22X1 U739 ( .A0(n299), .A1(n400), .B0(N48), .B1(n403), .Y(n613) );
  AOI22X1 U740 ( .A0(n402), .A1(gray_addr[1]), .B0(n299), .B1(n401), .Y(n612)
         );
  AOI22X1 U741 ( .A0(N33), .A1(n405), .B0(gray_addr[1]), .B1(n404), .Y(n611)
         );
  AOI22X1 U742 ( .A0(gray_addr[1]), .A1(n408), .B0(n299), .B1(n407), .Y(n610)
         );
  NAND4X1 U743 ( .A(n614), .B(n615), .C(n616), .D(n617), .Y(N196) );
  AOI221XL U744 ( .A0(N47), .A1(n403), .B0(gray_addr[0]), .B1(n400), .C0(n589), 
        .Y(n617) );
  NOR3BXL U745 ( .AN(n406), .B(n465), .C(n547), .Y(n589) );
  OAI21XL U746 ( .A0(n457), .A1(n448), .B0(n462), .Y(n618) );
  CLKINVX1 U747 ( .A(n619), .Y(n462) );
  AOI22X1 U748 ( .A0(n402), .A1(gray_addr[0]), .B0(gray_addr[0]), .B1(n401), 
        .Y(n616) );
  AOI221XL U749 ( .A0(n529), .A1(gray_ready), .B0(n619), .B1(gray_ready), .C0(
        n403), .Y(n621) );
  AND2X1 U750 ( .A(n634), .B(n623), .Y(n622) );
  OAI21XL U751 ( .A0(n635), .A1(n531), .B0(n448), .Y(n623) );
  CLKINVX1 U752 ( .A(n529), .Y(n448) );
  NOR2X1 U753 ( .A(n457), .B(n531), .Y(n464) );
  NAND2BX1 U754 ( .AN(n634), .B(n635), .Y(n457) );
  NOR2X1 U755 ( .A(n355), .B(n636), .Y(n529) );
  NOR2X1 U756 ( .A(n404), .B(n405), .Y(n620) );
  AOI22X1 U757 ( .A0(n319), .A1(n405), .B0(gray_addr[0]), .B1(n404), .Y(n615)
         );
  NOR3X1 U758 ( .A(n531), .B(n527), .C(n450), .Y(n456) );
  CLKINVX1 U759 ( .A(n514), .Y(n527) );
  NAND2X1 U760 ( .A(n624), .B(n625), .Y(n514) );
  NOR4X1 U761 ( .A(step_counter[7]), .B(step_counter[6]), .C(step_counter[5]), 
        .D(step_counter[4]), .Y(n625) );
  NOR4X1 U762 ( .A(step_counter[3]), .B(step_counter[2]), .C(step_counter[1]), 
        .D(step_counter[0]), .Y(n624) );
  CLKINVX1 U763 ( .A(n530), .Y(n531) );
  NAND3X1 U764 ( .A(n313), .B(n545), .C(n319), .Y(n465) );
  AND4X1 U765 ( .A(n626), .B(n627), .C(n628), .D(n629), .Y(n545) );
  NOR3X1 U766 ( .A(gray_addr[4]), .B(N98), .C(N97), .Y(n629) );
  NOR3X1 U767 ( .A(gray_addr[1]), .B(gray_addr[3]), .C(gray_addr[2]), .Y(n628)
         );
  NOR3X1 U768 ( .A(n641), .B(n643), .C(n642), .Y(n627) );
  NOR3X1 U769 ( .A(gray_addr[13]), .B(n640), .C(n639), .Y(n626) );
  NOR2X1 U770 ( .A(n636), .B(n633), .Y(n530) );
  AOI22X1 U771 ( .A0(gray_addr[0]), .A1(n408), .B0(gray_addr[0]), .B1(n407), 
        .Y(n614) );
  CLKINVX1 U772 ( .A(gray_ready), .Y(n547) );
  NOR2X1 U773 ( .A(n634), .B(n635), .Y(n528) );
  NAND2X1 U774 ( .A(n631), .B(n632), .Y(n630) );
  NOR4BBX1 U775 ( .AN(step_counter[0]), .BN(step_counter[2]), .C(
        step_counter[7]), .D(step_counter[1]), .Y(n632) );
  AND4X1 U776 ( .A(step_counter[3]), .B(step_counter[4]), .C(step_counter[5]), 
        .D(step_counter[6]), .Y(n631) );
endmodule

