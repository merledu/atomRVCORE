module DECODE_UNIT (
	
	input clk_i,    // Clock
	input DECrst_i,  // Asynchronous reset active low
	input logic [31:0] instr_i,//32 BIT INSTRUCTION FROM INSTRUCTION MEM
	input logic R_EN_i,//R TYPE INSTRUCTION ENABLE FROM CONTROL
	input logic I_EN_i,//I TYPE INSTRUCTION ENABLE FROM CONTROL
	input logic S_EN_i,//S TYPE INSTRUCTION ENABLE FROM CONTROL
	input logic SB_EN_i,//SB TYPE INSTRUCTION ENABLE FROM CONTROL
	input logic U_EN_i,//U TYPE INSTRUCTION ENABLE FROM CONTROL
	input logic UJ_EN_i,//UJ TYPE INSTRUCTION ENABLE FROM CONTROL
	output logic [4:0] RS1_o,
	output logic [4:0] RS2_o,
	output logic [4:0] RD_o,
	output logic [4:0] opcode_o,
	output logic [2:0] func3_o,
	output logic func7_o,
	output logic [31:0] immed_o
    );
    
    always_comb begin 
     opcode_o = instr_i[6:2] ;
     func7_o = instr_i[30];
     

    	if (BE_i) begin
    	    immed_o = 32'd0; 
    		immed_o[12:0] = {instr_i[31],instr_i[7],instr_i[30:25],instr_i[11:8],1'b0};
    	 end
        else if (UJE_i) begin
            immed_o = 32'd0;
    		immed_o[20:0] = {instr_i[31],instr_i[19:12],instr_i[20],instr_i[30:21],1'b0}; 
    	 end
    	else if (JALRE_i) begin // if Jump and link enable then PC = R[rs1] + immediate ,R[rd] = PC + 4
    		immed_o = 32'd0;
    		immed_o[12:0] = {instr_i[31:20],1'b0};
    	 end

        if (R_EN_i) begin
     	 RD_o    = instr_i[11:7];
     	 func3_o = instr_i[14:12];
     	 RS1_o   = instr_i[19:15];
     	 RS2_o   = instr_i[24:20];
         end
        else if (I_EN_i==1) begin
     	 RD_o    = instr_i[11:7];
     	 func3_o = instr_i[14:12];
     	 RS1_o   = instr_i[19:15];
     	 immediate_o[11:0]=instr_i[31:20];
         end
        else if (S_EN_i==1) begin
     	 func3_o = instr_i[14:12];
     	 RS1_o   = instr_i[19:15];
     	 RS2_o   = instr_i[24:20];
     	 immediate_o[11:0]={instr_i[31:25],instr_i[4:0]};
         end
        else if (SB_EN_i==1) begin
     	 func3_o = instr_i[14:12];
     	 RS1_o   = instr_i[19:15];
     	 RS2_o   = instr_i[24:20];
     	 immediate_o[11:0]={instr_i[31],instr_i[7],instr_i[30:25],instr_i[11:8]};
         end
        else if (U_EN_i==1) begin
     	 RD_o   = instr_i[11:7];
     	 immediate_o[19:0]=instr_i[31:12];
     	 end
        else if (UJ_EN_i==1) begin
         RD_o   = instr_i[11:7];
         immediate_o[19:0]={instr_i[31],instr_i[19:12],instr_i[20],instr_i[30:21]};
         end

     end

 endmodule

module FETCH_UNIT 
    (
	 input clk_i,    // Clock INPUT FROM TOP
	 input PCrst_i,  // Asynchronous reset active low INPUT FROM TEST
	 output logic [31:0] PC_o,instr_o,//Program Counter Register 32 bit
	 input logic [31:0] instrMEM_i [1048576],//INSTRUCTION MEMORY ARRAY INPUT FROM INSTRUCTION_MEM 20 bit adress
	 input logic BE_i,//BRANCH ENABLE SIGNAL FROM CONTROL
	 input logic JALRE_i,//JUMP AND LINK ENABLE SIGNAL FROM CONTROL UNIT
	 input logic UJE_i,//UJ ENABLE SIGNAL FROM CONTROL UNIT
	 output logic [31:0] REGD_o,//OUTPUT TO REG_FILE TO WRITE ON DESTINATION
	 input logic [31:0] REG1_i//INPUT FROM REG_FILE TO ADD WITH IMMEDIATE IN JALR INSTRUCTION
    );
    timeunit 1ns; timeprecision 1ns;

    always_ff @(posedge clk_i or negedge PCrst_i) begin
     instr_o <= instrMEM_i[PC_o[21:2]];

    	if(~PCrst_i) begin  //reset condition
    		PC_o <= 32'd0;
            instr_o <= instrMEM_i[PC_o[21:2]];
    	 end 
    	else if(~JALRE_i && ~BE_i) begin  // increment of counter on normal instructions
    		PC_o <= PC_o + 32'd4;
    	 end

    	else if (BE_i) begin     // if Branch enable then PC = PC + immediate
    		PC_o <= PC_o + {instr_i[31],instr_i[7],instr_i[30:25],instr_i[11:8],1'b0};
    	 end
        else if (UJE_i) begin    // if UJ enable then PC = PC + immediate ,R[rd] = PC + 4
    		PC_o <= PC_o + {instr_i[31],instr_i[19:12],instr_i[20],instr_i[30:21],1'b0}; 
    		REGD_o <= PC_o + 32'd4;
    	 end
    	else if (JALRE_i) begin // if Jump and link enable then PC = R[rs1] + immediate ,R[rd] = PC + 4
    		PC_o <= REG1_i + {instr_i[31:20],1'b0};
    		REGD_o <= PC_o + 32'd4 ;
    	 end


     end

 endmodule : FETCH_UNIT






