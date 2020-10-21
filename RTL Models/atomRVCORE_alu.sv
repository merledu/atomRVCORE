timeunit 1ns; timeprecision 1ns;
module atomRVCORE_alu #(
 parameter DATAWIDTH=32,
 parameter OPCODE_WIDTH=6,
 parameter MAX_SHIFT=5  
	)
    ( 
	input logic [OPCODE_WIDTH-1:0] ALUop_i,//opcode to identify the instructions
	input logic [DATAWIDTH-1:0] operand_A,
	input logic [DATAWIDTH-1:0] operand_B,
	output logic [DATAWIDTH-1:0] result_o
	
     );
    logic [MAX_SHIFT-1:0] shamt;

    always_comb begin 
        assign shamt = operand_B[MAX_SHIFT-1:0];
        result_o = 

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

            (ALUop_i == 6'b010_000)? {31'b0,$unsigned(operand_A) >= $unsigned(operand_B)}: 32'b0;          // BGEU 

  



     end

endmodule : atomRVCORE_alu
