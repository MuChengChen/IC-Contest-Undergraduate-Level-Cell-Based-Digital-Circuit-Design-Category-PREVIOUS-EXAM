/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : P-2019.03
// Date      : Sun Dec  4 16:14:20 2022
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
  ADDHXL U1_1_3 ( .A(A[3]), .B(carry[3]), .CO(carry[4]), .S(SUM[3]) );
  ADDHXL U1_1_11 ( .A(A[11]), .B(carry[11]), .CO(carry[12]), .S(SUM[11]) );
  ADDHXL U1_1_10 ( .A(A[10]), .B(carry[10]), .CO(carry[11]), .S(SUM[10]) );
  ADDHXL U1_1_9 ( .A(A[9]), .B(carry[9]), .CO(carry[10]), .S(SUM[9]) );
  ADDHXL U1_1_8 ( .A(A[8]), .B(carry[8]), .CO(carry[9]), .S(SUM[8]) );
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

  ADDHX1 U1_1_4 ( .A(A[4]), .B(n1), .CO(carry[5]), .S(SUM[4]) );
  ADDHXL U1_1_5 ( .A(A[5]), .B(carry[5]), .CO(carry[6]), .S(SUM[5]) );
  ADDHXL U1_1_6 ( .A(A[6]), .B(carry[6]), .CO(carry[7]), .S(SUM[6]) );
  ADDHX4 U1_1_2 ( .A(A[2]), .B(n2), .CO(carry[3]), .S(SUM[2]) );
  AND2X4 U1 ( .A(A[3]), .B(carry[3]), .Y(n1) );
  XOR2X1 U2 ( .A(carry[7]), .B(A[7]), .Y(SUM[7]) );
  AND2X2 U3 ( .A(A[1]), .B(A[0]), .Y(n2) );
  XOR2XL U4 ( .A(A[1]), .B(A[0]), .Y(SUM[1]) );
  XOR2XL U5 ( .A(A[3]), .B(carry[3]), .Y(SUM[3]) );
  INVXL U6 ( .A(A[0]), .Y(SUM[0]) );
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
  wire   n335, n336, n337, n338, n339, n340, n341, sti_a, switch_sti_addr, N20,
         N21, N25, N40, N41, N42, N69, N70, N71, N72, N73, N74, N75, N76, N77,
         N78, N84, N121, N122, N123, N124, N125, N126, N127, N128, N129, N130,
         N131, N132, N133, N135, N137, N138, N139, N140, N141, N142, N143,
         N144, N145, N146, N147, N148, N152, N153, N154, N155, N156, N157,
         N158, N159, N160, N161, N162, N163, N165, N166, N167, N168, N169,
         N170, N171, N172, N173, N174, N175, N176, N177, N178, N211, N212,
         N213, N214, N215, N216, N217, N218, N219, N220, N221, N222, N223,
         N226, N227, N228, N229, N230, N231, N233, N234, N235, N236, N237,
         N238, N297, N312, N313, N314, N315, N316, N317, N318, N319, n28, n29,
         n30, n31, n32, n34, n35, n36, n37, n38, n39, n40, n41, n42, n43, n44,
         n45, n46, n47, n48, n49, n50, n51, n52, n53, n54, n55, n56, n57, n58,
         n59, n60, n61, n62, n63, n64, n65, n66, n67, n68, n69, n70, n71, n72,
         n73, n74, n75, n76, n77, n78, n79, n80, n81, n82, n83, n84, n85, n86,
         n87, n89, n90, n91, n92, n93, n94, n95, n96, n97, n98, n99, n100,
         n101, n102, n103, n104, n107, n108, n110, n112, n113, n114, n115,
         n116, n117, n118, n119, n121, n122, n124, n125, n126, n128, n129,
         n130, n132, n133, n134, n135, n136, n137, n138, n139, n140, n142,
         n143, n145, n146, n148, n151, n152, n153, n154, n155, n156, n157,
         n158, n160, n163, n165, n166, n167, n169, n171, n173, n175, n177,
         n178, n179, n180, n181, n182, n183, n184, n185, n186, n187, n188,
         n189, n190, n191, n192, n193, n194, n195, n196, n197, n198, n199,
         n200, n201, n202, n203, n204, n205, n206, n207, n208, n209, n210,
         n211, n221, n222, n223, n224, n225, n226, n227, n228, n229, n230,
         n231, n232, n233, n234, n235, n236, n237, n238, n239,
         \add_133/carry[2] , \add_133/carry[3] , \add_133/carry[4] ,
         \add_133/carry[5] , \add_133/carry[6] , \add_133/carry[7] ,
         \add_133/carry[8] , \add_133/carry[9] , \add_133/carry[10] ,
         \add_133/carry[11] , \add_133/carry[12] , \add_133/carry[13] ,
         \sub_113/carry[2] , \sub_113/carry[3] , \sub_113/carry[4] ,
         \sub_113/carry[5] , \sub_113/carry[6] , \sub_113/carry[7] ,
         \sub_113/carry[8] , \sub_113/carry[9] , \sub_113/carry[10] ,
         \sub_113/carry[11] , \sub_113/carry[12] , \sub_113/carry[13] , n240,
         n241, n242, n243, n244, n245, n246, n247, n248, n249, n250, n251,
         n252, n253, n254, n255, n256, n257, n258, n259, n260, n261, n262,
         n263, n264, n265, n266, n267, n268, n269, n284, n285, n286, n287,
         n288, n289, n290, n291, n292, n293, n294, n295, n296, n297, n298,
         n299, n300, n301, n302, n303, n304, n305, n306, n307, n308, n309,
         n310, n311, n312, n313, n314, n315, n316, n317, n318, n319, n320,
         n321, n322, n323, n324, n325, n326, n327, n328, n329, n330, n331,
         n332, n333, n334;
  wire   [7:0] res_di_add;
  wire   [13:0] res_addr_add1;
  wire   [14:0] \sub_135/carry ;
  wire   [14:0] \sub_125/carry ;
  wire   [13:1] \add_119/carry ;

  DT_DW01_inc_0 add_77 ( .A(sti_addr), .SUM({N78, N77, N76, N75, N74, N73, N72, 
        N71, N70, N69}) );
  DT_DW01_inc_1 add_23 ( .A(res_addr), .SUM(res_addr_add1) );
  DT_DW01_inc_2 add_21 ( .A(res_di), .SUM(res_di_add) );
  DT_DW01_dec_0 r408 ( .A(res_addr), .SUM({N178, N177, N176, N175, N174, N173, 
        N172, N171, N170, N169, N168, N167, N166, N165}) );
  DFFRX2 done_reg ( .D(n200), .CK(clk), .RN(n284), .Q(done), .QN(n186) );
  DFFRX2 \sti_addr_reg[9]  ( .D(n221), .CK(clk), .RN(n284), .Q(sti_addr[9]), 
        .QN(n199) );
  DFFRX2 \sti_addr_reg[8]  ( .D(n230), .CK(clk), .RN(n285), .Q(sti_addr[8]), 
        .QN(n190) );
  DFFRX2 \sti_addr_reg[6]  ( .D(n223), .CK(clk), .RN(n284), .Q(sti_addr[6]), 
        .QN(n197) );
  DFFRX2 \sti_addr_reg[5]  ( .D(n224), .CK(clk), .RN(n284), .Q(sti_addr[5]), 
        .QN(n196) );
  DFFRX2 \sti_addr_reg[7]  ( .D(n222), .CK(clk), .RN(n284), .Q(sti_addr[7]), 
        .QN(n198) );
  DFFRX2 \sti_addr_reg[1]  ( .D(n228), .CK(clk), .RN(n285), .Q(sti_addr[1]), 
        .QN(n192) );
  DFFRX2 \sti_addr_reg[4]  ( .D(n225), .CK(clk), .RN(n284), .Q(sti_addr[4]), 
        .QN(n195) );
  DFFRX2 \sti_addr_reg[3]  ( .D(n226), .CK(clk), .RN(n285), .Q(sti_addr[3]), 
        .QN(n194) );
  DFFRX2 \sti_addr_reg[2]  ( .D(n227), .CK(clk), .RN(n284), .Q(sti_addr[2]), 
        .QN(n193) );
  DFFRX2 \sti_addr_reg[0]  ( .D(n229), .CK(clk), .RN(n285), .Q(sti_addr[0]), 
        .QN(n191) );
  DFFNSRX2 \res_do_reg[0]  ( .D(N312), .CKN(clk), .SN(1'b1), .RN(n285), .Q(
        res_do[0]), .QN(n178) );
  DFFNSRX2 \res_do_reg[5]  ( .D(N317), .CKN(clk), .SN(1'b1), .RN(reset), .Q(
        res_do[5]), .QN(n183) );
  DFFNSRX2 \res_do_reg[1]  ( .D(N313), .CKN(clk), .SN(1'b1), .RN(reset), .Q(
        res_do[1]), .QN(n179) );
  DFFNSRX2 \res_do_reg[3]  ( .D(N315), .CKN(clk), .SN(1'b1), .RN(n285), .Q(
        res_do[3]), .QN(n181) );
  DFFNSRX2 \res_do_reg[2]  ( .D(N314), .CKN(clk), .SN(1'b1), .RN(n285), .Q(
        res_do[2]), .QN(n180) );
  DFFRX1 \res_addr_reg[13]  ( .D(n210), .CK(clk), .RN(reset), .Q(n335) );
  DFFRX1 \res_addr_reg[12]  ( .D(n209), .CK(clk), .RN(reset), .Q(n336) );
  DFFRX1 \res_addr_reg[11]  ( .D(n208), .CK(clk), .RN(reset), .Q(n337) );
  DFFRX1 \res_addr_reg[10]  ( .D(n207), .CK(clk), .RN(reset), .Q(n338) );
  DFFRX1 \res_addr_reg[9]  ( .D(n206), .CK(clk), .RN(reset), .Q(n339) );
  DFFRX1 \res_addr_reg[8]  ( .D(n205), .CK(clk), .RN(reset), .Q(n340) );
  DFFRX1 \res_addr_reg[4]  ( .D(n204), .CK(clk), .RN(reset), .Q(N229) );
  DFFRX1 \res_addr_reg[5]  ( .D(n203), .CK(clk), .RN(reset), .Q(N230) );
  DFFRX1 \res_addr_reg[6]  ( .D(n202), .CK(clk), .RN(reset), .Q(N231) );
  DFFRX1 \res_addr_reg[7]  ( .D(n201), .CK(clk), .RN(reset), .Q(n341), .QN(
        n245) );
  DFFRX1 \res_addr_reg[3]  ( .D(n211), .CK(clk), .RN(reset), .Q(N228), .QN(
        n235) );
  DFFRX1 \res_addr_reg[2]  ( .D(n231), .CK(clk), .RN(n284), .Q(N227), .QN(n236) );
  DFFRX2 forward_0_backward_1_reg ( .D(n234), .CK(clk), .RN(n285), .Q(n244), 
        .QN(n239) );
  DFFRX1 \res_addr_reg[1]  ( .D(n232), .CK(clk), .RN(n285), .Q(N226), .QN(n237) );
  DFFRX1 \block_counter_reg[1]  ( .D(N41), .CK(clk), .RN(n284), .Q(n240), .QN(
        n188) );
  DFFRX1 \res_addr_reg[0]  ( .D(n233), .CK(clk), .RN(n285), .Q(N135), .QN(n238) );
  DFFNSRX2 res_wr_reg ( .D(N84), .CKN(clk), .SN(1'b1), .RN(reset), .Q(res_wr), 
        .QN(n241) );
  DFFRX2 res_rd_reg ( .D(1'b1), .CK(clk), .RN(n284), .Q(res_rd) );
  DFFRX2 sti_rd_reg ( .D(n239), .CK(clk), .RN(n285), .Q(sti_rd) );
  DFFRX1 switch_sti_addr_reg ( .D(N25), .CK(clk), .RN(n284), .Q(
        switch_sti_addr) );
  DFFRX1 \block_counter_reg[0]  ( .D(N40), .CK(clk), .RN(n284), .Q(n243), .QN(
        n189) );
  DFFRX1 \block_counter_reg[2]  ( .D(N42), .CK(clk), .RN(n284), .Q(n242), .QN(
        n187) );
  DFFNSRX2 \res_do_reg[7]  ( .D(N319), .CKN(clk), .SN(1'b1), .RN(n285), .Q(
        res_do[7]), .QN(n185) );
  DFFNSRX2 \res_do_reg[6]  ( .D(N318), .CKN(clk), .SN(1'b1), .RN(n285), .Q(
        res_do[6]), .QN(n184) );
  DFFNSRX2 \res_do_reg[4]  ( .D(N316), .CKN(clk), .SN(1'b1), .RN(n285), .Q(
        res_do[4]), .QN(n182) );
  OAI222X2 U210 ( .A0(res_di[5]), .A1(n183), .B0(res_di[5]), .B1(n303), .C0(
        n183), .C1(n303), .Y(n260) );
  AOI21X2 U211 ( .A0(res_di[1]), .A1(n179), .B0(res_di[0]), .Y(n305) );
  OAI221X1 U212 ( .A0(n251), .A1(n182), .B0(n261), .B1(n321), .C0(n166), .Y(
        N316) );
  NAND2BX4 U213 ( .AN(res_di[4]), .B(res_do[4]), .Y(n303) );
  AOI2BB2X1 U214 ( .B0(n305), .B1(res_do[0]), .A0N(res_di[1]), .A1N(n179), .Y(
        n307) );
  OAI22XL U215 ( .A0(n297), .A1(res_addr[2]), .B0(n296), .B1(n236), .Y(n298)
         );
  NAND3X1 U216 ( .A(n246), .B(n247), .C(n163), .Y(N318) );
  OR2X2 U217 ( .A(n251), .B(n184), .Y(n246) );
  NAND2X1 U218 ( .A(res_di_add[7]), .B(n257), .Y(n160) );
  OR2X2 U219 ( .A(n251), .B(n185), .Y(n255) );
  OAI221X1 U220 ( .A0(n251), .A1(n180), .B0(n261), .B1(n323), .C0(n169), .Y(
        N314) );
  BUFX4 U221 ( .A(n341), .Y(res_addr[7]) );
  OAI221X2 U222 ( .A0(n158), .A1(n178), .B0(n261), .B1(n325), .C0(n173), .Y(
        N312) );
  OAI221X2 U223 ( .A0(n158), .A1(n183), .B0(n261), .B1(n320), .C0(n165), .Y(
        N317) );
  OAI221X2 U224 ( .A0(n158), .A1(n181), .B0(n261), .B1(n322), .C0(n167), .Y(
        N315) );
  OAI221X2 U225 ( .A0(n158), .A1(n179), .B0(n261), .B1(n324), .C0(n171), .Y(
        N313) );
  AND2X2 U226 ( .A(res_di[4]), .B(n182), .Y(n309) );
  CLKBUFX3 U227 ( .A(n121), .Y(n261) );
  CLKINVX1 U228 ( .A(res_di[4]), .Y(n321) );
  OR2X1 U229 ( .A(n261), .B(n316), .Y(n247) );
  NAND3BX4 U230 ( .AN(n257), .B(n108), .C(n261), .Y(n251) );
  NAND3BX2 U231 ( .AN(n257), .B(n108), .C(n261), .Y(n158) );
  INVXL U232 ( .A(res_di[1]), .Y(n324) );
  NOR2BX4 U233 ( .AN(res_di[2]), .B(res_do[2]), .Y(n248) );
  OR3X2 U234 ( .A(n334), .B(n157), .C(n142), .Y(n249) );
  NAND2X6 U235 ( .A(n249), .B(N297), .Y(n175) );
  OR2X1 U236 ( .A(n244), .B(n104), .Y(n250) );
  NAND2X8 U237 ( .A(n250), .B(n175), .Y(n257) );
  AO22X1 U238 ( .A0(sti_di[13]), .A1(n292), .B0(sti_di[12]), .B1(n291), .Y(
        n290) );
  OAI2BB2X2 U239 ( .B0(n299), .B1(n235), .A0N(n235), .A1N(n298), .Y(sti_a) );
  OAI2BB2X2 U240 ( .B0(res_di[3]), .B1(n306), .A0N(n322), .A1N(res_do[3]), .Y(
        n312) );
  NAND3X1 U241 ( .A(n255), .B(n256), .C(n160), .Y(N319) );
  NOR2X1 U242 ( .A(N226), .B(N135), .Y(n294) );
  OR2X6 U243 ( .A(n254), .B(sti_a), .Y(n108) );
  NAND2X1 U244 ( .A(n239), .B(n134), .Y(n254) );
  AND2X2 U245 ( .A(sti_di[14]), .B(n295), .Y(n258) );
  AND2X2 U246 ( .A(sti_di[15]), .B(n294), .Y(n259) );
  NOR3X1 U247 ( .A(n258), .B(n259), .C(n290), .Y(n297) );
  NOR2X1 U248 ( .A(N226), .B(n238), .Y(n295) );
  OR2X1 U249 ( .A(res_do[6]), .B(n316), .Y(n252) );
  OR2X6 U250 ( .A(n312), .B(n311), .Y(n253) );
  NAND3X4 U251 ( .A(n252), .B(n253), .C(n310), .Y(n313) );
  OAI22X4 U252 ( .A0(n308), .A1(n307), .B0(n306), .B1(n181), .Y(n311) );
  INVXL U253 ( .A(res_di[2]), .Y(n323) );
  INVXL U254 ( .A(res_di[5]), .Y(n320) );
  CLKINVX1 U255 ( .A(res_di[3]), .Y(n322) );
  OR2X1 U256 ( .A(n261), .B(n318), .Y(n256) );
  NOR3BXL U257 ( .AN(n122), .B(n112), .C(n107), .Y(n110) );
  CLKBUFX3 U258 ( .A(n44), .Y(n265) );
  CLKBUFX3 U259 ( .A(n41), .Y(n266) );
  NOR3X1 U260 ( .A(n242), .B(n240), .C(n243), .Y(n126) );
  AND4X2 U261 ( .A(n326), .B(n110), .C(n98), .D(n331), .Y(n39) );
  CLKBUFX3 U262 ( .A(n43), .Y(n264) );
  OAI22X1 U263 ( .A0(n309), .A1(n183), .B0(res_di[5]), .B1(n309), .Y(n310) );
  INVXL U264 ( .A(res_di[0]), .Y(n325) );
  OA22X4 U265 ( .A0(n304), .A1(res_di[3]), .B0(n248), .B1(n181), .Y(n308) );
  NOR2BX4 U266 ( .AN(res_di[2]), .B(res_do[2]), .Y(n304) );
  CLKBUFX3 U267 ( .A(n45), .Y(n262) );
  CLKBUFX3 U268 ( .A(n46), .Y(n263) );
  BUFX4 U269 ( .A(n339), .Y(res_addr[9]) );
  BUFX4 U270 ( .A(n340), .Y(res_addr[8]) );
  NOR3X1 U271 ( .A(n189), .B(n187), .C(n240), .Y(n128) );
  NOR3X1 U272 ( .A(n189), .B(n188), .C(n242), .Y(n142) );
  BUFX4 U273 ( .A(n336), .Y(res_addr[12]) );
  BUFX4 U274 ( .A(N226), .Y(res_addr[1]) );
  BUFX4 U275 ( .A(N135), .Y(res_addr[0]) );
  BUFX4 U276 ( .A(n337), .Y(res_addr[11]) );
  BUFX4 U277 ( .A(n338), .Y(res_addr[10]) );
  BUFX4 U278 ( .A(N231), .Y(res_addr[6]) );
  BUFX4 U279 ( .A(N228), .Y(res_addr[3]) );
  BUFX4 U280 ( .A(N229), .Y(res_addr[4]) );
  BUFX4 U281 ( .A(N227), .Y(res_addr[2]) );
  BUFX4 U282 ( .A(N230), .Y(res_addr[5]) );
  NAND4XL U283 ( .A(n322), .B(n321), .C(n151), .D(n152), .Y(n129) );
  NOR4XL U284 ( .A(res_di[2]), .B(res_di[1]), .C(res_di[0]), .D(n261), .Y(n152) );
  NOR3XL U285 ( .A(res_di[5]), .B(res_di[7]), .C(res_di[6]), .Y(n151) );
  NAND4BX1 U286 ( .AN(n114), .B(n115), .C(n98), .D(n118), .Y(n116) );
  CLKINVX1 U287 ( .A(n130), .Y(n334) );
  CLKINVX1 U288 ( .A(n118), .Y(n326) );
  NAND4X1 U289 ( .A(n156), .B(n330), .C(n124), .D(n125), .Y(n132) );
  CLKINVX1 U290 ( .A(n148), .Y(n329) );
  CLKBUFX3 U291 ( .A(n42), .Y(n267) );
  NOR2X1 U292 ( .A(n244), .B(sti_a), .Y(n155) );
  NAND3X1 U293 ( .A(n117), .B(n108), .C(n132), .Y(N84) );
  OAI211X1 U294 ( .A0(n132), .A1(n133), .B0(n333), .C0(n104), .Y(n107) );
  NAND2X1 U295 ( .A(n126), .B(n241), .Y(n133) );
  OAI211X1 U296 ( .A0(n130), .A1(n244), .B0(n108), .C0(n110), .Y(n114) );
  AOI22X1 U297 ( .A0(N175), .A1(n266), .B0(N145), .B1(n267), .Y(n70) );
  AOI22X1 U298 ( .A0(N176), .A1(n266), .B0(N146), .B1(n267), .Y(n74) );
  AOI22X1 U299 ( .A0(N172), .A1(n266), .B0(N142), .B1(n267), .Y(n37) );
  AOI22X1 U300 ( .A0(N171), .A1(n266), .B0(N141), .B1(n267), .Y(n49) );
  AOI22X1 U301 ( .A0(N170), .A1(n266), .B0(N140), .B1(n267), .Y(n54) );
  AOI22X1 U302 ( .A0(N169), .A1(n266), .B0(N139), .B1(n267), .Y(n58) );
  AOI22X1 U303 ( .A0(N173), .A1(n266), .B0(N143), .B1(n267), .Y(n62) );
  AOI22X1 U304 ( .A0(N174), .A1(n266), .B0(N144), .B1(n267), .Y(n66) );
  AOI22X1 U305 ( .A0(N177), .A1(n266), .B0(N147), .B1(n42), .Y(n78) );
  AOI22X1 U306 ( .A0(N178), .A1(n266), .B0(N148), .B1(n42), .Y(n82) );
  AOI22X1 U307 ( .A0(N168), .A1(n266), .B0(N138), .B1(n42), .Y(n86) );
  AOI22X1 U308 ( .A0(N167), .A1(n266), .B0(N137), .B1(n42), .Y(n92) );
  AOI22X1 U309 ( .A0(N166), .A1(n266), .B0(n237), .B1(n42), .Y(n96) );
  NAND4X1 U310 ( .A(n80), .B(n81), .C(n82), .D(n83), .Y(n210) );
  AOI221XL U311 ( .A0(res_addr_add1[13]), .A1(n268), .B0(N163), .B1(n39), .C0(
        n269), .Y(n83) );
  AOI22X1 U312 ( .A0(N223), .A1(n262), .B0(N238), .B1(n263), .Y(n80) );
  AOI22X1 U313 ( .A0(N133), .A1(n264), .B0(res_addr[13]), .B1(n265), .Y(n81)
         );
  NAND4X1 U314 ( .A(n47), .B(n48), .C(n49), .D(n50), .Y(n202) );
  AOI221XL U315 ( .A0(res_addr_add1[6]), .A1(n268), .B0(N156), .B1(n39), .C0(
        n269), .Y(n50) );
  AOI22X1 U316 ( .A0(N216), .A1(n262), .B0(res_addr[6]), .B1(n263), .Y(n47) );
  AOI22X1 U317 ( .A0(N126), .A1(n264), .B0(res_addr[6]), .B1(n265), .Y(n48) );
  NAND4X1 U318 ( .A(n52), .B(n53), .C(n54), .D(n55), .Y(n203) );
  AOI221XL U319 ( .A0(res_addr_add1[5]), .A1(n268), .B0(N155), .B1(n39), .C0(
        n269), .Y(n55) );
  AOI22X1 U320 ( .A0(N215), .A1(n262), .B0(res_addr[5]), .B1(n263), .Y(n52) );
  AOI22X1 U321 ( .A0(N125), .A1(n264), .B0(res_addr[5]), .B1(n265), .Y(n53) );
  NAND4X1 U322 ( .A(n56), .B(n57), .C(n58), .D(n59), .Y(n204) );
  AOI221XL U323 ( .A0(res_addr_add1[4]), .A1(n268), .B0(N154), .B1(n39), .C0(
        n269), .Y(n59) );
  AOI22X1 U324 ( .A0(N214), .A1(n262), .B0(res_addr[4]), .B1(n263), .Y(n56) );
  AOI22X1 U325 ( .A0(N124), .A1(n264), .B0(res_addr[4]), .B1(n265), .Y(n57) );
  NAND4X1 U326 ( .A(n60), .B(n61), .C(n62), .D(n63), .Y(n205) );
  AOI221XL U327 ( .A0(res_addr_add1[8]), .A1(n268), .B0(N158), .B1(n39), .C0(
        n269), .Y(n63) );
  AOI22X1 U328 ( .A0(N218), .A1(n262), .B0(N233), .B1(n263), .Y(n60) );
  AOI22X1 U329 ( .A0(N128), .A1(n264), .B0(res_addr[8]), .B1(n265), .Y(n61) );
  NAND4X1 U330 ( .A(n64), .B(n65), .C(n66), .D(n67), .Y(n206) );
  AOI221XL U331 ( .A0(res_addr_add1[9]), .A1(n268), .B0(N159), .B1(n39), .C0(
        n269), .Y(n67) );
  AOI22X1 U332 ( .A0(N219), .A1(n262), .B0(N234), .B1(n263), .Y(n64) );
  AOI22X1 U333 ( .A0(N129), .A1(n264), .B0(res_addr[9]), .B1(n265), .Y(n65) );
  NAND4X1 U334 ( .A(n68), .B(n69), .C(n70), .D(n71), .Y(n207) );
  AOI221XL U335 ( .A0(res_addr_add1[10]), .A1(n268), .B0(N160), .B1(n39), .C0(
        n269), .Y(n71) );
  AOI22X1 U336 ( .A0(N220), .A1(n262), .B0(N235), .B1(n263), .Y(n68) );
  AOI22X1 U337 ( .A0(N130), .A1(n264), .B0(res_addr[10]), .B1(n265), .Y(n69)
         );
  NAND4X1 U338 ( .A(n72), .B(n73), .C(n74), .D(n75), .Y(n208) );
  AOI221XL U339 ( .A0(res_addr_add1[11]), .A1(n268), .B0(N161), .B1(n39), .C0(
        n269), .Y(n75) );
  AOI22X1 U340 ( .A0(N221), .A1(n262), .B0(N236), .B1(n263), .Y(n72) );
  AOI22X1 U341 ( .A0(N131), .A1(n264), .B0(res_addr[11]), .B1(n265), .Y(n73)
         );
  NAND4X1 U342 ( .A(n76), .B(n77), .C(n78), .D(n79), .Y(n209) );
  AOI221XL U343 ( .A0(res_addr_add1[12]), .A1(n268), .B0(N162), .B1(n39), .C0(
        n269), .Y(n79) );
  AOI22X1 U344 ( .A0(N222), .A1(n262), .B0(N237), .B1(n263), .Y(n76) );
  AOI22X1 U345 ( .A0(N132), .A1(n264), .B0(res_addr[12]), .B1(n265), .Y(n77)
         );
  NAND4X1 U346 ( .A(n84), .B(n85), .C(n86), .D(n87), .Y(n211) );
  AOI221XL U347 ( .A0(res_addr_add1[3]), .A1(n268), .B0(N153), .B1(n39), .C0(
        n269), .Y(n87) );
  AOI22X1 U348 ( .A0(N213), .A1(n262), .B0(res_addr[3]), .B1(n263), .Y(n84) );
  AOI22X1 U349 ( .A0(N123), .A1(n264), .B0(res_addr[3]), .B1(n265), .Y(n85) );
  NAND4X1 U350 ( .A(n90), .B(n91), .C(n92), .D(n93), .Y(n231) );
  AOI221XL U351 ( .A0(res_addr_add1[2]), .A1(n268), .B0(N152), .B1(n39), .C0(
        n269), .Y(n93) );
  AOI22X1 U352 ( .A0(N212), .A1(n262), .B0(res_addr[2]), .B1(n263), .Y(n90) );
  AOI22X1 U353 ( .A0(N122), .A1(n264), .B0(res_addr[2]), .B1(n265), .Y(n91) );
  NAND4X1 U354 ( .A(n94), .B(n95), .C(n96), .D(n97), .Y(n232) );
  AOI221XL U355 ( .A0(res_addr_add1[1]), .A1(n268), .B0(n237), .B1(n39), .C0(
        n269), .Y(n97) );
  AOI22X1 U356 ( .A0(N211), .A1(n262), .B0(res_addr[1]), .B1(n263), .Y(n94) );
  AOI22X1 U357 ( .A0(N121), .A1(n264), .B0(res_addr[1]), .B1(n265), .Y(n95) );
  AND2X2 U358 ( .A(n113), .B(n331), .Y(n41) );
  OAI32X1 U359 ( .A0(n114), .A1(n326), .A2(n115), .B0(n116), .B1(n117), .Y(
        n113) );
  NAND4X1 U360 ( .A(n35), .B(n36), .C(n37), .D(n38), .Y(n201) );
  AOI22X1 U361 ( .A0(N157), .A1(n39), .B0(res_addr_add1[7]), .B1(n268), .Y(n38) );
  AOI22X1 U362 ( .A0(N217), .A1(n262), .B0(n245), .B1(n263), .Y(n35) );
  AOI22X1 U363 ( .A0(N127), .A1(n264), .B0(res_addr[7]), .B1(n265), .Y(n36) );
  NAND2X1 U364 ( .A(n126), .B(n34), .Y(n98) );
  NAND4X1 U365 ( .A(n34), .B(n330), .C(n124), .D(n125), .Y(n118) );
  AOI22X1 U366 ( .A0(N165), .A1(n266), .B0(res_addr[0]), .B1(n42), .Y(n101) );
  NOR2BX1 U367 ( .AN(n117), .B(n128), .Y(n130) );
  NAND2X1 U368 ( .A(n331), .B(n119), .Y(n44) );
  NAND4BX1 U369 ( .AN(n116), .B(n117), .C(n332), .D(n261), .Y(n119) );
  NAND4X1 U370 ( .A(n99), .B(n100), .C(n101), .D(n102), .Y(n233) );
  AOI22X1 U371 ( .A0(res_addr[0]), .A1(n39), .B0(res_addr_add1[0]), .B1(n268), 
        .Y(n102) );
  AOI22X1 U372 ( .A0(n330), .A1(n262), .B0(res_addr[0]), .B1(n263), .Y(n99) );
  AOI22X1 U373 ( .A0(n330), .A1(n264), .B0(res_addr[0]), .B1(n265), .Y(n100)
         );
  NOR4X1 U374 ( .A(res_addr[6]), .B(res_addr[5]), .C(res_addr[4]), .D(
        res_addr[3]), .Y(n125) );
  NOR4X1 U375 ( .A(res_addr[11]), .B(res_addr[12]), .C(res_addr[10]), .D(n177), 
        .Y(n156) );
  OR4X1 U376 ( .A(res_addr[9]), .B(res_addr[8]), .C(res_addr[7]), .D(
        res_addr[13]), .Y(n177) );
  NAND4X1 U377 ( .A(n132), .B(n145), .C(n241), .D(n331), .Y(n140) );
  OAI211X1 U378 ( .A0(n319), .A1(n34), .B0(res_addr[7]), .C0(res_addr[0]), .Y(
        n29) );
  OAI31XL U379 ( .A0(n143), .A1(n328), .A2(n145), .B0(n146), .Y(N41) );
  CLKINVX1 U380 ( .A(n132), .Y(n328) );
  NAND3X1 U381 ( .A(n241), .B(n331), .C(n129), .Y(n143) );
  OAI21XL U382 ( .A0(n128), .A1(n240), .B0(n148), .Y(n146) );
  NOR2X1 U383 ( .A(n140), .B(n142), .Y(n148) );
  NOR2X1 U384 ( .A(n122), .B(n107), .Y(n43) );
  AND2X2 U385 ( .A(n126), .B(n331), .Y(n134) );
  NOR2X1 U386 ( .A(res_addr[2]), .B(res_addr[1]), .Y(n124) );
  CLKINVX1 U387 ( .A(res_addr[0]), .Y(n330) );
  NOR4BX1 U388 ( .AN(N21), .B(n89), .C(n156), .D(sti_a), .Y(N25) );
  NOR2X1 U389 ( .A(n128), .B(n319), .Y(n115) );
  CLKINVX1 U390 ( .A(n129), .Y(n319) );
  CLKINVX1 U391 ( .A(n157), .Y(n332) );
  NOR2X1 U392 ( .A(n244), .B(n332), .Y(n112) );
  CLKINVX1 U393 ( .A(n142), .Y(n333) );
  INVX3 U394 ( .A(n89), .Y(n327) );
  AND2X2 U395 ( .A(n112), .B(n331), .Y(n42) );
  NOR4X1 U396 ( .A(res_addr[4]), .B(res_addr[3]), .C(res_addr[2]), .D(
        res_addr[1]), .Y(n31) );
  NAND4X1 U397 ( .A(res_addr[2]), .B(res_addr[1]), .C(res_addr[3]), .D(
        res_addr[0]), .Y(n138) );
  AND3X2 U398 ( .A(res_addr[8]), .B(res_addr[5]), .C(res_addr[4]), .Y(n139) );
  CLKINVX1 U399 ( .A(res_di[6]), .Y(n316) );
  CLKINVX1 U400 ( .A(res_di[7]), .Y(n318) );
  NAND3X1 U401 ( .A(n240), .B(n242), .C(n189), .Y(n117) );
  NOR2X1 U402 ( .A(n241), .B(n239), .Y(n34) );
  NOR3X1 U403 ( .A(n261), .B(switch_sti_addr), .C(n116), .Y(n45) );
  NOR3X1 U404 ( .A(n332), .B(switch_sti_addr), .C(n116), .Y(n46) );
  CLKBUFX3 U405 ( .A(n40), .Y(n268) );
  AOI31X1 U406 ( .A0(n103), .A1(n104), .A2(n333), .B0(switch_sti_addr), .Y(n40) );
  AOI2BB2X1 U407 ( .B0(n334), .B1(n239), .A0N(n107), .A1N(n108), .Y(n103) );
  INVX3 U408 ( .A(switch_sti_addr), .Y(n331) );
  OAI221XL U409 ( .A0(n153), .A1(n329), .B0(n140), .B1(n104), .C0(n154), .Y(
        N40) );
  OA21XL U410 ( .A0(n128), .A1(n189), .B0(n332), .Y(n153) );
  NAND4BX1 U411 ( .AN(n155), .B(n134), .C(n132), .D(n241), .Y(n154) );
  NAND3X1 U412 ( .A(n187), .B(n240), .C(n189), .Y(n104) );
  NOR3X1 U413 ( .A(n240), .B(n187), .C(n243), .Y(n157) );
  OAI22XL U414 ( .A0(n140), .A1(n333), .B0(n187), .B1(n329), .Y(N42) );
  NAND3X1 U415 ( .A(n188), .B(n243), .C(n187), .Y(n145) );
  BUFX4 U416 ( .A(n335), .Y(res_addr[13]) );
  OR2X1 U417 ( .A(n145), .B(n239), .Y(n121) );
  CLKBUFX3 U418 ( .A(n51), .Y(n269) );
  NOR2X1 U419 ( .A(n98), .B(switch_sti_addr), .Y(n51) );
  NAND2X1 U420 ( .A(n186), .B(n28), .Y(n200) );
  NAND4BX1 U421 ( .AN(n29), .B(n30), .C(n31), .D(n32), .Y(n28) );
  NOR4X1 U422 ( .A(res_addr[13]), .B(res_addr[12]), .C(res_addr[11]), .D(
        res_addr[10]), .Y(n30) );
  NOR4X1 U423 ( .A(res_addr[9]), .B(res_addr[8]), .C(res_addr[6]), .D(
        res_addr[5]), .Y(n32) );
  NAND3X1 U424 ( .A(n134), .B(n239), .C(sti_a), .Y(n122) );
  OAI21XL U425 ( .A0(n135), .A1(n136), .B0(n239), .Y(n234) );
  NAND4BX1 U426 ( .AN(n137), .B(res_addr[10]), .C(res_addr[9]), .D(
        res_addr[11]), .Y(n136) );
  NAND4X1 U427 ( .A(res_addr[7]), .B(res_wr), .C(res_addr[6]), .D(n139), .Y(
        n135) );
  NAND3BX1 U428 ( .AN(n138), .B(res_addr[12]), .C(res_addr[13]), .Y(n137) );
  NAND4BX1 U429 ( .AN(n138), .B(N20), .C(n239), .D(n126), .Y(n89) );
  OAI2BB2XL U430 ( .B0(n327), .B1(n199), .A0N(N78), .A1N(n327), .Y(n221) );
  OAI2BB2XL U431 ( .B0(n327), .B1(n198), .A0N(N76), .A1N(n327), .Y(n222) );
  OAI2BB2XL U432 ( .B0(n327), .B1(n197), .A0N(N75), .A1N(n327), .Y(n223) );
  OAI2BB2XL U433 ( .B0(n327), .B1(n196), .A0N(N74), .A1N(n327), .Y(n224) );
  OAI2BB2XL U434 ( .B0(n327), .B1(n195), .A0N(N73), .A1N(n327), .Y(n225) );
  OAI2BB2XL U435 ( .B0(n327), .B1(n194), .A0N(N72), .A1N(n327), .Y(n226) );
  OAI2BB2XL U436 ( .B0(n327), .B1(n193), .A0N(N71), .A1N(n327), .Y(n227) );
  OAI2BB2XL U437 ( .B0(n327), .B1(n192), .A0N(N70), .A1N(n327), .Y(n228) );
  OAI2BB2XL U438 ( .B0(n327), .B1(n191), .A0N(N69), .A1N(n327), .Y(n229) );
  OAI2BB2XL U439 ( .B0(n327), .B1(n190), .A0N(N77), .A1N(n327), .Y(n230) );
  CLKBUFX3 U440 ( .A(reset), .Y(n285) );
  CLKBUFX3 U441 ( .A(reset), .Y(n284) );
  OA22X1 U442 ( .A0(N227), .A1(n289), .B0(n236), .B1(n288), .Y(n299) );
  AOI221X1 U443 ( .A0(sti_di[6]), .A1(n295), .B0(sti_di[7]), .B1(n294), .C0(
        n286), .Y(n289) );
  AOI221X1 U444 ( .A0(sti_di[10]), .A1(n295), .B0(sti_di[11]), .B1(n294), .C0(
        n293), .Y(n296) );
  NAND2BX2 U445 ( .AN(res_di[2]), .B(res_do[2]), .Y(n306) );
  AOI221X1 U446 ( .A0(sti_di[2]), .A1(n295), .B0(sti_di[3]), .B1(n294), .C0(
        n287), .Y(n288) );
  NAND2XL U447 ( .A(res_di_add[6]), .B(n257), .Y(n163) );
  NAND2XL U448 ( .A(res_di_add[5]), .B(n257), .Y(n165) );
  NAND2XL U449 ( .A(res_di_add[4]), .B(n257), .Y(n166) );
  NAND2XL U450 ( .A(res_di_add[3]), .B(n257), .Y(n167) );
  NAND2XL U451 ( .A(res_di_add[2]), .B(n257), .Y(n169) );
  NAND2XL U452 ( .A(res_di_add[1]), .B(n257), .Y(n171) );
  NAND2XL U453 ( .A(res_di_add[0]), .B(n257), .Y(n173) );
  OAI222X2 U454 ( .A0(res_do[6]), .A1(n260), .B0(n316), .B1(n260), .C0(
        res_do[6]), .C1(n316), .Y(n314) );
  OAI21X4 U455 ( .A0(res_di[7]), .A1(n185), .B0(n315), .Y(N297) );
  AO22X4 U456 ( .A0(n185), .A1(res_di[7]), .B0(n314), .B1(n313), .Y(n315) );
  XNOR2X1 U457 ( .A(res_addr[13]), .B(\sub_125/carry [13]), .Y(N163) );
  OR2X1 U458 ( .A(res_addr[12]), .B(\sub_125/carry [12]), .Y(
        \sub_125/carry [13]) );
  XNOR2X1 U459 ( .A(\sub_125/carry [12]), .B(res_addr[12]), .Y(N162) );
  OR2X1 U460 ( .A(res_addr[11]), .B(\sub_125/carry [11]), .Y(
        \sub_125/carry [12]) );
  XNOR2X1 U461 ( .A(\sub_125/carry [11]), .B(res_addr[11]), .Y(N161) );
  OR2X1 U462 ( .A(res_addr[10]), .B(\sub_125/carry [10]), .Y(
        \sub_125/carry [11]) );
  XNOR2X1 U463 ( .A(\sub_125/carry [10]), .B(res_addr[10]), .Y(N160) );
  OR2X1 U464 ( .A(res_addr[9]), .B(\sub_125/carry [9]), .Y(\sub_125/carry [10]) );
  XNOR2X1 U465 ( .A(\sub_125/carry [9]), .B(res_addr[9]), .Y(N159) );
  OR2X1 U466 ( .A(res_addr[8]), .B(\sub_125/carry [8]), .Y(\sub_125/carry [9])
         );
  XNOR2X1 U467 ( .A(\sub_125/carry [8]), .B(res_addr[8]), .Y(N158) );
  OR2X1 U468 ( .A(res_addr[7]), .B(\sub_125/carry [7]), .Y(\sub_125/carry [8])
         );
  XNOR2X1 U469 ( .A(\sub_125/carry [7]), .B(res_addr[7]), .Y(N157) );
  OR2X1 U470 ( .A(res_addr[6]), .B(\sub_125/carry [6]), .Y(\sub_125/carry [7])
         );
  XNOR2X1 U471 ( .A(\sub_125/carry [6]), .B(res_addr[6]), .Y(N156) );
  OR2X1 U472 ( .A(res_addr[5]), .B(\sub_125/carry [5]), .Y(\sub_125/carry [6])
         );
  XNOR2X1 U473 ( .A(\sub_125/carry [5]), .B(res_addr[5]), .Y(N155) );
  OR2X1 U474 ( .A(res_addr[4]), .B(\sub_125/carry [4]), .Y(\sub_125/carry [5])
         );
  XNOR2X1 U475 ( .A(\sub_125/carry [4]), .B(res_addr[4]), .Y(N154) );
  XOR2X1 U476 ( .A(res_addr[13]), .B(\add_119/carry [13]), .Y(N148) );
  AND2X1 U477 ( .A(\add_119/carry [12]), .B(res_addr[12]), .Y(
        \add_119/carry [13]) );
  XOR2X1 U478 ( .A(res_addr[12]), .B(\add_119/carry [12]), .Y(N147) );
  AND2X1 U479 ( .A(\add_119/carry [11]), .B(res_addr[11]), .Y(
        \add_119/carry [12]) );
  XOR2X1 U480 ( .A(res_addr[11]), .B(\add_119/carry [11]), .Y(N146) );
  AND2X1 U481 ( .A(\add_119/carry [10]), .B(res_addr[10]), .Y(
        \add_119/carry [11]) );
  XOR2X1 U482 ( .A(res_addr[10]), .B(\add_119/carry [10]), .Y(N145) );
  AND2X1 U483 ( .A(\add_119/carry [9]), .B(res_addr[9]), .Y(
        \add_119/carry [10]) );
  XOR2X1 U484 ( .A(res_addr[9]), .B(\add_119/carry [9]), .Y(N144) );
  AND2X1 U485 ( .A(\add_119/carry [8]), .B(res_addr[8]), .Y(\add_119/carry [9]) );
  XOR2X1 U486 ( .A(res_addr[8]), .B(\add_119/carry [8]), .Y(N143) );
  AND2X1 U487 ( .A(\add_119/carry [7]), .B(res_addr[7]), .Y(\add_119/carry [8]) );
  XOR2X1 U488 ( .A(res_addr[7]), .B(\add_119/carry [7]), .Y(N142) );
  OR2X1 U489 ( .A(res_addr[6]), .B(\add_119/carry [6]), .Y(\add_119/carry [7])
         );
  XNOR2X1 U490 ( .A(\add_119/carry [6]), .B(res_addr[6]), .Y(N141) );
  OR2X1 U491 ( .A(res_addr[5]), .B(\add_119/carry [5]), .Y(\add_119/carry [6])
         );
  XNOR2X1 U492 ( .A(\add_119/carry [5]), .B(res_addr[5]), .Y(N140) );
  OR2X1 U493 ( .A(res_addr[4]), .B(\add_119/carry [4]), .Y(\add_119/carry [5])
         );
  XNOR2X1 U494 ( .A(\add_119/carry [4]), .B(res_addr[4]), .Y(N139) );
  XNOR2X1 U495 ( .A(res_addr[13]), .B(\sub_113/carry[13] ), .Y(N133) );
  OR2X1 U496 ( .A(res_addr[12]), .B(\sub_113/carry[12] ), .Y(
        \sub_113/carry[13] ) );
  XNOR2X1 U497 ( .A(\sub_113/carry[12] ), .B(res_addr[12]), .Y(N132) );
  OR2X1 U498 ( .A(res_addr[11]), .B(\sub_113/carry[11] ), .Y(
        \sub_113/carry[12] ) );
  XNOR2X1 U499 ( .A(\sub_113/carry[11] ), .B(res_addr[11]), .Y(N131) );
  OR2X1 U500 ( .A(res_addr[10]), .B(\sub_113/carry[10] ), .Y(
        \sub_113/carry[11] ) );
  XNOR2X1 U501 ( .A(\sub_113/carry[10] ), .B(res_addr[10]), .Y(N130) );
  OR2X1 U502 ( .A(res_addr[9]), .B(\sub_113/carry[9] ), .Y(\sub_113/carry[10] ) );
  XNOR2X1 U503 ( .A(\sub_113/carry[9] ), .B(res_addr[9]), .Y(N129) );
  OR2X1 U504 ( .A(res_addr[8]), .B(\sub_113/carry[8] ), .Y(\sub_113/carry[9] )
         );
  XNOR2X1 U505 ( .A(\sub_113/carry[8] ), .B(res_addr[8]), .Y(N128) );
  AND2X1 U506 ( .A(\sub_113/carry[7] ), .B(res_addr[7]), .Y(\sub_113/carry[8] ) );
  XOR2X1 U507 ( .A(res_addr[7]), .B(\sub_113/carry[7] ), .Y(N127) );
  OR2X1 U508 ( .A(res_addr[6]), .B(\sub_113/carry[6] ), .Y(\sub_113/carry[7] )
         );
  XNOR2X1 U509 ( .A(\sub_113/carry[6] ), .B(res_addr[6]), .Y(N126) );
  OR2X1 U510 ( .A(res_addr[5]), .B(\sub_113/carry[5] ), .Y(\sub_113/carry[6] )
         );
  XNOR2X1 U511 ( .A(\sub_113/carry[5] ), .B(res_addr[5]), .Y(N125) );
  OR2X1 U512 ( .A(res_addr[4]), .B(\sub_113/carry[4] ), .Y(\sub_113/carry[5] )
         );
  XNOR2X1 U513 ( .A(\sub_113/carry[4] ), .B(res_addr[4]), .Y(N124) );
  XNOR2X1 U514 ( .A(res_addr[13]), .B(\sub_135/carry [13]), .Y(N238) );
  OR2X1 U515 ( .A(res_addr[12]), .B(\sub_135/carry [12]), .Y(
        \sub_135/carry [13]) );
  XNOR2X1 U516 ( .A(\sub_135/carry [12]), .B(res_addr[12]), .Y(N237) );
  OR2X1 U517 ( .A(res_addr[11]), .B(\sub_135/carry [11]), .Y(
        \sub_135/carry [12]) );
  XNOR2X1 U518 ( .A(\sub_135/carry [11]), .B(res_addr[11]), .Y(N236) );
  OR2X1 U519 ( .A(res_addr[10]), .B(\sub_135/carry [10]), .Y(
        \sub_135/carry [11]) );
  XNOR2X1 U520 ( .A(\sub_135/carry [10]), .B(res_addr[10]), .Y(N235) );
  OR2X1 U521 ( .A(res_addr[9]), .B(\sub_135/carry [9]), .Y(\sub_135/carry [10]) );
  XNOR2X1 U522 ( .A(\sub_135/carry [9]), .B(res_addr[9]), .Y(N234) );
  OR2X1 U523 ( .A(res_addr[8]), .B(res_addr[7]), .Y(\sub_135/carry [9]) );
  XNOR2X1 U524 ( .A(res_addr[7]), .B(res_addr[8]), .Y(N233) );
  XOR2X1 U525 ( .A(res_addr[13]), .B(\add_133/carry[13] ), .Y(N223) );
  AND2X1 U526 ( .A(\add_133/carry[12] ), .B(res_addr[12]), .Y(
        \add_133/carry[13] ) );
  XOR2X1 U527 ( .A(res_addr[12]), .B(\add_133/carry[12] ), .Y(N222) );
  AND2X1 U528 ( .A(\add_133/carry[11] ), .B(res_addr[11]), .Y(
        \add_133/carry[12] ) );
  XOR2X1 U529 ( .A(res_addr[11]), .B(\add_133/carry[11] ), .Y(N221) );
  AND2X1 U530 ( .A(\add_133/carry[10] ), .B(res_addr[10]), .Y(
        \add_133/carry[11] ) );
  XOR2X1 U531 ( .A(res_addr[10]), .B(\add_133/carry[10] ), .Y(N220) );
  AND2X1 U532 ( .A(\add_133/carry[9] ), .B(res_addr[9]), .Y(
        \add_133/carry[10] ) );
  XOR2X1 U533 ( .A(res_addr[9]), .B(\add_133/carry[9] ), .Y(N219) );
  AND2X1 U534 ( .A(\add_133/carry[8] ), .B(res_addr[8]), .Y(\add_133/carry[9] ) );
  XOR2X1 U535 ( .A(res_addr[8]), .B(\add_133/carry[8] ), .Y(N218) );
  AND2X1 U536 ( .A(\add_133/carry[7] ), .B(res_addr[7]), .Y(\add_133/carry[8] ) );
  XOR2X1 U537 ( .A(res_addr[7]), .B(\add_133/carry[7] ), .Y(N217) );
  OR2X1 U538 ( .A(res_addr[6]), .B(\add_133/carry[6] ), .Y(\add_133/carry[7] )
         );
  XNOR2X1 U539 ( .A(\add_133/carry[6] ), .B(res_addr[6]), .Y(N216) );
  OR2X1 U540 ( .A(res_addr[5]), .B(\add_133/carry[5] ), .Y(\add_133/carry[6] )
         );
  XNOR2X1 U541 ( .A(\add_133/carry[5] ), .B(res_addr[5]), .Y(N215) );
  OR2X1 U542 ( .A(res_addr[4]), .B(\add_133/carry[4] ), .Y(\add_133/carry[5] )
         );
  XNOR2X1 U543 ( .A(\add_133/carry[4] ), .B(res_addr[4]), .Y(N214) );
  OR2X1 U544 ( .A(res_addr[3]), .B(\sub_125/carry [3]), .Y(\sub_125/carry [4])
         );
  XNOR2X1 U545 ( .A(\sub_125/carry [3]), .B(res_addr[3]), .Y(N153) );
  OR2X1 U546 ( .A(res_addr[3]), .B(\add_119/carry [3]), .Y(\add_119/carry [4])
         );
  XNOR2X1 U547 ( .A(\add_119/carry [3]), .B(res_addr[3]), .Y(N138) );
  OR2X1 U548 ( .A(res_addr[3]), .B(\sub_113/carry[3] ), .Y(\sub_113/carry[4] )
         );
  XNOR2X1 U549 ( .A(\sub_113/carry[3] ), .B(res_addr[3]), .Y(N123) );
  OR2X1 U550 ( .A(res_addr[3]), .B(\add_133/carry[3] ), .Y(\add_133/carry[4] )
         );
  XNOR2X1 U551 ( .A(\add_133/carry[3] ), .B(res_addr[3]), .Y(N213) );
  OR2X1 U552 ( .A(res_addr[2]), .B(res_addr[1]), .Y(\sub_125/carry [3]) );
  XNOR2X1 U553 ( .A(res_addr[1]), .B(res_addr[2]), .Y(N152) );
  OR2X1 U554 ( .A(res_addr[2]), .B(res_addr[1]), .Y(\add_119/carry [3]) );
  XNOR2X1 U555 ( .A(res_addr[1]), .B(res_addr[2]), .Y(N137) );
  OR2X1 U556 ( .A(res_addr[2]), .B(\sub_113/carry[2] ), .Y(\sub_113/carry[3] )
         );
  XNOR2X1 U557 ( .A(\sub_113/carry[2] ), .B(res_addr[2]), .Y(N122) );
  OR2X1 U558 ( .A(res_addr[2]), .B(\add_133/carry[2] ), .Y(\add_133/carry[3] )
         );
  XNOR2X1 U559 ( .A(\add_133/carry[2] ), .B(res_addr[2]), .Y(N212) );
  OR2X1 U560 ( .A(res_addr[1]), .B(res_addr[0]), .Y(\sub_113/carry[2] ) );
  XNOR2X1 U561 ( .A(res_addr[0]), .B(res_addr[1]), .Y(N121) );
  OR2X1 U562 ( .A(res_addr[1]), .B(res_addr[0]), .Y(\add_133/carry[2] ) );
  XNOR2X1 U563 ( .A(res_addr[0]), .B(res_addr[1]), .Y(N211) );
  NOR2X1 U564 ( .A(N135), .B(n237), .Y(n292) );
  NOR2X1 U565 ( .A(n238), .B(n237), .Y(n291) );
  AO22X1 U566 ( .A0(sti_di[5]), .A1(n292), .B0(sti_di[4]), .B1(n291), .Y(n286)
         );
  AO22X1 U567 ( .A0(sti_di[1]), .A1(n292), .B0(sti_di[0]), .B1(n291), .Y(n287)
         );
  AO22X1 U568 ( .A0(sti_di[9]), .A1(n292), .B0(sti_di[8]), .B1(n291), .Y(n293)
         );
  NAND2X1 U569 ( .A(sti_addr[1]), .B(sti_addr[0]), .Y(n300) );
  NAND4BX1 U570 ( .AN(n300), .B(sti_addr[2]), .C(sti_addr[4]), .D(sti_addr[3]), 
        .Y(n302) );
  AND3X1 U571 ( .A(sti_addr[6]), .B(sti_addr[5]), .C(sti_addr[7]), .Y(n301) );
  NAND4BX1 U572 ( .AN(n302), .B(sti_addr[8]), .C(n301), .D(sti_addr[9]), .Y(
        N20) );
  NAND4X1 U573 ( .A(res_addr[13]), .B(res_addr[12]), .C(res_addr[11]), .D(
        res_addr[10]), .Y(n317) );
  NAND4BX1 U574 ( .AN(n317), .B(res_addr[7]), .C(res_addr[9]), .D(res_addr[8]), 
        .Y(N21) );
endmodule

