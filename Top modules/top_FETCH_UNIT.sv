timeunit 1ns; timeprecision 1ns;
module top_FETCH_UNIT ();
	logic clk_o;    // Clock
	logic PCrst_tb;
    logic [31:0] PC_instr_tb;
	logic BE_tb;
	logic JALRE_tb;
	logic UJE_tb;
	logic [31:0] RD_tb;
	logic [31:0] R1_tb;
    logic [31:0] immed_tb;
	


 FETCH_UNIT dut( .clk_i(clk_o), .PCrst_i(PCrst_tb), .PC_instr_o(PC_instr_tb), .BE_i(BE_tb), .JALRE_i(JALRE_tb), .UJE_i(UJE_tb), .RD_o(RD_tb), .R1_i(R1_tb), .immed_i(immed_tb) );
 tb_FETCH_UNIT test( .clk_i(clk_o), .PCrst_o(PCrst_tb), .PC_instr_i(PC_instr_tb), .BE_o(BE_tb), .JALRE_o(JALRE_tb), .UJE_o(UJE_tb), .RD_i(RD_tb), .R1_o(R1_tb), .immed_o(immed_tb) );


	initial begin

     clk_o <= 0;
     forever #10 clk_o = ~clk_o;

     end

endmodule : top_FETCH_UNIT