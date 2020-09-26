module INSTRUCTION_MEM (
	input clk_i,    // Clock
	input logic [31:0] address_i,//PC input from FETCH UNIT
	output logic [31:0] DATA_o,//
	input logic IWR_EN_i,
	input logic IR_EN_i,
    input logic [31:0] DATA_i
 );
 parameter NENTRIES = 128;
 logic [31:0] mem [0:NENTRIES-1];

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
     DATA_o = mem[address_i[21:2]];
        
     end 

 endmodule : INSTRUCTION_MEM