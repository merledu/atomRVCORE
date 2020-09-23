timeunit 1ns; timeprecision 1ns;
module tb_FETCH_UNIT (
	input clk_i,    // Clock
	output logic PCrst_o,
	input logic [31:0] PC_instr_i,//Program Counter Register 32 bit
	output logic BE_o,//BRANCH ENABLE SIGNAL FROM CONTROL
	output logic JALRE_o,//JUMP AND LINK ENABLE SIGNAL FROM CONTROL UNIT
	output logic UJE_o,//UJ ENABLE SIGNAL FROM CONTROL UNIT
	input logic [31:0] RD_i,
	output logic [31:0] R1_o,
    output logic [31:0] immed_o

);
    initial begin
     @(posedge clk_i);
     PCrst_o=1'b1;
     JALRE_o = 1'b0;
     UJE_o = 1'b0;
     BE_o=1'b0;
     R1_o = 32'd0;
     immed_o = 32'd0;

     #80ns @(posedge clk_i);
     PCrst_o=1'b1;
     JALRE_o = 1'b1;
     UJE_o = 1'b0;
     BE_o=1'b0;
     R1_o = 32'd0;
     immed_o = 32'd0;

     @(posedge clk_i);
     PCrst_o=1'b1;
     JALRE_o = 1'b0;
     UJE_o = 1'b1;
     BE_o=1'b0;
     R1_o = 32'd10;
     immed_o = 32'd9;

     @(posedge clk_i);
     PCrst_o=1'b1;
     JALRE_o = 1'b0;
     UJE_o = 1'b0;
     BE_o=1'b1;
     R1_o = 32'd11;
     immed_o = 32'd7;

     @(posedge clk_i);
     PCrst_o=1'b1;
     JALRE_o = 1'b0;
     UJE_o = 1'b0;
     BE_o=1'b0;
     R1_o = 32'd12;
     immed_o = 32'd5;

     @(posedge clk_i);
     PCrst_o=1'b0;
     JALRE_o = 1'b0;
     UJE_o = 1'b0;
     BE_o=1'b0;
     R1_o = 32'd0;
     immed_o = 32'd0;




     end

endmodule