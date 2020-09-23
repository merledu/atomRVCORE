module top_alu ();
	timeunit 1ns; timeprecision 1ns;
    logic clk_o;
	logic [5:0] ALUop_tb;
	logic [31:0] operand_A_tb;
	logic [31:0] operand_B_tb;
	logic [31:0] result_tb;
	logic [4:0] shamt_tb;
	ALU dut( .clk_i(clk_o), .ALUop_i(ALUop_tb), .operand_A(operand_A_tb), .operand_B(operand_B_tb), .result_o(result_tb), .shamt(shamt_tb));
    tb_ALU test( .clk_i(clk_o), .ALUop_o(ALUop_tb), .operand_A(operand_A_tb), .operand_B(operand_B_tb), .result_i(result_tb));
  
    initial begin

     clk_o <= 0;
     forever #10 clk_o = ~clk_o;

     end

endmodule : top_alu

