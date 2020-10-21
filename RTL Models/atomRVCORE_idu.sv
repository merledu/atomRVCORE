timeunit 1ns; timeprecision 1ns;
module atomRVCORE_idu #(
 parameter DATAWIDTH=32,
 parameter REG_ADRESS_WIDTH=5
	)
	(
	input logic [DATAWIDTH-1:0] instr_i,//32 BIT INSTRUCTION FROM INSTRUCTION MEM
	input logic I_EN_i,//I TYPE INSTRUCTION ENABLE FROM CONTROL
	input logic R_EN_i,//R TYPE INSTRUCTION ENABLE FROM CONTROL
	input logic S_EN_i,//S TYPE INSTRUCTION ENABLE FROM CONTROL
	input logic SB_EN_i,//SB TYPE INSTRUCTION ENABLE FROM CONTROL
	input logic U_EN_i,//U TYPE INSTRUCTION ENABLE FROM CONTROL
	input logic UJ_EN_i,//UJ TYPE INSTRUCTION ENABLE FROM CONTROL
	output logic [REG_ADRESS_WIDTH-1:0] RS1_o,
	output logic [REG_ADRESS_WIDTH-1:0] RS2_o,
	output logic [REG_ADRESS_WIDTH-1:0] RD_o,
	output logic [6:0] opcode_o,
	output logic [2:0] func3_o,
	output logic [6:0] func7_o,
	output logic [DATAWIDTH-1:0] immed_o,
    output logic [DATAWIDTH-1:0] address_o,
    input logic DR_EN_i,
    input logic [DATAWIDTH-1:0] R2_i,
    output logic [DATAWIDTH-1:0] operand_B_o,
    input logic DWR_EN_i,
    input logic [DATAWIDTH-1:0] R1_i
	
     );

	always_comb begin 
     opcode_o= instr_i[6:0] ;
     func7_o=7'd0;
      
        address_o=32'd0;


        if (R_EN_i==1'b1 && I_EN_i !=1'b1 && S_EN_i!=1'b1 && SB_EN_i != 1'b1 && U_EN_i!=1'b1 && UJ_EN_i != 1'b1) begin
     	 RD_o    = instr_i[11:7];
     	 func3_o = instr_i[14:12];
     	 RS1_o   = instr_i[19:15];
     	 RS2_o   = instr_i[24:20];
     	 func7_o =instr_i[31:25];
         end
        else if (I_EN_i==1'b1 && R_EN_i!=1'b1 && S_EN_i!=1'b1 && SB_EN_i != 1'b1 && U_EN_i!=1'b1 && UJ_EN_i != 1'b1) begin
     	 RD_o    = instr_i[11:7];
     	 func3_o = instr_i[14:12];
     	 RS1_o   = instr_i[19:15];
     	 func7_o =instr_i[31:25];
     	 immed_o = {{20{instr_i[31]}},instr_i[31:20]};
         end
        else if (I_EN_i!=1'b1 && R_EN_i!=1'b1 && S_EN_i==1'b1 && SB_EN_i != 1'b1 && U_EN_i!=1'b1 && UJ_EN_i != 1'b1) begin
     	 func3_o = instr_i[14:12];
     	 RS1_o   = instr_i[19:15];
     	 RS2_o   = instr_i[24:20];
     	 immed_o={{20{instr_i[31]}},instr_i[31:25],instr_i[11:7]};
         end
        else if (I_EN_i!=1'b1 && R_EN_i!=1'b1 && S_EN_i!=1'b1 && SB_EN_i == 1'b1 && U_EN_i!=1'b1 && UJ_EN_i != 1'b1) begin
     	 func3_o = instr_i[14:12];
     	 RS1_o   = instr_i[19:15];
     	 RS2_o   = instr_i[24:20];
     	 immed_o = {{20{instr_i[31]}},instr_i[31],instr_i[7],instr_i[30:25],instr_i[11:8]};

         end
        else if (I_EN_i!=1'b1 && R_EN_i!=1'b1 && S_EN_i!=1'b1 && SB_EN_i != 1'b1 && U_EN_i==1'b1 && UJ_EN_i != 1'b1) begin
     	 RD_o   = instr_i[11:7];
     	 immed_o={{12{instr_i[31]}},instr_i[31:12]};
     	 
     	 end
        else if (I_EN_i!=1'b1 && R_EN_i!=1'b1 && S_EN_i!=1'b1 && SB_EN_i != 1'b1 && U_EN_i!=1'b1 && UJ_EN_i == 1'b1) begin
         RD_o   = instr_i[11:7];
         immed_o = {{12{instr_i[31]}},instr_i[31],instr_i[19:12],instr_i[20],instr_i[30:21]};
         
         end

         else if (I_EN_i!=1'b1 && R_EN_i!=1'b1 && S_EN_i!=1'b1 && SB_EN_i != 1'b1 && U_EN_i!=1'b1 && UJ_EN_i != 1'b1 ) begin
             
         end
        else begin
    
          RD_o    = 5'd0;
         func3_o = 3'd0;
         RS1_o   = 5'd0;
         RS2_o   = 5'd0;
         func7_o =7'd0;  
         end

        if (DR_EN_i==1'b1 || DWR_EN_i)
        address_o=immed_o+R1_i;
        if (SB_EN_i == 1'b1 || R_EN_i == 1'b1)
            operand_B_o= R2_i;
        else
         operand_B_o =  immed_o;

     end

endmodule : atomRVCORE_idu
