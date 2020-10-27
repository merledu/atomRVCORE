timeunit 1ns; timeprecision 1ns;
module atomRVCORE_top #(
	parameter DATAWIDTH=32,
	parameter REG_ADRESS_WIDTH=5,
	parameter ALU_OP=6

	)();

	logic clk_o;    // Clock
    logic [DATAWIDTH-1:0] PC_instr_tb;
    logic [DATAWIDTH-1:0] instr_tb;
	logic BE_tb;
	logic JALRE_tb;
	logic UJE_tb;
	logic [REG_ADRESS_WIDTH-1:0] RD_tb;
    logic [DATAWIDTH-1:0] immed_tb;
	logic IWR_EN_tb;
	logic U_EN_tb;
	logic UJ_EN_tb;
	logic RWR_EN_tb;//REG WRITE ENABLE FROM CONTROL
	logic [ALU_OP-1:0] ALUop_tb;
	logic [DATAWIDTH-1:0] operand_A_tb;
	logic [DATAWIDTH-1:0] operand_B_tb;
	logic [DATAWIDTH-1:0] result_tb;
	logic PCrst_tb;
	logic DWR_EN_tb;
	logic DR_EN_tb;
	logic [DATAWIDTH-1:0] address_tb;
	logic [DATAWIDTH-1:0] REG2_tb;
	logic LUI_EN_tb;
	logic [DATAWIDTH-1:0] instrF_tb;
	logic [DATAWIDTH-1:0] WR_o_tbf;
	logic RWR_EN_tbf;
	logic [REG_ADRESS_WIDTH-1:0] RD_tbf;
	logic [DATAWIDTH-1:0] PC_tf;
  logic [DATAWIDTH-1:0] DATAi_tb;
	logic [DATAWIDTH-1:0] PC_tff;
	logic BE_tbf;
	logic [REG_ADRESS_WIDTH-1:0] RD_tbff;
	logic [DATAWIDTH-1:0] address_tbf;
	logic [DATAWIDTH-1:0] REG2_tbf;
  logic [DATAWIDTH-1:0] DT_tb;
  logic DR_EN_tbff;
	
  atomRVCORE_ifu fetchUnit( 
  	.clk_i(clk_o), //
  	.PCrst_i(PCrst_tb) ,//
  	.instruction_i(instr_tb) ,// 
  	.instruction_o(instrF_tb),// 
  	.PC_instr_o(PC_instr_tb),//, 
  	.BE_i(BE_tbf),//
  	.PC_i(PC_tff)//
  	 );
 
  atomRVCORE_iccm instrMEM(
  	.clk_i(clk_o),// 
  	.DATA_i(DATAi_tb) ,// 
  	.address_i(PC_instr_tb),// 
  	.DATA_o(instr_tb), //
  	.IWR_EN_i(IWR_EN_tb),// 
  	.IR_EN_i(IR_EN_tb) );//
 
  atomRVCORE_idu decoder( 
  	.clk_i(clk_o),// 
  	.PC_o(PC_tf) ,// 
  	.PC_i(PC_instr_tb) ,// 
  	.instr_i(instrF_tb), // 
  	.RWR_EN_if(RWR_EN_tbff) ,// 
  	.RD_if(RD_tbff) ,//
  	.WR_if(WR_o_tbf)  ,// 
  	.DWR_EN_o(DWR_EN_tb) ,// 
  	.DR_EN_o(DR_EN_tb) , //
  	.operand_A_o(operand_A_tb) ,// 
  	.U_EN_o(U_EN_tb),// 
  	.address_o(address_tb),
	.UJ_EN_o(UJ_EN_tb) ,
	.RWR_EN_o(RWR_EN_tb),  
	. RD_o(RD_tb),  
	.R2_o(REG2_tb) , 
	.immed_o(immed_tb), 
	.operand_B_o(operand_B_tb),
	.LUI_EN_o(LUI_EN_tb), 
	.PCrst_o(PCrst_tb) ,// 
	.JALRE_o(JALRE_tb), 
	.UJE_o(UJE_tb),
  .SB_EN_o(BE_tb),
	.IR_EN_o(IR_EN_tb) , 
	.IWR_EN_o(IWR_EN_tb),
  .DR_EN_i(DR_EN_tbff),
  .DT_i(DT_tb), 
	.ALUop_o(ALUop_tb) );
 
  atomRVCORE_alu alu( 
  	.clk_i(clk_o), //
  	.ALUop_i(ALUop_tb), //
  	.PC_i(PC_tf),// 
  	.immed_i(immed_tb),//
  	.operand_B(operand_B_tb), //
  	.operand_A(operand_A_tb),
  	.address_i(address_tb),//
  	.DR_EN_i(DR_EN_tb),//
  	.DWR_EN_i(DWR_EN_tb),//
  	.RD_i(RD_tb),//
  	.RWR_EN_i(RWR_EN_tb),
  	.R2_i(REG2_tb),
  	.SB_EN_i(BE_tb),//
  	.UJE_i(UJE_tb),//
  	.JALRE_i(JALRE_tb),//
  	.U_EN_i(U_EN_tb),//
  	.LUI_EN_i(LUI_EN_tb),//
 	.result_o(result_tb),
  	.address_o(address_tbf),//
  	.DR_EN_o(DR_EN_tbf),//
  	.DWR_EN_o(DWR_EN_tbf),//
  	.PC_o(PC_tff)  ,//
  	.RD_o(RD_tbf),
  	.RWR_EN_o(RWR_EN_tbf),//
  	.R2_o(REG2_tbf),
  	.BE_o(BE_tbf)//
  	 );
  
  atomRVCORE_dccm dataMEM(
  	.clk_i(clk_o), 
  	.RWR_EN_o(RWR_EN_tbff) ,/*.WR_o(WR_o_tbf) ,*/
  	.RD_o(RD_tbff) , 
  	.RWR_EN_i(RWR_EN_tbf) , 
  	.RD_i(RD_tbf) ,/* .WR_i(result_tb) ,*/  
  	.DT_i(REG2_tbf) , 
  	.address_i(address_tbf),//
  	.result_i(result_tb), 
  	.DWR_EN_i(DWR_EN_tb),
  	.WR_o(WR_o_tbf), 
  	.DR_EN_i(DR_EN_tbf),
    .DR_EN_o(DR_EN_tbff),
    .DT_o(DT_tb)

     );
 

initial begin

     clk_o <= 0;
     forever #10 clk_o = ~clk_o;

     end

endmodule : atomRVCORE_top
