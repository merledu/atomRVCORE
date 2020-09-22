module FETCH_UNIT 
    (
	 input clk_i,    // Clock INPUT FROM TOP
	 input PCrst_i,  // Asynchronous reset active low INPUT FROM TEST
	 output logic [31:0] PC_o,//Program Counter Register 32 bit
	 input logic BE_i,//BRANCH ENABLE SIGNAL FROM CONTROL
	 input logic JALRE_i,//JUMP AND LINK ENABLE SIGNAL FROM CONTROL UNIT
	 input logic UJE_i,//UJ ENABLE SIGNAL FROM CONTROL UNIT
	 output logic [31:0] REGD_o,//OUTPUT TO REG_FILE TO WRITE ON DESTINATION
	 input logic [31:0] REG1_i,//INPUT FROM REG_FILE TO ADD WITH IMMEDIATE IN JALR INSTRUCTION
     input logic [31:0] immed_i
    );
    timeunit 1ns; timeprecision 1ns;

    always_ff @(posedge clk_i or negedge PCrst_i) begin

    	if(~PCrst_i) begin  //reset condition
    		PC_o <= 32'd0;
    	 end 
    	else if(~JALRE_i && ~BE_i && ~UJE_i) begin  // increment of counter on normal instructions
    		PC_o <= PC_o + 32'd4;
    	 end

    	else if (BE_i) begin     // if Branch enable then PC = PC + immediate
    		PC_o <= PC_o + {immed_i[30:0],1'b0};
    	 end
        else if (UJE_i) begin    // if UJ enable then PC = PC + immediate ,R[rd] = PC + 4
    		PC_o <= PC_o +  {immed_i[30:0],1'b0};
    		REGD_o <= PC_o + 32'd4;
    	 end
    	else if (JALRE_i) begin // if Jump and link enable then PC = R[rs1] + immediate ,R[rd] = PC + 4
    		PC_o <= REG1_i + immed_i;
    		REGD_o <= PC_o + 32'd4 ;
    	 end


     end

 endmodule : FETCH_UNIT
