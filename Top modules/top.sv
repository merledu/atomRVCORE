timeunit 1ns; timeprecision 1ns;
module top ();


    logic clk_o;    // Clock
    logic [31:0] PC_instr_tb;
    logic [31:0] instr_tb;
	logic BE_tb;
	logic JALRE_tb;
	logic UJE_tb;
	logic [4:0] RD_tb;
    logic [31:0] immed_tb;
	logic IWR_EN_tb;
	logic IR_EN_tb;
	logic I_EN_tb;
	logic R_EN_tb;
	logic S_EN_tb;
	logic SB_EN_tb;
	logic U_EN_tb;
	logic UJ_EN_tb;
	logic [4:0] RS1_tb;
	logic [4:0] RS2_tb;
	logic [6:0] opcode_tb;
	logic [2:0] func3_tb;
	logic [6:0] func7_tb;
	logic RWR_EN_tb;//REG WRITE ENABLE FROM CONTROL
	logic [5:0] ALUop_tb;
	logic [31:0] operand_A_tb;
	logic [31:0] operand_B_tb;
	logic [31:0] result_tb;
	logic regrst_tb;
	logic PCrst_tb;
	logic [31:0] RGD_tb;
	logic [31:0] DATAi_tb;
	logic [31:0] DTo_tb;
	logic [31:0] DTi_tb;
	logic DWR_EN_tb;
	logic DR_EN_tb;
	logic [31:0] address_tb;
	logic [31:0] REG2_tb;
	logic LUI_EN_tb;






  FETCH_UNIT fetch( .clk_i(clk_o), .PCrst_i(PCrst_tb) ,.LUI_EN_i(LUI_EN_tb), .PC_instr_o(PC_instr_tb), .BE_i(BE_tb), .JALRE_i(JALRE_tb), .UJE_i(UJE_tb), .U_EN_i(U_EN_tb) , .RGD_o(RGD_tb), .R1_i(operand_A_tb), .immed_i(immed_tb) );
 
  INSTRUCTION_MEM instrMEM(.clk_i(clk_o), .DATA_i(DATAi_tb) , .address_i(PC_instr_tb), .DATA_o(instr_tb), .IWR_EN_i(IWR_EN_tb), .IR_EN_i(IR_EN_tb) );
 
  DECODE_UNIT decode( .instr_i(instr_tb), .I_EN_i(I_EN_tb), .DWR_EN_i(DWR_EN_tb) , .DR_EN_i(DR_EN_tb) , .R1_i(operand_A_tb) , .R_EN_i(R_EN_tb), .S_EN_i(S_EN_tb), .SB_EN_i(SB_EN_tb), .U_EN_i(U_EN_tb), .address_o(address_tb),
	.UJ_EN_i(UJ_EN_tb) , .immed_o(immed_tb), .RS1_o(RS1_tb), .RS2_o(RS2_tb), .RD_o(RD_tb), .opcode_o(opcode_tb), .func3_o(func3_tb), .func7_o(func7_tb),.R2_i(REG2_tb), .operand_B_o(operand_B_tb) );
 
  CONTROL cntrl( .opcode_i(opcode_tb),.LUI_EN_o(LUI_EN_tb), .PCrst_o(PCrst_tb) , .result_i(result_tb) , .regrst_o(regrst_tb), .func3_i(func3_tb), .func7_i(func7_tb), .I_EN_o(I_EN_tb), .R_EN_o(R_EN_tb), .S_EN_o(S_EN_tb), .SB_EN_o(SB_EN_tb), .U_EN_o(U_EN_tb), 
	.UJ_EN_o(UJ_EN_tb), .RWR_EN_o(RWR_EN_tb), .BE_o(BE_tb), .JALRE_o(JALRE_tb), .UJE_o(UJE_tb), .IWR_EN_o(IWR_EN_tb), .ALUop_o(ALUop_tb), .IR_EN_o(IR_EN_tb), .DWR_EN_o(DWR_EN_tb), .DR_EN_o(DR_EN_tb) );
 
  ALU alu( .ALUop_i(ALUop_tb), .operand_A(operand_A_tb), .operand_B(operand_B_tb), .result_o(result_tb) );
 
  REG_FILE dut( .clk_i(clk_o), .regrst_i(regrst_tb), .lb_i(DTo_tb) ,.LUI_EN_i(LUI_EN_tb), .DR_EN_i(DR_EN_tb) , .RS1_i(RS1_tb), .RS2_i(RS2_tb), .RD_i(RD_tb), .R1_o(operand_A_tb), .R2_o(REG2_tb), .WR_i(result_tb),  .U_EN_i(U_EN_tb),.RWR_EN_i(RWR_EN_tb), .JALRE_i(JALRE_tb), .RGD_i(RGD_tb) );	
  
  DATA_MEM dataMEM(.clk_i(clk_o), .DT_i(REG2_tb) , .address_i(address_tb), .DT_o(DTo_tb), .DWR_EN_i(DWR_EN_tb), .DR_EN_i(DR_EN_tb) );
 

initial begin

     clk_o <= 0;
     forever #10 clk_o = ~clk_o;

     end
endmodule