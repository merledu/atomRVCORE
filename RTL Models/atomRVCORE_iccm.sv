timeunit 1ns; timeprecision 1ns;
module atomRVCORE_iccm #(
   parameter DATAWIDTH=32,
   parameter ADRESS_BUS=20
	)
    (
    input clk_i,    // Clock
	input logic [DATAWIDTH-1:0] address_i,//PC input from FETCH UNIT
	output logic [DATAWIDTH-1:0] DATA_o,//
	input logic IWR_EN_i,
	input logic IR_EN_i,
    input logic [DATAWIDTH-1:0] DATA_i

     );
    localparam NENTRIES=2**ADRESS_BUS;
    logic [DATAWIDTH-1:0] mem [0:NENTRIES-1];

    initial begin

        $display("\nINITIALIZING INSTRUCTION MEMORY....",);
        $readmemh("instructions.mem",mem);

       
     end 
    always @(posedge clk_i) begin

        if(IWR_EN_i==1'b1) begin
         mem[address_i] <= DATA_i;
         end


     end
   
    always @(*) begin

     if(IR_EN_i==1'b1)
     DATA_o = mem[address_i[ADRESS_BUS+1:2]];
        
     end 

 endmodule : atomRVCORE_iccm