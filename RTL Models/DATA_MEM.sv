
module DATA_MEM (
	input clk_i,    // Clock
	input logic [31:0] address_i,//input address to read or write
	output logic [31:0] DATA_o,//
	input logic DWR_EN_i,
    input logic [31:0] DATA_i,
          logic [31:0] M [256],
    input logic DMrst_i,
    input logic DR_EN_i
 );
 
 

    always_ff @(posedge clk_i or negedge DMrst_i) begin
	    
	    if(~DMrst_i) begin
		  
		    for (int i = 0; i < 256; i++) begin
		     M[i] <= 32'd0;
		     end
	
	     end 
	    
	    else begin
		     if (DWR_EN_i == 1'b1 ) begin

		     	M[address_i] <= DATA_i;

		     end

		    else if (DR_EN_i == 1'b1) begin
		    	DATA_o <= M[address_i];

		     end
		   
		    

	     end

     end



 endmodule