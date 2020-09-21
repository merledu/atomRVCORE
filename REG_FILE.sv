
module REG_FILE (
	input clk_i,    // Clock
	input regrst_i,  // Asynchronous reset active low
	input logic [4:0] RS1_i,
	input logic [4:0] RS2_i,
	input logic [4:0] RD_i,
	output logic [31:0] R1_o,
	output logic [31:0] R2_o,
	input logic [31:0] WR_i,
	input logic RWR_EN_i,
	input logic RR_EN_i,
	      logic [31:0] R [32]
 );

 always_ff @(posedge clk_i or negedge regrst_i) begin
	    
	    if(~regrst_i) begin
		  
		    for (int i = 0; i < 32; i++) begin
		     R[i] <= 32'd0;
		     end
	
	     end 
	    else begin
		 R[0] <=32'd0;
		     if (RWR_EN_i == 1'b1 && RD_i != 5'b00000) begin

		     	R[RD_i] <= WR_i;

		     end

		     
		  R1_o <= R[RS1_i];
		  R2_o <= R[RS2_i]; 
		    

	     end

     end

 endmodule : REG_FILE