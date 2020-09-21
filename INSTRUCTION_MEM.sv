module INSTRUCTION_MEM (
	input clk_i,    // Clock
	input logic [31:0] address_i,//PC input from FETCH UNIT
	output logic [31:0] DATA_o,//
	input logic IR_EN_i,
	input logic IWR_EN_i,
    input logic [31:0] DATA_i
 );
 parameter NENTRIES = 128;
 parameter DATA = "FILENAME.txt";
 logic [31:0] mem [0:NENTRIES-1];

    initial begin

        $display("\nINITIALIZING INSTRUCTION MEMORY....",);
        $readmemh("DATA",mem);

        if (IWR_EN_i==1'b1) begin
 	     mem[address_i[21:2]]<=DATA_i;
         end
        if (IR_EN_i==1'b1) begin
 	     DATA_o <=mem[address_i[21:2]];
         end
     end 

 endmodule