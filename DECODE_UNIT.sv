module DECODE_UNIT (
	
	input clk_i,    // Clock
	input DECrst_i,  // Asynchronous reset active low
	input logic [31:0] instr_i,//32 BIT INSTRUCTION FROM INSTRUCTION MEM
	input logic I_EN_i,//I TYPE INSTRUCTION ENABLE FROM CONTROL
	input logic R_EN_i,//R TYPE INSTRUCTION ENABLE FROM CONTROL
	input logic S_EN_i,//S TYPE INSTRUCTION ENABLE FROM CONTROL
	input logic SB_EN_i,//SB TYPE INSTRUCTION ENABLE FROM CONTROL
	input logic U_EN_i,//U TYPE INSTRUCTION ENABLE FROM CONTROL
	input logic UJ_EN_i,//UJ TYPE INSTRUCTION ENABLE FROM CONTROL
	output logic [4:0] RS1_o,
	output logic [4:0] RS2_o,
	output logic [4:0] RD_o,
	output logic [6:0] opcode_o,
	output logic [2:0] func3_o,
	output logic [6:0] func7_o,
	output logic [31:0] immed_o
    );
    
    always_comb begin 
     opcode_o= instr_i[6:0] ;
     func7_o=7'd0;

        if (R_EN_i) begin
     	 RD_o    = instr_i[11:7];
     	 func3_o = instr_i[14:12];
     	 RS1_o   = instr_i[19:15];
     	 RS2_o   = instr_i[24:20];
     	 func7_o =instr_i[31:25];
         end
        else if (I_EN_i==1) begin
     	 RD_o    = instr_i[11:7];
     	 func3_o = instr_i[14:12];
     	 RS1_o   = instr_i[19:15];
     	 func7_o =instr_i[31:25];
     	 immed_o = {20'd0,instr_i[31:20]};
         end
        else if (S_EN_i==1) begin
     	 func3_o = instr_i[14:12];
     	 RS1_o   = instr_i[19:15];
     	 RS2_o   = instr_i[24:20];
     	 immed_o={20'd0,instr_i[31:25],instr_i[11:7]};
         end
        else if (SB_EN_i==1) begin
     	 func3_o = instr_i[14:12];
     	 RS1_o   = instr_i[19:15];
     	 RS2_o   = instr_i[24:20];
     	 immed_o = {20'd0,instr_i[31],instr_i[7],instr_i[30:25],instr_i[11:8]};

         end
        else if (U_EN_i==1) begin
     	 RD_o   = instr_i[11:7];
     	 immed_o={12'd0,instr_i[31:12]};
     	 
     	 end
        else if (UJ_EN_i==1) begin
         RD_o   = instr_i[11:7];
         immed_o = {12'd0,instr_i[31],instr_i[19:12],instr_i[20],instr_i[30:21]};
         
         end

     end

 endmodule
