module CONTROL 
	(
	 input clk_i,    // Clock
	 input cntrst_i,  // Asynchronous reset active low
	 input logic [31:0] instr_i,
	 input logic [4:0] opcode_i,
	 input logic [2:0] func3_i,
	 input logic func7_i,
     output logic R_EN_o,//R TYPE INSTRUCTION ENABLE FROM CONTROL
	 output logic I_EN_o,//I TYPE INSTRUCTION ENABLE FROM CONTROL
	 output logic S_EN_o,//S TYPE INSTRUCTION ENABLE FROM CONTROL
	 output logic SB_EN_o,//SB TYPE INSTRUCTION ENABLE FROM CONTROL
	 output logic U_EN_o,//U TYPE INSTRUCTION ENABLE FROM CONTROL
	 output logic UJ_EN_o,//UJ TYPE INSTRUCTION ENABLE FROM CONTROL
	 input logic RWR_EN_o,
	 input logic RR_EN_o,
	 input logic BE_o,//BRANCH ENABLE SIGNAL FROM CONTROL
	 input logic JALRE_o,//JUMP AND LINK ENABLE SIGNAL FROM CONTROL UNIT
	 input logic UJE_o,//UJ ENABLE SIGNAL FROM CONTROL UNIT
	 input logic IR_EN_o,
	 input logic IWR_EN_o,

     );

	always_comb begin 


	    if (opcode_i==5'b00100 && func3_i==3'b000 && func7_i!=1'b1) begin
	    	I_EN_o =1'b1;
	    	RR_EN_o=1'b1;
	    	RWR_EN_o-1'b1;
	    	


	     end
	
	 end

 endmodule : CONTROL
