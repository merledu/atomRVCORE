timeunit 1ns; timeprecision 1ns;
    module top_CONTROL ();

    logic [6:0] opcode_tb;
	logic [2:0] func3_tb;
	logic [6:0] func7_tb;
	logic I_EN_tb;//I TYPE INSTRUCTION ENABLE FROM CONTROL
	logic R_EN_tb;
	logic S_EN_tb;//S TYPE INSTRUCTION ENABLE FROM CONTROL
	logic SB_EN_tb;//SB TYPE INSTRUCTION ENABLE FROM CONTROL
	logic U_EN_tb;//U TYPE INSTRUCTION ENABLE FROM CONTROL
	logic UJ_EN_tb;//UJ TYPE INSTRUCTION ENABLE FROM CONTROL
	logic RWR_EN_tb;//REG WRITE ENABLE FROM CONTROL
	logic BE_tb;//BRANCH ENABLE SIGNAL FROM CONTROL TO
	logic JALRE_tb;//JUMP AND LINK ENABLE SIGNAL FROM CONTROL UNIT FETCH
	logic UJE_tb;//UJ ENABLE SIGNAL FROM CONTROL UNIT TO FETCH
	logic IWR_EN_tb;//INSTRUCTION WRITE ENABLE SIGNAL TO WRITE ON INSTRUCTION MEM
	logic [5:0] ALUop_tb;


	CONTROL dut( .opcode_i(opcode_tb), .func3_i(func3_tb), .func7_i(func7_tb), .I_EN_o(I_EN_tb), .R_EN_o(R_EN_tb), .S_EN_o(S_EN_tb), .SB_EN_o(SB_EN_tb), .U_EN_o(U_EN_tb), 
	.UJ_EN_o(UJ_EN_tb), .RWR_EN_o(RWR_EN_tb), .BE_o(BE_tb), .JALRE_o(JALRE_tb), .UJE_o(UJE_tb), .IWR_EN_o(IWR_EN_tb), .ALUop_o(ALUop_tb));
	
	tb_CONTROL test(.opcode_o(opcode_tb), .func3_o(func3_tb), .func7_o(func7_tb), .I_EN_i(I_EN_tb), .R_EN_i(R_EN_tb), .S_EN_i(S_EN_tb), .SB_EN_i(SB_EN_tb), .U_EN_i(U_EN_tb), 
	.UJ_EN_i(UJ_EN_tb), .RWR_EN_i(RWR_EN_tb), .BE_i(BE_tb), .JALRE_i(JALRE_tb), .UJE_i(UJE_tb), .IWR_EN_i(IWR_EN_tb), .ALUop_i(ALUop_tb));



 endmodule : top_CONTROL