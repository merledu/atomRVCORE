timeunit 1ns; timeprecision 1ns;
module FETCH_UNIT 
    (
	 input clk_i,    // Clock INPUT FROM TOP
	 output logic [31:0] PC_instr_o,//Program Counter Register 32 bit
	 input logic BE_i,//BRANCH ENABLE SIGNAL FROM CONTROL
	 input logic JALRE_i,//JUMP AND LINK ENABLE SIGNAL FROM CONTROL UNIT
	 input logic UJE_i,//UJ ENABLE SIGNAL FROM CONTROL UNIT
	 output logic [31:0] RGD_o,//OUTPUT TO REG_FILE TO WRITE ON DESTINATION
	 input logic [31:0] R1_i,//INPUT FROM REG_FILE TO ADD WITH IMMEDIATE IN JALR INSTRUCTION
     input logic [31:0] immed_i
    );
    
     logic [31:0] PC;

    initial begin

     PC=32'd0;


     end

    always @(posedge clk_i) begin

    //	if(PCrst_i==1'b0) begin  //reset condition
    //		PC <= 32'd0;
    //	 end 
        if(JALRE_i!=1'b1 && BE_i!=1'b1 && UJE_i!=1'b1) begin  // increment of counter on normal instructions
    		PC <= PC + 32'd4;
    	 end

    	else if (BE_i==1'b1) begin     // if Branch enable then PC = PC + immediate
    		PC <= PC + {immed_i[30:0],1'b0};
    	 end
        else if (UJE_i==1'b1) begin    // if UJ enable then PC = PC + immediate ,R[rd] = PC + 4
    		PC <= PC +  {immed_i[30:0],1'b0};
    		RGD_o <= PC + 32'd4;
    	 end
    	else if (JALRE_i==1'b1) begin // if Jump and link enable then PC = R[rs1] + immediate ,R[rd] = PC + 4
    		PC <= R1_i + immed_i;
    		RGD_o <= PC + 32'd4 ;
    	 end


     end

     assign PC_instr_o = PC;

 endmodule : FETCH_UNIT
