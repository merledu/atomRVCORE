module ALU (
	input clk_i,    // Clock
	input alu_rst_i,  // Asynchronous reset active low
	input logic [5:0] ALUop_i,//opcode to identif the instructions
	input logic [31:0] operand_A,
	input logic [31:0] operand_B,
	output logic [31:0] result_o,
	       logic [4:0] shamt
	);

  always_comb begin 
        assign shamt = operand_B[4:0];
        result_o = 

            (ALUop_i == 6'b000_000)? operand_A + operand_B:                //ADDI,ADDIW

            (ALUop_i == 6'b000_001)? operand_A << shamt:                   //SLLI,SLLIW 

            (ALUop_i == 6'b000_010)? {31'b0,operand_A < operand_B}:        //SLTI 

            (ALUop_i == 6'b000_011)? {31'b0,operand_A < operand_B}:        //SLTIU

            (ALUop_i == 6'b000_100)? operand_A ^ operand_B:                //XORI

            (ALUop_i == 6'b000_101)? operand_A >> shamt:                   //SRLI,SRLIW

            (ALUop_i == 6'b000_110)? operand_A >> shamt:                   //SRAI,SRAIW

            (ALUop_i == 6'b000_111)? operand_A | operand_B:                //ORI

            (ALUop_i == 6'b001_000)? operand_A & operand_B:                //ANDI

            (ALUop_i == 6'b001_001)? operand_A + operand_B: 32'd0;               //JALR PC = RS1+IMMED

            

  



     end


endmodule :ALU
