module tb_INSTRUCTION_MEM 
	(
	 input clk_i,    // Clock
	 output logic [31:0] address_o,//PC input from FETCH UNIT
	 input logic [31:0] DATA_i,//
	 output logic IWR_EN_o,
	 output logic IR_EN_o,
     output logic [31:0] DATA_o
	
     );

    initial begin
     IWR_EN_o=1'b0;
     IR_EN_o=1'b1;
     address_o=32'd0;
     @(posedge clk_i);
     address_o=32'd4;
     @(posedge clk_i);
     address_o=32'd8;
     @(posedge clk_i);
     address_o=32'd12;
     @(posedge clk_i);
     address_o=32'd16;
     @(posedge clk_i);
     address_o=32'd20;


     end

 endmodule
