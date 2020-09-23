module top_REG_FILE ();
	timeunit 1ns; timeprecision 1ns;
    logic clk_o;
    logic regrst_tb;  // Asynchronous reset active low
    logic [4:0] RS1_tb;
    logic [4:0] RS2_tb;
    logic [4:0] RD_tb;
    logic [31:0] R1_tb;
    logic [31:0] R2_tb;
    logic [31:0] WR_tb;
    logic RWR_EN_tb;


	REG_FILE dut( .clk_i(clk_o), .regrst_i(regrst_tb), .RS1_i(RS1_tb), .RS2_i(RS2_tb), .RD_i(RD_tb), .R1_o(R1_tb), .R2_o(R2_tb), .WR_i(WR_tb), .RWR_EN_i(RWR_EN_tb) );
    tb_REG_FILE test( .clk_i(clk_o), .regrst_o(regrst_tb), .RS1_o(RS1_tb), .RS2_o(RS2_tb), .RD_o(RD_tb), .R1_i(R1_tb), .R2_i(R2_tb), .WR_o(WR_tb), .RWR_EN_o(RWR_EN_tb) );
  
    initial begin

     clk_o <= 0;
     forever #10 clk_o = ~clk_o;

     end

endmodule : top_REG_FILE


