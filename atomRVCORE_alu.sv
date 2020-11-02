timeunit 1ns; timeprecision 1ns;
module atomRVCORE_alu #(
 parameter DATAWIDTH=32,
 parameter OPCODE_WIDTH=6,
 parameter MAX_SHIFT=5,
 parameter REG_ADRESS_WIDTH=5  
	)
    ( 
	 input clk_i,
     input logic [OPCODE_WIDTH-1:0] ALUop_i,//opcode to identify the instructions
     input logic [DATAWIDTH-1:0] PC_i,
     input logic [DATAWIDTH-1:0] immed_i,
	 input logic [DATAWIDTH-1:0] operand_A,
	 input logic [DATAWIDTH-1:0] operand_B,
     input logic [DATAWIDTH-1:0] address_i,//32 output from decode input to data memory
     input logic DR_EN_i,//Data read enable signal to DATA memory
     input logic DWR_EN_i,//Data write enable signal to data memory
     input logic [REG_ADRESS_WIDTH-1:0] RD_i,
     input logic RWR_EN_i,
     input logic [DATAWIDTH-1:0] R2_i,
     input logic UJE_i,
     input logic JALRE_i,
     input logic U_EN_i,
     input logic [REG_ADRESS_WIDTH-1:0] RD_m_i,
     input logic [REG_ADRESS_WIDTH-1:0] RD_wb_i,
     input logic [REG_ADRESS_WIDTH-1:0] RS1_i,
     input logic [REG_ADRESS_WIDTH-1:0] RS2_i,
     input logic LUI_EN_i,
     input logic SB_EN_i,
	 output logic [DATAWIDTH-1:0] result_o,
     output logic [DATAWIDTH-1:0] address_o,//32 output from decode input to data memory
     output logic DR_EN_o,//Data read enable signal to DATA memory
     output logic DWR_EN_o,//Data write enable signal to data memory
     output logic [DATAWIDTH-1:0] PC_o,
     output logic [REG_ADRESS_WIDTH-1:0] RD_o,
     output logic RWR_EN_o,
     output logic [DATAWIDTH-1:0] R2_o,
     output logic BE_o,
     output logic [1:0] fwd1_o,
     output logic [1:0] fwd2_o 
	
     );

    logic [DATAWIDTH-1:0] result;
    logic [MAX_SHIFT-1:0] shamt;
    logic [DATAWIDTH-1:0] PC;
    logic JALRE_pc;
    logic JAL_pc;
    logic BE;




 always_comb begin
        if (BE==1'b1 || UJE_i==1'b1) begin     // if Branch enable then PC = PC + immediate
            PC <= JAL_pc;
         end
        else if (JALRE_i==1'b1) begin // if Jump and link enable then PC = R[rs1] + immediate ,R[rd] = PC + 4
            PC <= JALRE_pc;
         end


          if(RS1_i==RD_m_i) begin  
          fwd1_o=2'd1;
          end
          else if(RS2_i==RD_m_i) begin
          fwd2_o=2'd1;
          end
          else if(RS1_i==RD_wb_i) begin  
          fwd1_o=2'd2;
          end
          else if(RS2_i==RD_wb_i) begin
          fwd2_o=2'd2;
          end
          else
          fwd2_o = 2'd0;
          fwd1_o = 2'd0;




     end
    assign JALRE_pc=operand_A+immed_i;

    assign JAL_pc=PC_i+{immed_i[30:0],1'd0};

    always_comb begin 





        assign shamt = operand_B[MAX_SHIFT-1:0];
       result = 

            (ALUop_i == 6'b000_001)? operand_A + operand_B:                //ADDI,ADDIW,ADD

            (ALUop_i == 6'b000_010)? operand_A << shamt:                   //SLLI,SLLIW 

            (ALUop_i == 6'b000_011)? {31'b0,operand_A < operand_B}:        //SLTI 

            (ALUop_i == 6'b000_100)? {31'b0,operand_A < operand_B}:        //SLTIU

            (ALUop_i == 6'b000_101)? operand_A ^ operand_B:                //XORI,XOR

            (ALUop_i == 6'b000_110)? operand_A >> shamt:                   //SRLI,SRLIW

            (ALUop_i == 6'b000_111)? operand_A >> shamt:                   //SRAI,SRAIW

            (ALUop_i == 6'b001_000)? operand_A | operand_B:                //ORI,OR

            (ALUop_i == 6'b001_001)? operand_A & operand_B:                // AND, ANDI

            (ALUop_i == 6'b001_010)? operand_A - operand_B:                // SUB h

            (ALUop_i == 6'b010_001)? operand_A:                            // operand_A = PC+4 for JAL

            (ALUop_i == 6'b001_011)? {31'b0,$signed(operand_A) == $signed(operand_B)}:             // BEQ 

            (ALUop_i == 6'b001_100)? {31'b0,$signed(operand_A) != $signed(operand_B)}:             // BNE

            (ALUop_i == 6'b001_101)? {31'b0,$signed(operand_A) < $signed(operand_B)}:              // BLT

            (ALUop_i == 6'b001_110)? {31'b0,$signed(operand_A) >= $signed(operand_B)}:             // BGE

            (ALUop_i == 6'b001_111)? {31'b0,$unsigned(operand_A) < $unsigned(operand_B)}:              // BLTU

            (ALUop_i == 6'b010_000)? {31'b0,$unsigned(operand_A) >= $unsigned(operand_B)}:
            
            (UJE_i==1'b1)? PC_i + 32'd4:
            
            (U_EN_i==1'b1)? PC_i + {immed_i[19:0],12'd0}:
            
            (LUI_EN_i==1'b1)? 32'd0 + {immed_i[19:0],12'd0}: 32'd0;         

  



     end

      assign BE     = (result == 32'd1 && SB_EN_i==1'b1 )?  1'b1 : 1'b0; 

    always_ff @(posedge clk_i) begin
    result_o<=result;
    address_o<=address_i;
    RWR_EN_o<=RWR_EN_i;
    RD_o<=RD_i;
    DR_EN_o<=DR_EN_i;
    DWR_EN_o<=DWR_EN_i;
    R2_o<=R2_i;
    PC_o<=PC;
    BE_o<=BE;

    end

endmodule : atomRVCORE_alu
