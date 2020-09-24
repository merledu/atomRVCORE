module top_INSTRUCTION_MEM ();

    logic clk_o;    // Clock
    logic [31:0] address_tb;
	logic [31:0] DATAi_tb;//
	logic IWR_EN_tb;
	logic IR_EN_tb;
    logic [31:0] DATAo_tb;
   
   INSTRUCTION_MEM dut(.clk_i(clk_o), .address_i(address_tb), .DATA_o(DATAo_tb), .DATA_i(DATAi_tb), .IWR_EN_i(IWR_EN_tb), .IR_EN_i(IR_EN_tb) );
   tb_INSTRUCTION_MEM test(.clk_i(clk_o),.address_o(address_tb), .DATA_i(DATAo_tb), .DATA_o(DATAi_tb), .IWR_EN_o(IWR_EN_tb), .IR_EN_o(IR_EN_tb) );

    initial begin

     clk_o <= 0;
     forever #10 clk_o = ~clk_o;

     end

 endmodule
