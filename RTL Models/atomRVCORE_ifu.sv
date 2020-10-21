timeunit 1ns; timeprecision 1ns;
module atomRVCORE_ifu #(
  parameter DATAWIDTH=32 
	)
    
   (

     input clk_i,    // Clock INPUT FROM TOP
	 output logic [DATAWIDTH-1:0] PC_instr_o,//Program Counter Register 32 bit
	 input logic BE_i,//BRANCH ENABLE SIGNAL FROM CONTROL
	 input logic JALRE_i,//JUMP AND LINK ENABLE SIGNAL FROM CONTROL UNIT
	 input logic UJE_i,//UJ ENABLE SIGNAL FROM CONTROL UNIT
	 output logic [DATAWIDTH-1:0] RGD_o,//OUTPUT TO REG_FILE TO WRITE ON DESTINATION
	 input logic [DATAWIDTH-1:0] R1_i,//INPUT FROM REG_FILE TO ADD WITH IMMEDIATE IN JALR INSTRUCTION
     input logic [DATAWIDTH-1:0] immed_i,
     input logic PCrst_i,
     input logic U_EN_i,
     input logic LUI_EN_i 
     );

     logic [DATAWIDTH-1:0] JAL_pc;
     logic [DATAWIDTH-1:0] JALRE_pc;
     logic [DATAWIDTH-1:0] PC;

    initial begin

     PC=32'd0;


     end

    always @(posedge clk_i or negedge PCrst_i) begin

    	if(PCrst_i==1'b0) begin  //reset condition
    		PC <= 32'd0;
     	 end 
     	 
        if(JALRE_i!=1'b1 && BE_i!=1'b1 && UJE_i!=1'b1) begin  // increment of counter on normal instructions
    		PC <= PC + 32'd4;
    	 end

    	else if (BE_i==1'b1) begin     // if Branch enable then PC = PC + immediate
    		PC <= JAL_pc;
    	 end
        else if (UJE_i==1'b1) begin    // if UJ enable then PC = PC + immediate ,R[rd] = PC + 4
    		PC <= JAL_pc;
    	 end
    	else if (JALRE_i==1'b1) begin // if Jump and link enable then PC = R[rs1] + immediate ,R[rd] = PC + 4
    		PC <= JALRE_pc;
    	 end


     end
     assign JALRE_pc=R1_i+immed_i;
     assign PC_instr_o = PC;

     assign JAL_pc=PC+{immed_i[30:0],1'd0};

      assign RGD_o = ((UJE_i==1'b1))? PC + 32'd4:
                     ((U_EN_i==1'b1))? PC + {immed_i[19:0],12'd0}:
                     ((LUI_EN_i==1'b1))? 32'd0 + {immed_i[19:0],12'd0}:0;

endmodule
