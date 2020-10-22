timeunit 1ns; timeprecision 1ns;
module atomRVCORE_reg_file #(

 parameter DATAWIDTH=32,
 parameter REGISTERS=32,
 parameter REG_ADRESS_WIDTH=5
	)
    ( 
    input clk_i,    // Clock
	input regrst_i,  // Asynchronous reset active HIGH
	input logic [REG_ADRESS_WIDTH-1:0] RS1_i,
	input logic [REG_ADRESS_WIDTH-1:0] RS2_i,
	input logic [REG_ADRESS_WIDTH-1:0] RD_i,
	output logic [DATAWIDTH-1:0] R1_o,
	output logic [DATAWIDTH-1:0] R2_o,
	input logic [DATAWIDTH-1:0] WR_i,
	input logic RWR_EN_i,
    input logic JALRE_i,
    input logic [DATAWIDTH-1:0] RGD_i,
    input logic [DATAWIDTH-1:0] lb_i,
    input logic DR_EN_i,
    input logic U_EN_i,
    input logic LUI_EN_i

	
     );

    logic [DATAWIDTH-1:0] R [0:REGISTERS-1];
integer i;

initial begin

    for (i=0;i<REGISTERS;i++)begin

     R[i] = 0;

     end

end

always @ (posedge clk_i)begin

    if (regrst_i==1'b1) begin

        for (i=0;i<REGISTERS;i++)

            R[i]<=0;

        end

    else if (regrst_i==1'b0 && RWR_EN_i==1'b1)begin

            if (RD_i==5'd0)

                R[0]<=32'd0;

            else

               if (JALRE_i==1'b1 || U_EN_i==1'b1 || LUI_EN_i == 1'b1)
                R[RD_i]<=RGD_i;
               else if (DR_EN_i==1'b1)
                R[RD_i]<=lb_i;
                else
                 R[RD_i]<=WR_i;       

        end

end

assign R1_o = R[RS1_i];

assign R2_o = R[RS2_i];


 endmodule :atomRVCORE_reg_file