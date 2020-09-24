timeunit 1ns; timeprecision 1ns;

module tb_DECODE_UNIT 
	(
	  input clk_i,    // Clock
	  output logic [31:0] instr_o,//32 BIT INSTRUCTION FROM INSTRUCTION MEM
	  output logic I_EN_o,//I TYPE INSTRUCTION ENABLE FROM CONTROL
	  output logic R_EN_o,//R TYPE INSTRUCTION ENABLE FROM CONTROL
	  output logic S_EN_o,//S TYPE INSTRUCTION ENABLE FROM CONTROL
	  output logic SB_EN_o,//SB TYPE INSTRUCTION ENABLE FROM CONTROL
	  output logic U_EN_o,//U TYPE INSTRUCTION ENABLE FROM CONTROL
	  output logic UJ_EN_o,//UJ TYPE INSTRUCTION ENABLE FROM CONTROL
	  input logic [4:0] RS1_i,
	  input logic [4:0] RS2_i,
	  input logic [4:0] RD_i,
	  input logic [6:0] opcode_i,
	  input logic [2:0] func3_i,
	  input logic [6:0] func7_i,
	  input logic [31:0] immed_i
     );


    initial begin

        I_EN_o=1'b1;
        R_EN_o=1'b0;
        S_EN_o=1'b0;
        SB_EN_o=1'b0;
        U_EN_o=1'b0;
        UJ_EN_o=1'b0;
    	instr_o =32'h00600293;


        #10ns instr_o =32'h00628213;
        I_EN_o=1'b1;

        #5ns I_EN_o = 1'b0;

        #10ns instr_o =32'h007372B3;
        R_EN_o=1'b1;

        #5ns R_EN_o=1'b0;


        #10ns instr_o=32'h00800313;
        I_EN_o=1'b1;
        #10ns instr_o =32'h00837293;

        #10ns instr_o=32'h40135293;




 




     end




 endmodule