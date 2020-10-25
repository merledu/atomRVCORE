timeunit 1ns; timeprecision 1ns;
module atomRVCORE_ifu #(
  parameter DATAWIDTH=32 
	)
    
   (

     input clk_i,    // Clock INPUT FROM TOP
	 output logic [DATAWIDTH-1:0] PC_instr_o,//Program Counter Register 32 bit
	 input logic BE_i,//BRANCH ENABLE SIGNAL FROM CONTROL
     input logic PCrst_i,
     input logic [DATAWIDTH-1:0] PC_i,
     input logic [DATAWIDTH-1:0] instruction_i,
     output logic [DATAWIDTH-1:0] instruction_o
     );

     logic [DATAWIDTH-1:0] PC;

    initial begin

     PC=32'd0;


     end

    always @(posedge clk_i or negedge PCrst_i) begin

    	if(PCrst_i==1'b0) begin  //reset condition
    		PC <= 32'd0;
     	 end 
     	 

    	else if (BE_i==1'b1) begin     // if Branch enable then PC = PC + immediate
    		PC <= PC_i;
    	 end
    	 else
    	 	PC <= PC + 32'd4;


     end
                   always_ff @(posedge clk_i) begin
                    PC_instr_o<=PC;
                    instruction_o<=instruction_i;
                   end


endmodule
