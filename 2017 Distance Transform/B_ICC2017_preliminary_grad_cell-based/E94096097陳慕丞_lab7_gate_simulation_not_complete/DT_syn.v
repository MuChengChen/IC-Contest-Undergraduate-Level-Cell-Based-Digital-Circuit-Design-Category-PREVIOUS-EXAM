/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : P-2019.03
// Date      : Fri Nov 18 21:27:19 2022
/////////////////////////////////////////////////////////////


module DT_DW01_inc_0 ( A, SUM );
  input [9:0] A;
  output [9:0] SUM;

  wire   [9:2] carry;

  ADDHXL U1_1_8 ( .A(A[8]), .B(carry[8]), .CO(carry[9]), .S(SUM[8]) );
  ADDHXL U1_1_6 ( .A(A[6]), .B(carry[6]), .CO(carry[7]), .S(SUM[6]) );
  ADDHXL U1_1_5 ( .A(A[5]), .B(carry[5]), .CO(carry[6]), .S(SUM[5]) );
  ADDHXL U1_1_7 ( .A(A[7]), .B(carry[7]), .CO(carry[8]), .S(SUM[7]) );
  ADDHXL U1_1_4 ( .A(A[4]), .B(carry[4]), .CO(carry[5]), .S(SUM[4]) );
  ADDHXL U1_1_3 ( .A(A[3]), .B(carry[3]), .CO(carry[4]), .S(SUM[3]) );
  ADDHXL U1_1_2 ( .A(A[2]), .B(carry[2]), .CO(carry[3]), .S(SUM[2]) );
  ADDHXL U1_1_1 ( .A(A[1]), .B(A[0]), .CO(carry[2]), .S(SUM[1]) );
  CLKINVX1 U1 ( .A(A[0]), .Y(SUM[0]) );
  XOR2X1 U2 ( .A(carry[9]), .B(A[9]), .Y(SUM[9]) );
endmodule


module DT_DW01_inc_1 ( A, SUM );
  input [13:0] A;
  output [13:0] SUM;

  wire   [13:2] carry;

  ADDHXL U1_1_12 ( .A(A[12]), .B(carry[12]), .CO(carry[13]), .S(SUM[12]) );
  ADDHXL U1_1_2 ( .A(A[2]), .B(carry[2]), .CO(carry[3]), .S(SUM[2]) );
  ADDHXL U1_1_11 ( .A(A[11]), .B(carry[11]), .CO(carry[12]), .S(SUM[11]) );
  ADDHXL U1_1_10 ( .A(A[10]), .B(carry[10]), .CO(carry[11]), .S(SUM[10]) );
  ADDHXL U1_1_9 ( .A(A[9]), .B(carry[9]), .CO(carry[10]), .S(SUM[9]) );
  ADDHXL U1_1_8 ( .A(A[8]), .B(carry[8]), .CO(carry[9]), .S(SUM[8]) );
  ADDHXL U1_1_3 ( .A(A[3]), .B(carry[3]), .CO(carry[4]), .S(SUM[3]) );
  ADDHXL U1_1_4 ( .A(A[4]), .B(carry[4]), .CO(carry[5]), .S(SUM[4]) );
  ADDHXL U1_1_5 ( .A(A[5]), .B(carry[5]), .CO(carry[6]), .S(SUM[5]) );
  ADDHXL U1_1_6 ( .A(A[6]), .B(carry[6]), .CO(carry[7]), .S(SUM[6]) );
  ADDHXL U1_1_7 ( .A(A[7]), .B(carry[7]), .CO(carry[8]), .S(SUM[7]) );
  ADDHXL U1_1_1 ( .A(A[1]), .B(A[0]), .CO(carry[2]), .S(SUM[1]) );
  CLKINVX1 U1 ( .A(A[0]), .Y(SUM[0]) );
  XOR2X1 U2 ( .A(carry[13]), .B(A[13]), .Y(SUM[13]) );
endmodule


module DT_DW01_inc_2 ( A, SUM );
  input [7:0] A;
  output [7:0] SUM;
  wire   n1, n2;
  wire   [7:2] carry;

  ADDHX1 U1_1_5 ( .A(A[5]), .B(n1), .CO(carry[6]), .S(SUM[5]) );
  ADDHX1 U1_1_6 ( .A(A[6]), .B(carry[6]), .CO(carry[7]), .S(SUM[6]) );
  ADDHX1 U1_1_1 ( .A(A[1]), .B(A[0]), .CO(carry[2]), .S(SUM[1]) );
  ADDHX1 U1_1_2 ( .A(A[2]), .B(carry[2]), .CO(carry[3]), .S(SUM[2]) );
  XOR2X1 U1 ( .A(carry[7]), .B(A[7]), .Y(SUM[7]) );
  AND2X2 U2 ( .A(A[4]), .B(n2), .Y(n1) );
  AND2X2 U3 ( .A(A[3]), .B(carry[3]), .Y(n2) );
  XOR2XL U4 ( .A(A[3]), .B(carry[3]), .Y(SUM[3]) );
  XOR2XL U5 ( .A(A[4]), .B(n2), .Y(SUM[4]) );
  CLKINVX1 U6 ( .A(A[0]), .Y(SUM[0]) );
endmodule


module DT_DW01_dec_0 ( A, SUM );
  input [13:0] A;
  output [13:0] SUM;
  wire   n1, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16;

  CLKINVX1 U1 ( .A(n16), .Y(n1) );
  CLKINVX1 U2 ( .A(A[0]), .Y(SUM[0]) );
  CLKINVX1 U3 ( .A(A[11]), .Y(n3) );
  CLKINVX1 U4 ( .A(A[10]), .Y(n4) );
  AO21X1 U5 ( .A0(n5), .A1(A[9]), .B0(n6), .Y(SUM[9]) );
  OAI2BB1X1 U6 ( .A0N(n7), .A1N(A[8]), .B0(n5), .Y(SUM[8]) );
  OAI2BB1X1 U7 ( .A0N(n8), .A1N(A[7]), .B0(n7), .Y(SUM[7]) );
  OAI2BB1X1 U8 ( .A0N(n9), .A1N(A[6]), .B0(n8), .Y(SUM[6]) );
  OAI2BB1X1 U9 ( .A0N(n10), .A1N(A[5]), .B0(n9), .Y(SUM[5]) );
  OAI2BB1X1 U10 ( .A0N(n11), .A1N(A[4]), .B0(n10), .Y(SUM[4]) );
  OAI2BB1X1 U11 ( .A0N(n12), .A1N(A[3]), .B0(n11), .Y(SUM[3]) );
  OAI2BB1X1 U12 ( .A0N(n13), .A1N(A[2]), .B0(n12), .Y(SUM[2]) );
  OAI2BB1X1 U13 ( .A0N(A[0]), .A1N(A[1]), .B0(n13), .Y(SUM[1]) );
  XOR2X1 U14 ( .A(A[13]), .B(n14), .Y(SUM[13]) );
  NOR2X1 U15 ( .A(A[12]), .B(n15), .Y(n14) );
  XNOR2X1 U16 ( .A(A[12]), .B(n15), .Y(SUM[12]) );
  OAI21XL U17 ( .A0(n1), .A1(n3), .B0(n15), .Y(SUM[11]) );
  NAND2X1 U18 ( .A(n1), .B(n3), .Y(n15) );
  OAI21XL U19 ( .A0(n6), .A1(n4), .B0(n16), .Y(SUM[10]) );
  NAND2X1 U20 ( .A(n6), .B(n4), .Y(n16) );
  NOR2X1 U21 ( .A(n5), .B(A[9]), .Y(n6) );
  OR2X1 U22 ( .A(n7), .B(A[8]), .Y(n5) );
  OR2X1 U23 ( .A(n8), .B(A[7]), .Y(n7) );
  OR2X1 U24 ( .A(n9), .B(A[6]), .Y(n8) );
  OR2X1 U25 ( .A(n10), .B(A[5]), .Y(n9) );
  OR2X1 U26 ( .A(n11), .B(A[4]), .Y(n10) );
  OR2X1 U27 ( .A(n12), .B(A[3]), .Y(n11) );
  OR2X1 U28 ( .A(n13), .B(A[2]), .Y(n12) );
  NAND2BX1 U29 ( .AN(A[1]), .B(SUM[0]), .Y(n13) );
endmodule


module DT ( clk, reset, done, sti_rd, sti_addr, sti_di, res_wr, res_rd, 
        res_addr, res_do, res_di );
  output [9:0] sti_addr;
  input [15:0] sti_di;
  output [13:0] res_addr;
  output [7:0] res_do;
  input [7:0] res_di;
  input clk, reset;
  output done, sti_rd, res_wr, res_rd;
  wire   n331, n332, n333, n334, n335, n336, n337, sti_a, switch_sti_addr, N19,
         N20, N21, N35, N36, N37, N62, N63, N64, N65, N66, N67, N68, N69, N70,
         N71, N76, N109, N110, N111, N112, N113, N114, N115, N116, N117, N118,
         N119, N120, N121, N123, N125, N126, N127, N128, N129, N130, N131,
         N132, N133, N134, N135, N136, N140, N141, N142, N143, N144, N145,
         N146, N147, N148, N149, N150, N151, N153, N154, N155, N156, N157,
         N158, N159, N160, N161, N162, N163, N164, N165, N166, N199, N200,
         N201, N202, N203, N204, N205, N206, N207, N208, N209, N210, N211,
         N214, N215, N216, N217, N218, N219, N221, N222, N223, N224, N225,
         N226, N285, N300, N301, N302, N303, N304, N305, N306, N307, n28, n29,
         n30, n31, n32, n33, n34, n35, n36, n37, n38, n39, n41, n42, n43, n44,
         n45, n46, n47, n48, n49, n50, n51, n52, n53, n54, n55, n56, n57, n58,
         n59, n60, n61, n62, n63, n64, n65, n66, n67, n68, n69, n70, n71, n72,
         n73, n74, n75, n76, n77, n78, n79, n80, n81, n82, n83, n84, n85, n86,
         n87, n88, n89, n90, n91, n92, n93, n94, n95, n96, n97, n98, n99, n100,
         n101, n102, n103, n104, n105, n107, n108, n109, n110, n111, n113,
         n114, n115, n117, n118, n119, n120, n121, n124, n125, n126, n127,
         n128, n129, n130, n132, n133, n134, n135, n136, n137, n139, n140,
         n142, n148, n149, n151, n152, n153, n154, n155, n157, n158, n160,
         n162, n163, n164, n166, n168, n170, n171, n172, n173, n174, n175,
         n176, n177, n178, n179, n180, n181, n182, n183, n184, n185, n186,
         n187, n188, n189, n190, n191, n192, n193, n194, n195, n196, n197,
         n198, n199, n200, n210, n211, n212, n213, n214, n215, n216, n217,
         n218, n219, n220, n222, n223, n224, n225, \add_126/carry[2] ,
         \add_126/carry[3] , \add_126/carry[4] , \add_126/carry[5] ,
         \add_126/carry[6] , \add_126/carry[7] , \add_126/carry[8] ,
         \add_126/carry[9] , \add_126/carry[10] , \add_126/carry[11] ,
         \add_126/carry[12] , \add_126/carry[13] , \sub_106/carry[2] ,
         \sub_106/carry[3] , \sub_106/carry[4] , \sub_106/carry[5] ,
         \sub_106/carry[6] , \sub_106/carry[7] , \sub_106/carry[8] ,
         \sub_106/carry[9] , \sub_106/carry[10] , \sub_106/carry[11] ,
         \sub_106/carry[12] , \sub_106/carry[13] , n226, n227, n228, n229,
         n230, n231, n232, n233, n234, n235, n236, n237, n238, n239, n240,
         n241, n242, n243, n244, n245, n246, n247, n248, n249, n250, n251,
         n252, n253, n254, n255, n256, n257, n258, n259, n260, n261, n262,
         n263, n264, n265, n266, n267, n268, n282, n283, n284, n285, n286,
         n287, n288, n289, n290, n291, n292, n293, n294, n295, n297, n298,
         n299, n300, n301, n302, n303, n304, n305, n306, n307, n308, n309,
         n310, n311, n312, n313, n314, n315, n316, n317, n318, n319, n320,
         n321, n322, n323, n324, n325, n326, n327, n328, n329, n330;
  wire   [7:0] res_di_add;
  wire   [13:0] res_addr_add1;
  wire   [14:0] \sub_128/carry ;
  wire   [14:0] \sub_118/carry ;
  wire   [13:1] \add_112/carry ;

  OAI2BB1X4 U177 ( .A0N(n225), .A1N(n110), .B0(n171), .Y(n158) );
  DT_DW01_inc_0 add_72 ( .A(sti_addr), .SUM({N71, N70, N69, N68, N67, N66, N65, 
        N64, N63, N62}) );
  DT_DW01_inc_1 add_22 ( .A(res_addr), .SUM(res_addr_add1) );
  DT_DW01_inc_2 add_20 ( .A(res_di), .SUM(res_di_add) );
  DT_DW01_dec_0 r407 ( .A({res_addr[13:3], N215, res_addr[1:0]}), .SUM({N166, 
        N165, N164, N163, N162, N161, N160, N159, N158, N157, N156, N155, N154, 
        N153}) );
  DFFRX2 done_reg ( .D(n186), .CK(clk), .RN(n282), .Q(done), .QN(n182) );
  DFFRX2 \sti_addr_reg[9]  ( .D(n210), .CK(clk), .RN(n282), .Q(sti_addr[9]) );
  DFFRX1 \res_addr_reg[13]  ( .D(n197), .CK(clk), .RN(reset), .Q(n331) );
  DFFRX1 \res_addr_reg[12]  ( .D(n196), .CK(clk), .RN(reset), .Q(n332) );
  DFFRX1 \res_addr_reg[11]  ( .D(n195), .CK(clk), .RN(reset), .Q(n333) );
  DFFRX1 \res_addr_reg[10]  ( .D(n194), .CK(clk), .RN(reset), .Q(n334) );
  DFFRX1 \res_addr_reg[9]  ( .D(n193), .CK(clk), .RN(reset), .Q(n335) );
  DFFRX1 \res_addr_reg[8]  ( .D(n192), .CK(clk), .RN(reset), .Q(n336) );
  DFFRX1 \res_addr_reg[6]  ( .D(n188), .CK(clk), .RN(reset), .Q(N219) );
  DFFRX1 \res_addr_reg[7]  ( .D(n187), .CK(clk), .RN(reset), .Q(n337), .QN(
        n231) );
  DFFRX1 \res_addr_reg[4]  ( .D(n190), .CK(clk), .RN(reset), .Q(N217) );
  DFFRX1 \res_addr_reg[5]  ( .D(n189), .CK(clk), .RN(reset), .Q(N218) );
  DFFNSRX2 \res_do_reg[0]  ( .D(N300), .CKN(clk), .SN(1'b1), .RN(reset), .Q(
        res_do[0]), .QN(n174) );
  DFFNSRX2 \res_do_reg[5]  ( .D(N305), .CKN(clk), .SN(1'b1), .RN(reset), .Q(
        res_do[5]), .QN(n179) );
  DFFNSRX2 \res_do_reg[3]  ( .D(N303), .CKN(clk), .SN(1'b1), .RN(n283), .Q(
        res_do[3]), .QN(n177) );
  DFFNSRX2 \res_do_reg[1]  ( .D(N301), .CKN(clk), .SN(1'b1), .RN(reset), .Q(
        res_do[1]), .QN(n175) );
  DFFNSRX2 \res_do_reg[4]  ( .D(N304), .CKN(clk), .SN(1'b1), .RN(n283), .Q(
        res_do[4]), .QN(n178) );
  DFFNSRX2 \res_do_reg[2]  ( .D(N302), .CKN(clk), .SN(1'b1), .RN(n283), .Q(
        res_do[2]), .QN(n176) );
  DFFRX1 \res_addr_reg[3]  ( .D(n191), .CK(clk), .RN(reset), .Q(N216) );
  DFFRX1 \res_addr_reg[2]  ( .D(n198), .CK(clk), .RN(n282), .Q(N215), .QN(n222) );
  DFFRX1 \block_counter_reg[2]  ( .D(N37), .CK(clk), .RN(n282), .Q(n228), .QN(
        n184) );
  DFFRX2 forward_0_backward_1_reg ( .D(n220), .CK(clk), .RN(n282), .Q(n229), 
        .QN(n225) );
  DFFRX1 \res_addr_reg[1]  ( .D(n199), .CK(clk), .RN(n282), .Q(N214), .QN(n223) );
  DFFNSRX2 res_wr_reg ( .D(N76), .CKN(clk), .SN(1'b1), .RN(n283), .Q(res_wr), 
        .QN(n226) );
  DFFRX1 \res_addr_reg[0]  ( .D(n200), .CK(clk), .RN(n282), .Q(N123), .QN(n224) );
  DFFRX2 res_rd_reg ( .D(1'b1), .CK(clk), .RN(n282), .Q(res_rd) );
  DFFRX2 sti_rd_reg ( .D(n225), .CK(clk), .RN(n283), .Q(sti_rd) );
  DFFRX1 switch_sti_addr_reg ( .D(N21), .CK(clk), .RN(n282), .Q(
        switch_sti_addr), .QN(n230) );
  DFFRX1 \block_counter_reg[1]  ( .D(N36), .CK(clk), .RN(n282), .Q(n227), .QN(
        n185) );
  DFFNSRX2 \res_do_reg[7]  ( .D(N307), .CKN(clk), .SN(1'b1), .RN(n283), .Q(
        res_do[7]), .QN(n181) );
  DFFNSRX2 \res_do_reg[6]  ( .D(N306), .CKN(clk), .SN(1'b1), .RN(n283), .Q(
        res_do[6]), .QN(n180) );
  DFFRX2 \sti_addr_reg[8]  ( .D(n219), .CK(clk), .RN(n283), .Q(sti_addr[8]) );
  DFFRX2 \sti_addr_reg[0]  ( .D(n218), .CK(clk), .RN(n283), .Q(sti_addr[0]) );
  DFFRX2 \sti_addr_reg[1]  ( .D(n217), .CK(clk), .RN(n283), .Q(sti_addr[1]) );
  DFFRX2 \sti_addr_reg[2]  ( .D(n216), .CK(clk), .RN(n283), .Q(sti_addr[2]) );
  DFFRX2 \sti_addr_reg[3]  ( .D(n215), .CK(clk), .RN(n283), .Q(sti_addr[3]) );
  DFFRX2 \sti_addr_reg[4]  ( .D(n214), .CK(clk), .RN(n283), .Q(sti_addr[4]) );
  DFFRX2 \sti_addr_reg[5]  ( .D(n213), .CK(clk), .RN(n282), .Q(sti_addr[5]) );
  DFFRX2 \sti_addr_reg[6]  ( .D(n212), .CK(clk), .RN(n283), .Q(sti_addr[6]) );
  DFFRX2 \sti_addr_reg[7]  ( .D(n211), .CK(clk), .RN(n282), .Q(sti_addr[7]) );
  DFFRX2 \block_counter_reg[0]  ( .D(N35), .CK(clk), .RN(n282), .QN(n183) );
  NAND2X2 U206 ( .A(res_di_add[7]), .B(n259), .Y(n157) );
  NOR4BXL U207 ( .AN(N20), .B(n258), .C(n121), .D(sti_a), .Y(N21) );
  NOR2XL U208 ( .A(n229), .B(sti_a), .Y(n151) );
  NAND3XL U209 ( .A(n129), .B(n225), .C(sti_a), .Y(n120) );
  NAND2BX4 U210 ( .AN(res_di[4]), .B(res_do[4]), .Y(n300) );
  OAI222X1 U211 ( .A0(res_di[5]), .A1(n314), .B0(res_di[5]), .B1(n300), .C0(
        n314), .C1(n300), .Y(n257) );
  OAI222X1 U212 ( .A0(res_di[5]), .A1(n314), .B0(res_di[5]), .B1(n300), .C0(
        n314), .C1(n300), .Y(n301) );
  NAND3X4 U213 ( .A(n242), .B(n243), .C(n308), .Y(n311) );
  OR2X4 U214 ( .A(n310), .B(n309), .Y(n243) );
  NOR2BX1 U215 ( .AN(res_di[4]), .B(res_do[4]), .Y(n307) );
  AND2X2 U216 ( .A(n244), .B(n245), .Y(n303) );
  OR2X1 U217 ( .A(res_di[5]), .B(n307), .Y(n237) );
  OR2X1 U218 ( .A(n307), .B(n314), .Y(n236) );
  AOI211X1 U219 ( .A0(n127), .A1(n225), .B0(n111), .C0(n128), .Y(n103) );
  NAND2X2 U220 ( .A(n234), .B(n313), .Y(N285) );
  OR2X1 U221 ( .A(res_di[7]), .B(n181), .Y(n234) );
  AO22X1 U222 ( .A0(sti_di[13]), .A1(n290), .B0(sti_di[12]), .B1(n289), .Y(
        n288) );
  CLKBUFX3 U223 ( .A(n124), .Y(n260) );
  NAND3X1 U224 ( .A(n249), .B(n250), .C(n157), .Y(N307) );
  OAI221X1 U225 ( .A0(n155), .A1(n176), .B0(n260), .B1(n323), .C0(n166), .Y(
        N302) );
  OAI221X1 U226 ( .A0(n155), .A1(n178), .B0(n260), .B1(n321), .C0(n163), .Y(
        N304) );
  OAI221X1 U227 ( .A0(n155), .A1(n175), .B0(n260), .B1(n324), .C0(n168), .Y(
        N301) );
  OAI221X1 U228 ( .A0(n155), .A1(n177), .B0(n260), .B1(n322), .C0(n164), .Y(
        N303) );
  OAI221X1 U229 ( .A0(n155), .A1(n179), .B0(n260), .B1(n320), .C0(n162), .Y(
        N305) );
  OAI221X1 U230 ( .A0(n155), .A1(n174), .B0(n260), .B1(n245), .C0(n170), .Y(
        N300) );
  AOI2BB2X1 U231 ( .B0(n303), .B1(res_do[0]), .A0N(res_di[1]), .A1N(n175), .Y(
        n305) );
  INVX3 U232 ( .A(res_di[0]), .Y(n245) );
  OAI2BB2X2 U233 ( .B0(N216), .B1(n255), .A0N(n256), .A1N(N216), .Y(sti_a) );
  INVX3 U234 ( .A(n222), .Y(res_addr[2]) );
  NAND2X4 U235 ( .A(res_di[1]), .B(n175), .Y(n244) );
  OR2X4 U236 ( .A(n155), .B(n181), .Y(n249) );
  OR2X2 U237 ( .A(n155), .B(n180), .Y(n246) );
  INVX20 U238 ( .A(n232), .Y(n155) );
  NAND2X1 U239 ( .A(res_di_add[6]), .B(n259), .Y(n160) );
  NOR2X8 U240 ( .A(n235), .B(n259), .Y(n232) );
  NAND2X1 U241 ( .A(res_di_add[0]), .B(n259), .Y(n170) );
  NAND2X1 U242 ( .A(res_di_add[1]), .B(n259), .Y(n168) );
  NAND2X1 U243 ( .A(res_di_add[2]), .B(n259), .Y(n166) );
  NAND2X1 U244 ( .A(res_di_add[5]), .B(n259), .Y(n162) );
  NAND2X1 U245 ( .A(res_di_add[3]), .B(n259), .Y(n164) );
  NAND2X1 U246 ( .A(res_di_add[4]), .B(n259), .Y(n163) );
  OAI22X1 U247 ( .A0(n306), .A1(n305), .B0(n304), .B1(n177), .Y(n309) );
  NAND2X6 U248 ( .A(n260), .B(n114), .Y(n235) );
  OR2X2 U249 ( .A(n111), .B(n127), .Y(n233) );
  NAND2X6 U250 ( .A(n233), .B(N285), .Y(n171) );
  OR2X2 U251 ( .A(sti_a), .B(n248), .Y(n114) );
  NAND2X1 U252 ( .A(n236), .B(n237), .Y(n308) );
  OR2X1 U253 ( .A(res_do[6]), .B(n315), .Y(n242) );
  AO22X1 U254 ( .A0(sti_di[9]), .A1(n290), .B0(sti_di[8]), .B1(n289), .Y(n291)
         );
  NOR3X1 U255 ( .A(n238), .B(n239), .C(n291), .Y(n294) );
  AND2X2 U256 ( .A(sti_di[10]), .B(n293), .Y(n238) );
  AND2X2 U257 ( .A(sti_di[11]), .B(n292), .Y(n239) );
  OA22X2 U258 ( .A0(n295), .A1(res_addr[2]), .B0(n294), .B1(n222), .Y(n255) );
  OR2XL U259 ( .A(res_di[3]), .B(n177), .Y(n240) );
  OR2X4 U260 ( .A(res_di[3]), .B(n304), .Y(n241) );
  NAND2X2 U261 ( .A(n240), .B(n241), .Y(n310) );
  OAI22X2 U262 ( .A0(res_addr[2]), .A1(n287), .B0(n222), .B1(n286), .Y(n256)
         );
  NOR3X1 U263 ( .A(n251), .B(n252), .C(n288), .Y(n295) );
  AND2X2 U264 ( .A(sti_di[14]), .B(n293), .Y(n251) );
  AND2X2 U265 ( .A(sti_di[15]), .B(n292), .Y(n252) );
  OR2X1 U266 ( .A(n260), .B(n315), .Y(n247) );
  NAND3X2 U267 ( .A(n246), .B(n247), .C(n160), .Y(N306) );
  OR2XL U268 ( .A(n260), .B(n319), .Y(n250) );
  NAND2X1 U269 ( .A(n225), .B(n129), .Y(n248) );
  NOR2X1 U270 ( .A(N214), .B(n224), .Y(n293) );
  AND2X2 U271 ( .A(sti_di[6]), .B(n293), .Y(n253) );
  AND2X2 U272 ( .A(sti_di[7]), .B(n292), .Y(n254) );
  NAND2BX1 U273 ( .AN(res_di[2]), .B(res_do[2]), .Y(n304) );
  NOR2X1 U274 ( .A(N214), .B(N123), .Y(n292) );
  OA22X4 U275 ( .A0(n302), .A1(res_di[3]), .B0(n302), .B1(n177), .Y(n306) );
  AOI221X2 U276 ( .A0(sti_di[2]), .A1(n293), .B0(sti_di[3]), .B1(n292), .C0(
        n285), .Y(n286) );
  NOR2X4 U277 ( .A(n323), .B(res_do[2]), .Y(n302) );
  NOR3X4 U278 ( .A(n253), .B(n254), .C(n284), .Y(n287) );
  CLKBUFX3 U279 ( .A(n318), .Y(n268) );
  CLKBUFX3 U280 ( .A(n45), .Y(n262) );
  CLKBUFX3 U281 ( .A(n38), .Y(n266) );
  INVXL U282 ( .A(res_di[5]), .Y(n320) );
  INVX4 U283 ( .A(res_di[2]), .Y(n323) );
  INVXL U284 ( .A(res_di[3]), .Y(n322) );
  INVXL U285 ( .A(res_di[4]), .Y(n321) );
  NOR3BXL U286 ( .AN(n32), .B(n225), .C(n226), .Y(n125) );
  CLKBUFX3 U287 ( .A(n44), .Y(n261) );
  CLKBUFX3 U288 ( .A(n43), .Y(n264) );
  CLKBUFX3 U289 ( .A(n39), .Y(n267) );
  NOR3X1 U290 ( .A(n184), .B(n183), .C(n227), .Y(n130) );
  CLKBUFX3 U291 ( .A(n42), .Y(n263) );
  NOR4XL U292 ( .A(res_di[2]), .B(res_di[1]), .C(res_di[0]), .D(n260), .Y(n149) );
  NOR3XL U293 ( .A(res_di[5]), .B(res_di[7]), .C(res_di[6]), .Y(n148) );
  BUFX4 U294 ( .A(N123), .Y(res_addr[0]) );
  BUFX4 U295 ( .A(N214), .Y(res_addr[1]) );
  BUFX4 U296 ( .A(N216), .Y(res_addr[3]) );
  BUFX4 U297 ( .A(N217), .Y(res_addr[4]) );
  CLKBUFX3 U298 ( .A(n331), .Y(res_addr[13]) );
  BUFX4 U299 ( .A(n332), .Y(res_addr[12]) );
  BUFX4 U300 ( .A(n335), .Y(res_addr[9]) );
  BUFX4 U301 ( .A(n336), .Y(res_addr[8]) );
  BUFX4 U302 ( .A(n333), .Y(res_addr[11]) );
  BUFX4 U303 ( .A(n334), .Y(res_addr[10]) );
  BUFX4 U304 ( .A(N219), .Y(res_addr[6]) );
  BUFX4 U305 ( .A(N218), .Y(res_addr[5]) );
  NAND2X1 U306 ( .A(n99), .B(n114), .Y(N76) );
  NAND4X1 U307 ( .A(n102), .B(n103), .C(n104), .D(n29), .Y(n100) );
  NAND4X1 U308 ( .A(res_addr[7]), .B(res_addr[0]), .C(n33), .D(n125), .Y(n29)
         );
  NAND2X1 U309 ( .A(n125), .B(n330), .Y(n104) );
  NOR2BX1 U310 ( .AN(n99), .B(n130), .Y(n115) );
  AOI22X1 U311 ( .A0(N145), .A1(n263), .B0(res_addr[7]), .B1(n264), .Y(n35) );
  AOI22X1 U312 ( .A0(N144), .A1(n263), .B0(res_addr[6]), .B1(n264), .Y(n47) );
  AOI22X1 U313 ( .A0(N143), .A1(n263), .B0(res_addr[5]), .B1(n264), .Y(n51) );
  AOI22X1 U314 ( .A0(N142), .A1(n263), .B0(res_addr[4]), .B1(n264), .Y(n55) );
  AOI22X1 U315 ( .A0(N141), .A1(n263), .B0(res_addr[3]), .B1(n264), .Y(n59) );
  AOI22X1 U316 ( .A0(N146), .A1(n263), .B0(res_addr[8]), .B1(n264), .Y(n63) );
  AOI22X1 U317 ( .A0(N147), .A1(n263), .B0(res_addr[9]), .B1(n264), .Y(n67) );
  AOI22X1 U318 ( .A0(N148), .A1(n263), .B0(res_addr[10]), .B1(n264), .Y(n71)
         );
  AOI22X1 U319 ( .A0(N149), .A1(n263), .B0(res_addr[11]), .B1(n264), .Y(n75)
         );
  AOI22X1 U320 ( .A0(N150), .A1(n263), .B0(res_addr[12]), .B1(n264), .Y(n79)
         );
  AOI22X1 U321 ( .A0(N151), .A1(n263), .B0(res_addr[13]), .B1(n264), .Y(n83)
         );
  AOI22X1 U322 ( .A0(N140), .A1(n263), .B0(res_addr[2]), .B1(n264), .Y(n87) );
  AOI22X1 U323 ( .A0(n223), .A1(n263), .B0(res_addr[1]), .B1(n264), .Y(n91) );
  AOI22X1 U324 ( .A0(res_addr[0]), .A1(n263), .B0(res_addr[0]), .B1(n264), .Y(
        n95) );
  NAND2X1 U325 ( .A(n115), .B(n107), .Y(n127) );
  NAND4X1 U326 ( .A(n70), .B(n71), .C(n72), .D(n73), .Y(n194) );
  AOI22X1 U327 ( .A0(N208), .A1(n261), .B0(N118), .B1(n262), .Y(n70) );
  AOI22X1 U328 ( .A0(res_addr_add1[10]), .A1(n268), .B0(N223), .B1(n265), .Y(
        n72) );
  AOI22X1 U329 ( .A0(N133), .A1(n266), .B0(N163), .B1(n267), .Y(n73) );
  NAND4X1 U330 ( .A(n74), .B(n75), .C(n76), .D(n77), .Y(n195) );
  AOI22X1 U331 ( .A0(N209), .A1(n261), .B0(N119), .B1(n262), .Y(n74) );
  AOI22X1 U332 ( .A0(res_addr_add1[11]), .A1(n268), .B0(N224), .B1(n265), .Y(
        n76) );
  AOI22X1 U333 ( .A0(N134), .A1(n266), .B0(N164), .B1(n267), .Y(n77) );
  CLKBUFX3 U334 ( .A(n41), .Y(n265) );
  NOR2BX1 U335 ( .AN(n105), .B(n100), .Y(n41) );
  NAND4X1 U336 ( .A(n78), .B(n79), .C(n80), .D(n81), .Y(n196) );
  AOI22X1 U337 ( .A0(N210), .A1(n261), .B0(N120), .B1(n262), .Y(n78) );
  AOI22X1 U338 ( .A0(res_addr_add1[12]), .A1(n268), .B0(N225), .B1(n265), .Y(
        n80) );
  AOI22X1 U339 ( .A0(N135), .A1(n266), .B0(N165), .B1(n267), .Y(n81) );
  NAND4X1 U340 ( .A(n82), .B(n83), .C(n84), .D(n85), .Y(n197) );
  AOI22X1 U341 ( .A0(N211), .A1(n261), .B0(N121), .B1(n262), .Y(n82) );
  AOI22X1 U342 ( .A0(res_addr_add1[13]), .A1(n268), .B0(N226), .B1(n265), .Y(
        n84) );
  AOI22X1 U343 ( .A0(N136), .A1(n266), .B0(N166), .B1(n267), .Y(n85) );
  NAND4X1 U344 ( .A(n94), .B(n95), .C(n96), .D(n97), .Y(n200) );
  AOI22X1 U345 ( .A0(n330), .A1(n261), .B0(n330), .B1(n262), .Y(n94) );
  AOI22X1 U346 ( .A0(res_addr_add1[0]), .A1(n268), .B0(res_addr[0]), .B1(n265), 
        .Y(n96) );
  AOI22X1 U347 ( .A0(res_addr[0]), .A1(n266), .B0(N153), .B1(n267), .Y(n97) );
  NAND4X1 U348 ( .A(n90), .B(n91), .C(n92), .D(n93), .Y(n199) );
  AOI22X1 U349 ( .A0(N199), .A1(n261), .B0(N109), .B1(n262), .Y(n90) );
  AOI22X1 U350 ( .A0(res_addr_add1[1]), .A1(n268), .B0(res_addr[1]), .B1(n265), 
        .Y(n92) );
  AOI22X1 U351 ( .A0(n223), .A1(n266), .B0(N154), .B1(n267), .Y(n93) );
  NAND4X1 U352 ( .A(n46), .B(n47), .C(n48), .D(n49), .Y(n188) );
  AOI22X1 U353 ( .A0(N204), .A1(n261), .B0(N114), .B1(n262), .Y(n46) );
  AOI22X1 U354 ( .A0(res_addr_add1[6]), .A1(n268), .B0(res_addr[6]), .B1(n265), 
        .Y(n48) );
  AOI22X1 U355 ( .A0(N129), .A1(n266), .B0(N159), .B1(n267), .Y(n49) );
  NAND4X1 U356 ( .A(n50), .B(n51), .C(n52), .D(n53), .Y(n189) );
  AOI22X1 U357 ( .A0(N203), .A1(n261), .B0(N113), .B1(n262), .Y(n50) );
  AOI22X1 U358 ( .A0(res_addr_add1[5]), .A1(n268), .B0(res_addr[5]), .B1(n265), 
        .Y(n52) );
  AOI22X1 U359 ( .A0(N128), .A1(n266), .B0(N158), .B1(n267), .Y(n53) );
  NAND4X1 U360 ( .A(n54), .B(n55), .C(n56), .D(n57), .Y(n190) );
  AOI22X1 U361 ( .A0(N202), .A1(n261), .B0(N112), .B1(n262), .Y(n54) );
  AOI22X1 U362 ( .A0(res_addr_add1[4]), .A1(n268), .B0(res_addr[4]), .B1(n265), 
        .Y(n56) );
  AOI22X1 U363 ( .A0(N127), .A1(n266), .B0(N157), .B1(n267), .Y(n57) );
  NAND4X1 U364 ( .A(n58), .B(n59), .C(n60), .D(n61), .Y(n191) );
  AOI22X1 U365 ( .A0(N201), .A1(n261), .B0(N111), .B1(n262), .Y(n58) );
  AOI22X1 U366 ( .A0(res_addr_add1[3]), .A1(n268), .B0(res_addr[3]), .B1(n265), 
        .Y(n60) );
  AOI22X1 U367 ( .A0(N126), .A1(n266), .B0(N156), .B1(n267), .Y(n61) );
  NAND4X1 U368 ( .A(n86), .B(n87), .C(n88), .D(n89), .Y(n198) );
  AOI22X1 U369 ( .A0(N200), .A1(n261), .B0(N110), .B1(n262), .Y(n86) );
  AOI22X1 U370 ( .A0(res_addr_add1[2]), .A1(n268), .B0(res_addr[2]), .B1(n265), 
        .Y(n88) );
  AOI22X1 U371 ( .A0(N125), .A1(n266), .B0(N155), .B1(n267), .Y(n89) );
  NAND4X1 U372 ( .A(n34), .B(n35), .C(n36), .D(n37), .Y(n187) );
  AOI22X1 U373 ( .A0(N205), .A1(n261), .B0(N115), .B1(n262), .Y(n34) );
  AOI22X1 U374 ( .A0(res_addr_add1[7]), .A1(n268), .B0(n231), .B1(n265), .Y(
        n36) );
  AOI22X1 U375 ( .A0(N130), .A1(n266), .B0(N160), .B1(n267), .Y(n37) );
  NAND4X1 U376 ( .A(n62), .B(n63), .C(n64), .D(n65), .Y(n192) );
  AOI22X1 U377 ( .A0(N206), .A1(n261), .B0(N116), .B1(n262), .Y(n62) );
  AOI22X1 U378 ( .A0(res_addr_add1[8]), .A1(n268), .B0(N221), .B1(n265), .Y(
        n64) );
  AOI22X1 U379 ( .A0(N131), .A1(n266), .B0(N161), .B1(n267), .Y(n65) );
  NAND4X1 U380 ( .A(n66), .B(n67), .C(n68), .D(n69), .Y(n193) );
  AOI22X1 U381 ( .A0(N207), .A1(n261), .B0(N117), .B1(n262), .Y(n66) );
  AOI22X1 U382 ( .A0(res_addr_add1[9]), .A1(n268), .B0(N222), .B1(n265), .Y(
        n68) );
  AOI22X1 U383 ( .A0(N132), .A1(n266), .B0(N162), .B1(n267), .Y(n69) );
  OAI31XL U384 ( .A0(n140), .A1(n30), .A2(n328), .B0(n142), .Y(N36) );
  NAND2X1 U385 ( .A(n226), .B(n230), .Y(n140) );
  OAI211X1 U386 ( .A0(n130), .A1(n227), .B0(n329), .C0(n326), .Y(n142) );
  CLKINVX1 U387 ( .A(n139), .Y(n326) );
  AND4X1 U388 ( .A(n121), .B(n32), .C(n330), .D(n226), .Y(n113) );
  NAND3X1 U389 ( .A(n226), .B(n230), .C(n328), .Y(n139) );
  CLKINVX1 U390 ( .A(n108), .Y(n318) );
  OAI31XL U391 ( .A0(n109), .A1(n110), .A2(n111), .B0(n230), .Y(n108) );
  OAI22XL U392 ( .A0(n113), .A1(n114), .B0(n115), .B1(n229), .Y(n109) );
  NOR2X1 U393 ( .A(n120), .B(n113), .Y(n45) );
  NAND2X1 U394 ( .A(n153), .B(n229), .Y(n124) );
  CLKINVX1 U395 ( .A(n103), .Y(n317) );
  AOI2BB1X1 U396 ( .A0N(n228), .A1N(n111), .B0(n139), .Y(N37) );
  NOR2X1 U397 ( .A(n130), .B(n30), .Y(n102) );
  NOR4X1 U398 ( .A(res_addr[11]), .B(res_addr[12]), .C(res_addr[10]), .D(n172), 
        .Y(n33) );
  OR3X2 U399 ( .A(res_addr[13]), .B(res_addr[9]), .C(res_addr[8]), .Y(n172) );
  NOR4X1 U400 ( .A(N215), .B(res_addr[3]), .C(res_addr[1]), .D(n126), .Y(n32)
         );
  OR3X2 U401 ( .A(res_addr[4]), .B(res_addr[6]), .C(res_addr[5]), .Y(n126) );
  NOR2BX1 U402 ( .AN(n33), .B(res_addr[7]), .Y(n121) );
  INVX3 U403 ( .A(n258), .Y(n325) );
  CLKINVX1 U404 ( .A(res_addr[0]), .Y(n330) );
  NAND4X1 U405 ( .A(res_addr[1]), .B(res_addr[2]), .C(res_addr[3]), .D(
        res_addr[0]), .Y(n136) );
  CLKINVX1 U406 ( .A(n111), .Y(n329) );
  NOR2BX1 U407 ( .AN(n105), .B(n229), .Y(n38) );
  CLKINVX1 U408 ( .A(n153), .Y(n328) );
  AND3X2 U409 ( .A(res_addr[8]), .B(res_addr[5]), .C(res_addr[4]), .Y(n137) );
  CLKINVX1 U410 ( .A(res_di[1]), .Y(n324) );
  CLKINVX1 U411 ( .A(res_di[7]), .Y(n319) );
  OAI222X1 U412 ( .A0(res_do[6]), .A1(n301), .B0(n315), .B1(n257), .C0(
        res_do[6]), .C1(n315), .Y(n312) );
  CLKINVX1 U413 ( .A(res_di[6]), .Y(n315) );
  NAND3X1 U414 ( .A(n227), .B(n228), .C(n183), .Y(n99) );
  NOR3X1 U415 ( .A(n260), .B(switch_sti_addr), .C(n100), .Y(n44) );
  OAI211X1 U416 ( .A0(n317), .A1(n29), .B0(n117), .C0(n230), .Y(n43) );
  AO21X1 U417 ( .A0(n118), .A1(n119), .B0(n100), .Y(n117) );
  AO21X1 U418 ( .A0(n229), .A1(n184), .B0(n183), .Y(n118) );
  NOR2BX1 U419 ( .AN(n98), .B(switch_sti_addr), .Y(n39) );
  OAI21XL U420 ( .A0(n99), .A1(n100), .B0(n101), .Y(n98) );
  NAND4BX1 U421 ( .AN(n102), .B(n103), .C(n104), .D(n29), .Y(n101) );
  NOR3X2 U422 ( .A(n185), .B(n183), .C(n228), .Y(n111) );
  NAND2X1 U423 ( .A(n183), .B(n184), .Y(n119) );
  NOR3X1 U424 ( .A(n227), .B(switch_sti_addr), .C(n119), .Y(n129) );
  NOR2X1 U425 ( .A(n119), .B(n185), .Y(n110) );
  NOR3X1 U426 ( .A(n227), .B(n183), .C(n228), .Y(n153) );
  NAND3X1 U427 ( .A(n185), .B(n228), .C(n183), .Y(n107) );
  NOR3X1 U428 ( .A(n317), .B(switch_sti_addr), .C(n104), .Y(n42) );
  NAND3BX1 U429 ( .AN(n110), .B(n114), .C(n120), .Y(n128) );
  NAND3X1 U430 ( .A(n28), .B(n29), .C(n182), .Y(n186) );
  NAND3X1 U431 ( .A(n30), .B(res_addr[7]), .C(n31), .Y(n28) );
  AND3X2 U432 ( .A(res_addr[0]), .B(n32), .C(n33), .Y(n31) );
  OAI32X1 U433 ( .A0(n327), .A1(res_wr), .A2(n151), .B0(n152), .B1(n139), .Y(
        N35) );
  AOI21X1 U434 ( .A0(n154), .A1(n329), .B0(n110), .Y(n152) );
  CLKINVX1 U435 ( .A(n129), .Y(n327) );
  OAI21XL U436 ( .A0(n183), .A1(n130), .B0(n107), .Y(n154) );
  OAI21XL U437 ( .A0(n133), .A1(n134), .B0(n225), .Y(n220) );
  NAND4BX1 U438 ( .AN(n135), .B(res_addr[10]), .C(res_addr[9]), .D(
        res_addr[11]), .Y(n134) );
  NAND4X1 U439 ( .A(res_addr[7]), .B(res_wr), .C(res_addr[6]), .D(n137), .Y(
        n133) );
  NAND3BX1 U440 ( .AN(n136), .B(res_addr[12]), .C(res_addr[13]), .Y(n135) );
  AND4X1 U441 ( .A(n322), .B(n321), .C(n148), .D(n149), .Y(n30) );
  CLKBUFX6 U442 ( .A(n337), .Y(res_addr[7]) );
  CLKINVX1 U443 ( .A(res_do[5]), .Y(n314) );
  CLKBUFX3 U444 ( .A(n132), .Y(n258) );
  NAND3BX1 U445 ( .AN(n136), .B(N19), .C(n173), .Y(n132) );
  NOR3X1 U446 ( .A(n119), .B(n227), .C(n229), .Y(n173) );
  AO22X1 U447 ( .A0(N62), .A1(n325), .B0(sti_addr[0]), .B1(n258), .Y(n218) );
  AO22X1 U448 ( .A0(N64), .A1(n325), .B0(sti_addr[2]), .B1(n258), .Y(n216) );
  AO22X1 U449 ( .A0(N70), .A1(n325), .B0(sti_addr[8]), .B1(n258), .Y(n219) );
  AO22X1 U450 ( .A0(N65), .A1(n325), .B0(sti_addr[3]), .B1(n258), .Y(n215) );
  AO22X1 U451 ( .A0(N66), .A1(n325), .B0(sti_addr[4]), .B1(n258), .Y(n214) );
  AO22X1 U452 ( .A0(N63), .A1(n325), .B0(sti_addr[1]), .B1(n258), .Y(n217) );
  AO22X1 U453 ( .A0(N69), .A1(n325), .B0(sti_addr[7]), .B1(n258), .Y(n211) );
  AO22X1 U454 ( .A0(N67), .A1(n325), .B0(sti_addr[5]), .B1(n258), .Y(n213) );
  AO22X1 U455 ( .A0(N68), .A1(n325), .B0(sti_addr[6]), .B1(n258), .Y(n212) );
  AO22X1 U456 ( .A0(N71), .A1(n325), .B0(sti_addr[9]), .B1(n258), .Y(n210) );
  NOR2X1 U457 ( .A(n107), .B(switch_sti_addr), .Y(n105) );
  CLKBUFX3 U458 ( .A(reset), .Y(n283) );
  CLKBUFX3 U459 ( .A(reset), .Y(n282) );
  AO22X4 U460 ( .A0(n181), .A1(res_di[7]), .B0(n312), .B1(n311), .Y(n313) );
  BUFX20 U461 ( .A(n158), .Y(n259) );
  XOR2X1 U462 ( .A(res_addr[13]), .B(\add_112/carry [13]), .Y(N136) );
  AND2X1 U463 ( .A(\add_112/carry [12]), .B(res_addr[12]), .Y(
        \add_112/carry [13]) );
  XOR2X1 U464 ( .A(res_addr[12]), .B(\add_112/carry [12]), .Y(N135) );
  AND2X1 U465 ( .A(\add_112/carry [11]), .B(res_addr[11]), .Y(
        \add_112/carry [12]) );
  XOR2X1 U466 ( .A(res_addr[11]), .B(\add_112/carry [11]), .Y(N134) );
  AND2X1 U467 ( .A(\add_112/carry [10]), .B(res_addr[10]), .Y(
        \add_112/carry [11]) );
  XOR2X1 U468 ( .A(res_addr[10]), .B(\add_112/carry [10]), .Y(N133) );
  AND2X1 U469 ( .A(\add_112/carry [9]), .B(res_addr[9]), .Y(
        \add_112/carry [10]) );
  XOR2X1 U470 ( .A(res_addr[9]), .B(\add_112/carry [9]), .Y(N132) );
  AND2X1 U471 ( .A(\add_112/carry [8]), .B(res_addr[8]), .Y(\add_112/carry [9]) );
  XOR2X1 U472 ( .A(res_addr[8]), .B(\add_112/carry [8]), .Y(N131) );
  AND2X1 U473 ( .A(\add_112/carry [7]), .B(res_addr[7]), .Y(\add_112/carry [8]) );
  XOR2X1 U474 ( .A(res_addr[7]), .B(\add_112/carry [7]), .Y(N130) );
  OR2X1 U475 ( .A(res_addr[6]), .B(\add_112/carry [6]), .Y(\add_112/carry [7])
         );
  XNOR2X1 U476 ( .A(\add_112/carry [6]), .B(res_addr[6]), .Y(N129) );
  OR2X1 U477 ( .A(res_addr[5]), .B(\add_112/carry [5]), .Y(\add_112/carry [6])
         );
  XNOR2X1 U478 ( .A(\add_112/carry [5]), .B(res_addr[5]), .Y(N128) );
  OR2X1 U479 ( .A(res_addr[4]), .B(\add_112/carry [4]), .Y(\add_112/carry [5])
         );
  XNOR2X1 U480 ( .A(\add_112/carry [4]), .B(res_addr[4]), .Y(N127) );
  OR2X1 U481 ( .A(res_addr[3]), .B(\add_112/carry [3]), .Y(\add_112/carry [4])
         );
  XNOR2X1 U482 ( .A(\add_112/carry [3]), .B(res_addr[3]), .Y(N126) );
  XNOR2X1 U483 ( .A(res_addr[13]), .B(\sub_128/carry [13]), .Y(N226) );
  OR2X1 U484 ( .A(res_addr[12]), .B(\sub_128/carry [12]), .Y(
        \sub_128/carry [13]) );
  XNOR2X1 U485 ( .A(\sub_128/carry [12]), .B(res_addr[12]), .Y(N225) );
  OR2X1 U486 ( .A(res_addr[11]), .B(\sub_128/carry [11]), .Y(
        \sub_128/carry [12]) );
  XNOR2X1 U487 ( .A(\sub_128/carry [11]), .B(res_addr[11]), .Y(N224) );
  OR2X1 U488 ( .A(res_addr[10]), .B(\sub_128/carry [10]), .Y(
        \sub_128/carry [11]) );
  XNOR2X1 U489 ( .A(\sub_128/carry [10]), .B(res_addr[10]), .Y(N223) );
  OR2X1 U490 ( .A(res_addr[9]), .B(\sub_128/carry [9]), .Y(\sub_128/carry [10]) );
  XNOR2X1 U491 ( .A(\sub_128/carry [9]), .B(res_addr[9]), .Y(N222) );
  OR2X1 U492 ( .A(res_addr[8]), .B(res_addr[7]), .Y(\sub_128/carry [9]) );
  XNOR2X1 U493 ( .A(res_addr[7]), .B(res_addr[8]), .Y(N221) );
  XNOR2X1 U494 ( .A(res_addr[13]), .B(\sub_118/carry [13]), .Y(N151) );
  OR2X1 U495 ( .A(res_addr[12]), .B(\sub_118/carry [12]), .Y(
        \sub_118/carry [13]) );
  XNOR2X1 U496 ( .A(\sub_118/carry [12]), .B(res_addr[12]), .Y(N150) );
  OR2X1 U497 ( .A(res_addr[11]), .B(\sub_118/carry [11]), .Y(
        \sub_118/carry [12]) );
  XNOR2X1 U498 ( .A(\sub_118/carry [11]), .B(res_addr[11]), .Y(N149) );
  OR2X1 U499 ( .A(res_addr[10]), .B(\sub_118/carry [10]), .Y(
        \sub_118/carry [11]) );
  XNOR2X1 U500 ( .A(\sub_118/carry [10]), .B(res_addr[10]), .Y(N148) );
  OR2X1 U501 ( .A(res_addr[9]), .B(\sub_118/carry [9]), .Y(\sub_118/carry [10]) );
  XNOR2X1 U502 ( .A(\sub_118/carry [9]), .B(res_addr[9]), .Y(N147) );
  OR2X1 U503 ( .A(res_addr[8]), .B(\sub_118/carry [8]), .Y(\sub_118/carry [9])
         );
  XNOR2X1 U504 ( .A(\sub_118/carry [8]), .B(res_addr[8]), .Y(N146) );
  OR2X1 U505 ( .A(res_addr[7]), .B(\sub_118/carry [7]), .Y(\sub_118/carry [8])
         );
  XNOR2X1 U506 ( .A(\sub_118/carry [7]), .B(res_addr[7]), .Y(N145) );
  OR2X1 U507 ( .A(res_addr[6]), .B(\sub_118/carry [6]), .Y(\sub_118/carry [7])
         );
  XNOR2X1 U508 ( .A(\sub_118/carry [6]), .B(res_addr[6]), .Y(N144) );
  OR2X1 U509 ( .A(res_addr[5]), .B(\sub_118/carry [5]), .Y(\sub_118/carry [6])
         );
  XNOR2X1 U510 ( .A(\sub_118/carry [5]), .B(res_addr[5]), .Y(N143) );
  OR2X1 U511 ( .A(res_addr[4]), .B(\sub_118/carry [4]), .Y(\sub_118/carry [5])
         );
  XNOR2X1 U512 ( .A(\sub_118/carry [4]), .B(res_addr[4]), .Y(N142) );
  OR2X1 U513 ( .A(res_addr[3]), .B(\sub_118/carry [3]), .Y(\sub_118/carry [4])
         );
  XNOR2X1 U514 ( .A(\sub_118/carry [3]), .B(res_addr[3]), .Y(N141) );
  XNOR2X1 U515 ( .A(res_addr[13]), .B(\sub_106/carry[13] ), .Y(N121) );
  OR2X1 U516 ( .A(res_addr[12]), .B(\sub_106/carry[12] ), .Y(
        \sub_106/carry[13] ) );
  XNOR2X1 U517 ( .A(\sub_106/carry[12] ), .B(res_addr[12]), .Y(N120) );
  OR2X1 U518 ( .A(res_addr[11]), .B(\sub_106/carry[11] ), .Y(
        \sub_106/carry[12] ) );
  XNOR2X1 U519 ( .A(\sub_106/carry[11] ), .B(res_addr[11]), .Y(N119) );
  OR2X1 U520 ( .A(res_addr[10]), .B(\sub_106/carry[10] ), .Y(
        \sub_106/carry[11] ) );
  XNOR2X1 U521 ( .A(\sub_106/carry[10] ), .B(res_addr[10]), .Y(N118) );
  OR2X1 U522 ( .A(res_addr[9]), .B(\sub_106/carry[9] ), .Y(\sub_106/carry[10] ) );
  XNOR2X1 U523 ( .A(\sub_106/carry[9] ), .B(res_addr[9]), .Y(N117) );
  OR2X1 U524 ( .A(res_addr[8]), .B(\sub_106/carry[8] ), .Y(\sub_106/carry[9] )
         );
  XNOR2X1 U525 ( .A(\sub_106/carry[8] ), .B(res_addr[8]), .Y(N116) );
  AND2X1 U526 ( .A(\sub_106/carry[7] ), .B(res_addr[7]), .Y(\sub_106/carry[8] ) );
  XOR2X1 U527 ( .A(res_addr[7]), .B(\sub_106/carry[7] ), .Y(N115) );
  OR2X1 U528 ( .A(res_addr[6]), .B(\sub_106/carry[6] ), .Y(\sub_106/carry[7] )
         );
  XNOR2X1 U529 ( .A(\sub_106/carry[6] ), .B(res_addr[6]), .Y(N114) );
  OR2X1 U530 ( .A(res_addr[5]), .B(\sub_106/carry[5] ), .Y(\sub_106/carry[6] )
         );
  XNOR2X1 U531 ( .A(\sub_106/carry[5] ), .B(res_addr[5]), .Y(N113) );
  OR2X1 U532 ( .A(res_addr[4]), .B(\sub_106/carry[4] ), .Y(\sub_106/carry[5] )
         );
  XNOR2X1 U533 ( .A(\sub_106/carry[4] ), .B(res_addr[4]), .Y(N112) );
  OR2X1 U534 ( .A(res_addr[3]), .B(\sub_106/carry[3] ), .Y(\sub_106/carry[4] )
         );
  XNOR2X1 U535 ( .A(\sub_106/carry[3] ), .B(res_addr[3]), .Y(N111) );
  XOR2X1 U536 ( .A(res_addr[13]), .B(\add_126/carry[13] ), .Y(N211) );
  AND2X1 U537 ( .A(\add_126/carry[12] ), .B(res_addr[12]), .Y(
        \add_126/carry[13] ) );
  XOR2X1 U538 ( .A(res_addr[12]), .B(\add_126/carry[12] ), .Y(N210) );
  AND2X1 U539 ( .A(\add_126/carry[11] ), .B(res_addr[11]), .Y(
        \add_126/carry[12] ) );
  XOR2X1 U540 ( .A(res_addr[11]), .B(\add_126/carry[11] ), .Y(N209) );
  AND2X1 U541 ( .A(\add_126/carry[10] ), .B(res_addr[10]), .Y(
        \add_126/carry[11] ) );
  XOR2X1 U542 ( .A(res_addr[10]), .B(\add_126/carry[10] ), .Y(N208) );
  AND2X1 U543 ( .A(\add_126/carry[9] ), .B(res_addr[9]), .Y(
        \add_126/carry[10] ) );
  XOR2X1 U544 ( .A(res_addr[9]), .B(\add_126/carry[9] ), .Y(N207) );
  AND2X1 U545 ( .A(\add_126/carry[8] ), .B(res_addr[8]), .Y(\add_126/carry[9] ) );
  XOR2X1 U546 ( .A(res_addr[8]), .B(\add_126/carry[8] ), .Y(N206) );
  AND2X1 U547 ( .A(\add_126/carry[7] ), .B(res_addr[7]), .Y(\add_126/carry[8] ) );
  XOR2X1 U548 ( .A(res_addr[7]), .B(\add_126/carry[7] ), .Y(N205) );
  OR2X1 U549 ( .A(res_addr[6]), .B(\add_126/carry[6] ), .Y(\add_126/carry[7] )
         );
  XNOR2X1 U550 ( .A(\add_126/carry[6] ), .B(res_addr[6]), .Y(N204) );
  OR2X1 U551 ( .A(res_addr[5]), .B(\add_126/carry[5] ), .Y(\add_126/carry[6] )
         );
  XNOR2X1 U552 ( .A(\add_126/carry[5] ), .B(res_addr[5]), .Y(N203) );
  OR2X1 U553 ( .A(res_addr[4]), .B(\add_126/carry[4] ), .Y(\add_126/carry[5] )
         );
  XNOR2X1 U554 ( .A(\add_126/carry[4] ), .B(res_addr[4]), .Y(N202) );
  OR2X1 U555 ( .A(res_addr[3]), .B(\add_126/carry[3] ), .Y(\add_126/carry[4] )
         );
  XNOR2X1 U556 ( .A(\add_126/carry[3] ), .B(res_addr[3]), .Y(N201) );
  OR2X1 U557 ( .A(N215), .B(res_addr[1]), .Y(\add_112/carry [3]) );
  XNOR2X1 U558 ( .A(res_addr[1]), .B(res_addr[2]), .Y(N125) );
  OR2X1 U559 ( .A(N215), .B(res_addr[1]), .Y(\sub_118/carry [3]) );
  XNOR2X1 U560 ( .A(res_addr[1]), .B(res_addr[2]), .Y(N140) );
  OR2X1 U561 ( .A(N215), .B(\sub_106/carry[2] ), .Y(\sub_106/carry[3] ) );
  XNOR2X1 U562 ( .A(\sub_106/carry[2] ), .B(res_addr[2]), .Y(N110) );
  OR2X1 U563 ( .A(N215), .B(\add_126/carry[2] ), .Y(\add_126/carry[3] ) );
  XNOR2X1 U564 ( .A(\add_126/carry[2] ), .B(res_addr[2]), .Y(N200) );
  OR2X1 U565 ( .A(res_addr[1]), .B(res_addr[0]), .Y(\sub_106/carry[2] ) );
  XNOR2X1 U566 ( .A(res_addr[0]), .B(res_addr[1]), .Y(N109) );
  OR2X1 U567 ( .A(res_addr[1]), .B(res_addr[0]), .Y(\add_126/carry[2] ) );
  XNOR2X1 U568 ( .A(res_addr[0]), .B(res_addr[1]), .Y(N199) );
  NOR2X1 U569 ( .A(N123), .B(n223), .Y(n290) );
  NOR2X1 U570 ( .A(n224), .B(n223), .Y(n289) );
  AO22X1 U571 ( .A0(sti_di[5]), .A1(n290), .B0(sti_di[4]), .B1(n289), .Y(n284)
         );
  AO22X1 U572 ( .A0(sti_di[1]), .A1(n290), .B0(sti_di[0]), .B1(n289), .Y(n285)
         );
  NAND2X1 U573 ( .A(sti_addr[1]), .B(sti_addr[0]), .Y(n297) );
  NAND4BX1 U574 ( .AN(n297), .B(sti_addr[2]), .C(sti_addr[4]), .D(sti_addr[3]), 
        .Y(n299) );
  AND3X1 U575 ( .A(sti_addr[6]), .B(sti_addr[5]), .C(sti_addr[7]), .Y(n298) );
  NAND4BX1 U576 ( .AN(n299), .B(sti_addr[8]), .C(n298), .D(sti_addr[9]), .Y(
        N19) );
  NAND4X1 U577 ( .A(res_addr[13]), .B(res_addr[12]), .C(res_addr[11]), .D(
        res_addr[10]), .Y(n316) );
  NAND4BX1 U578 ( .AN(n316), .B(res_addr[7]), .C(res_addr[9]), .D(res_addr[8]), 
        .Y(N20) );
endmodule

