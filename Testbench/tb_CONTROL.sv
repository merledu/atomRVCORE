timeunit 1ns; timeprecision 1ns;
module tb_CONTROL 
	(
	 output logic [6:0] opcode_o,
	 output logic [2:0] func3_o,
	 output logic [6:0] func7_o,
	 input logic I_EN_i,//I TYPE INSTRUCTION ENABLE FROM CONTROL
	 input logic R_EN_i,
	 input logic S_EN_i,//S TYPE INSTRUCTION ENABLE FROM CONTROL
	 input logic SB_EN_i,//SB TYPE INSTRUCTION ENABLE FROM CONTROL
	 input logic U_EN_i,//U TYPE INSTRUCTION ENABLE FROM CONTROL
	 input logic UJ_EN_i,//UJ TYPE INSTRUCTION ENABLE FROM CONTROL
	 input logic RWR_EN_i,//REG WRITE ENABLE FROM CONTROL
	 input logic BE_i,//BRANCH ENABLE SIGNAL FROM CONTROL TO
	 input logic JALRE_i,//JUMP AND LINK ENABLE SIGNAL FROM CONTROL UNIT FETCH
	 input logic UJE_i,//UJ ENABLE SIGNAL FROM CONTROL UNIT TO FETCH
	 input logic IWR_EN_i,//INSTRUCTION WRITE ENABLE SIGNAL TO WRITE ON INSTRUCTION MEM
	 input logic [5:0] ALUop_i//ALU OPCODE SWITCH FOR OPERATION
	
     );


	
    initial begin
    	opcode_o=7'h13;
    	func3_o=3'h0;
    	func7_o=7'h0;


    	#10 opcode_o=7'h13;
    	func3_o=3'h0;
    	func7_o=7'h0;


    	#10 opcode_o=7'h13;
    	func3_o=3'h1;
    	func7_o=7'h0;

    	#10 opcode_o=7'h13;
    	func3_o=3'h2;
    	func7_o=7'h0;

    	#10 opcode_o=7'h13;
    	func3_o=3'h3;
    	func7_o=7'h0;

    	#10 opcode_o=7'h13;
    	func3_o=3'h4;
    	func7_o=7'h0;

    	#10 opcode_o=7'h13;
    	func3_o=3'h5;
    	func7_o=7'h6;

    	#10 opcode_o=7'h13;
    	func3_o=3'h5;
    	func7_o=7'h20;

    	#10 opcode_o=7'h13;
    	func3_o=3'h6;
    	func7_o=7'h0;


    	#10 opcode_o=7'h13;
    	func3_o=3'h7;
    	func7_o=7'h0;










     end



 endmodule
