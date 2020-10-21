timeunit 1ns; timeprecision 1ns;
module atomRVCORE_dccm #(
    parameter DATAWIDTH=32,
    parameter ADDRESS_BUS=10
	)
	(
	input clk_i,    // Clock
	input logic [DATAWIDTH-1:0] address_i,
	output logic [DATAWIDTH-1:0] DT_o,//
	input logic DWR_EN_i,
	input logic DR_EN_i,
    input logic [DATAWIDTH-1:0] DT_i
);
	localparam NENTRIES=2**ADDRESS_BUS;
	logic [DATAWIDTH-1:0] Dmem [0:NENTRIES-1];

    always @(posedge clk_i) begin

        if(DWR_EN_i==1'b1) begin
         Dmem[{address_i[DATAWIDTH-3:2],2'd0}] <= DT_i;
         end


     end	
   
    always @(*) begin

     if(DR_EN_i==1'b1)
     DT_o = Dmem[{address_i[DATAWIDTH-3:2],2'd0}];
        
     end 


endmodule : atomRVCORE_dccm