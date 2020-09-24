timeunit 1ns; timeprecision 1ns;
module top_DECODE_UNIT ();

    logic clk_o;    // Clock
    logic [31:0] instr_tb;
	logic I_EN_tb;
	logic R_EN_tb;
	logic S_EN_tb;
	logic SB_EN_tb;
	logic U_EN_tb;
	logic UJ_EN_tb;
	logic [4:0] RS1_tb;
	logic [4:0] RS2_tb;
	logic [4:0] RD_tb;
	logic [6:0] opcode_tb;
	logic [2:0] func3_tb;
	logic [6:0] func7_tb;
	logic [31:0] immed_tb;


	DECODE_UNIT dut(.clk_i(clk_o), .instr_i(instr_tb), .I_EN_i(I_EN_tb), .R_EN_i(R_EN_tb), .S_EN_i(S_EN_tb), .SB_EN_i(SB_EN_tb), .U_EN_i(U_EN_tb), 
	.UJ_EN_i(UJ_EN_tb) , .immed_o(immed_tb), .RS1_o(RS1_tb), .RS2_o(RS2_tb), .RD_o(RD_tb), .opcode_o(opcode_tb), .func3_o(func3_tb), .func7_o(func7_tb) );

	tb_DECODE_UNIT test(.clk_i(clk_o), .instr_o(instr_tb), .I_EN_o(I_EN_tb), .R_EN_o(R_EN_tb), .S_EN_o(S_EN_tb), .SB_EN_o(SB_EN_tb), .U_EN_o(U_EN_tb), 
	.UJ_EN_o(UJ_EN_tb) , .immed_i(immed_tb), .RS1_i(RS1_tb), .RS2_i(RS2_tb), .RD_i(RD_tb), .opcode_i(opcode_tb), .func3_i(func3_tb), .func7_i(func7_tb) );


	initial begin

     clk_o <= 0;
     forever #10 clk_o = ~clk_o;

     end


 endmodule