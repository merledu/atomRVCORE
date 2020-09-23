module tb_ALU (
	input clk_i,    // Clock
	output logic [5:0] ALUop_o,//opcode to identify the instructions
	output logic [31:0] operand_A,
	output logic [31:0] operand_B,
	input logic [31:0] result_i

   );
  timeunit 1ns; timeprecision 1ns;
    initial begin


     operand_A = 32'd200;
     operand_B = 32'd14;
     ALUop_o = 6'b000_000;


     #10ns operand_A = 32'd200;
     operand_B = 32'd14;
     ALUop_o = 6'b000_001;
     
    
     #10ns operand_A = 32'd200;
     operand_B = 32'd14;
      ALUop_o = 6'b000_010;
     
    
     #10ns operand_A = 32'd200;
     operand_B = 32'd14;
      ALUop_o = 6'b000_011;
     
      
     #10ns operand_A = 32'd200;
     operand_B = 32'd14;
      ALUop_o = 6'b000_100;
     


     end 
endmodule
