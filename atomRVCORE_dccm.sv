timeunit 1ns; timeprecision 1ns;
module atomRVCORE_dccm #(
    parameter DATAWIDTH=32,
    parameter ADDRESS_BUS=10,
    parameter REG_ADRESS_WIDTH=5
	)
	(
	input clk_i,    // Clock
	input logic [DATAWIDTH-1:0] address_i,
	output logic [DATAWIDTH-1:0] DT_o,//
	input logic DWR_EN_i,
	input logic DR_EN_i,
    input logic [DATAWIDTH-1:0] DT_i,
    input logic RWR_EN_i,
    input logic [REG_ADRESS_WIDTH-1:0] RD_i,
    input logic [DATAWIDTH-1:0] WR_i,
    output logic RWR_EN_o,
    output logic [REG_ADRESS_WIDTH-1:0] RD_o,
    output logic [DATAWIDTH-1:0] WR_o

);

    logic EN;
	localparam NENTRIES=2**ADDRESS_BUS;
	logic [DATAWIDTH-1:0] Dmem [0:NENTRIES-1];

    always @(posedge clk_i) begin

        if(DWR_EN_i==1'b1) begin
         Dmem[{address_i[DATAWIDTH-3:2],2'd0}] <= DT_i;
         end


     end	

     always_comb begin 
        if(RWR_EN_i==1'b1)
            EN=1'b1;
     
     end
   
    always @(*) begin

     if(DR_EN_i==1'b1)
     DT_o = Dmem[{address_i[DATAWIDTH-3:2],2'd0}];
        
     end 

     always_ff @(posedge clk_i) begin

        RWR_EN_o<=EN;
        RD_o<=RD_i;
        WR_o<=WR_i;



 
     end


endmodule : atomRVCORE_dccm