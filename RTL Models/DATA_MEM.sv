module DATA_MEM (
	input clk_i,    // Clock
	input logic [31:0] address_i,
	output logic [31:0] DT_o,//
	input logic DWR_EN_i,
	input logic DR_EN_i,
    input logic [31:0] DT_i
 );
 parameter NENTRIES = 256;
 logic [31:0] Dmem [0:NENTRIES-1];

    always @(posedge clk_i) begin

        if(DWR_EN_i==1'b1) begin
         Dmem[{address_i[29:2],2'd0}] <= DT_i;
         end


     end	
   
    always @(*) begin

     if(DR_EN_i==1'b1)
     DT_o = Dmem[{address_i[29:2],2'd0}];
        
     end 

 endmodule : DATA_MEM