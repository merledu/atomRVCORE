module CONTROL 
	(
	 input logic [6:0] opcode_i,
	 input logic [2:0] func3_i,
	 input logic [6:0] func7_i,
	 output logic I_EN_o,//I TYPE INSTRUCTION ENABLE FROM CONTROL
     output logic R_EN_o,
	 output logic S_EN_o,//S TYPE INSTRUCTION ENABLE FROM CONTROL
	 output logic SB_EN_o,//SB TYPE INSTRUCTION ENABLE FROM CONTROL
	 output logic U_EN_o,//U TYPE INSTRUCTION ENABLE FROM CONTROL
	 output logic UJ_EN_o,//UJ TYPE INSTRUCTION ENABLE FROM CONTROL
	 output logic RWR_EN_o,//REG WRITE ENABLE FROM CONTROL
	 output logic BE_o,//BRANCH ENABLE SIGNAL FROM CONTROL TO
	 output logic JALRE_o,//JUMP AND LINK ENABLE SIGNAL FROM CONTROL UNIT FETCH
	 output logic UJE_o,//UJ ENABLE SIGNAL FROM CONTROL UNIT TO FETCH
	 output logic IWR_EN_o,//INSTRUCTION WRITE ENABLE SIGNAL TO WRITE ON INSTRUCTION MEM
	 output logic [5:0] ALUop_o,//ALU OPCODE SWITCH FOR OPERATION
     output logic IR_EN_o,
     output logic regrst_o,
     output logic PCrst_o,
     output logic DR_EN_o,
     output logic DWR_EN_o,
     input logic [31:0] result_i,
     input logic LUI_EN_o

     );

	always_comb begin 
        
	
	    IWR_EN_o=1'b0;
        IR_EN_o=1'b1;
        regrst_o=1'b0;
        PCrst_o=1'b1;
        
        end
      localparam    R_TYPE  = 7'b0110011, 

                    I_TYPE  = 7'b0010011, 

                    STORE   = 7'b0100011,

                    LOAD    = 7'b0000011,

                    BRANCH  = 7'b1100011,

                    JALR    = 7'b1100111,

                    JAL     = 7'b1101111;



    assign RWR_EN_o = ((opcode_i == R_TYPE) | (opcode_i == I_TYPE) | (opcode_i == LOAD)

                            | (opcode_i == JALR) | (opcode_i == JAL) )? 1'b1 : 1'b0; 

    assign DWR_EN_o = (opcode_i == STORE)?   1'b1 : 1'b0; 

    assign BE_o     = (result_i == 32'd1 && SB_EN_o==1'b1 )?  1'b1 : 1'b0; 

    assign DR_EN_o       = (opcode_i == LOAD)?    1'b1 : 1'b0; 

    assign I_EN_o   =   ((opcode_i == 7'b0000011) | (opcode_i == 7'b0010011)
                        |(opcode_i == 7'b0011011) | (opcode_i == 7'b1100111)
                        | (opcode_i == 7'b1110011)  )?  1'b1 : 1'b0;

    assign R_EN_o   =   ((opcode_i == 7'b0110011) | (opcode_i == 7'b0111011) )?  1'b1 : 1'b0;

    assign S_EN_o   =   ((opcode_i == 7'b0100011))?  1'b1 : 1'b0;

    assign SB_EN_o  =   ((opcode_i == 7'b1100011))?  1'b1 : 1'b0;

    assign U_EN_o   =   ((opcode_i == 7'b0110111))?  1'b1 : 1'b0;

    assign LUI_EN_o   =   ((opcode_i == 7'b0010111))?  1'b1 : 1'b0;

    assign UJ_EN_o  =   ((opcode_i == 7'b1101111))?  1'b1 : 1'b0;
    
    assign JALRE_o  =    (opcode_i == JALR)? 1'b1 : 1'b0;

    assign UJE_o    =   (opcode_i == JAL)? 1'b1 : 1'b0;

    assign ALUop_o  = ((opcode_i == 7'h13) && (func3_i == 3'h0 ) & (func7_i == 7'h0 )) ?  6'd1 :  //addi,add,addiw
                      ( (opcode_i == 7'h13) && (func3_i == 3'h1 ) && (func7_i == 7'h0 ) ) ?  6'd2 :
                      ( (opcode_i == 7'h13) && (func3_i == 3'h2 ) && (func7_i == 7'h0 ) ) ?  6'd3 :
                      ( (opcode_i == 7'h13) && (func3_i == 3'h3 ) && (func7_i == 7'h0 ) ) ?  6'd4 :
                      ( (opcode_i == 7'h13) && (func3_i == 3'h4 ) && (func7_i == 7'h0 ) ) ?  6'd5 :
                      ( (opcode_i == 7'h13) && (func3_i == 3'h5 ) && (func7_i == 7'h0 ) ) ?  6'd6 :
                      ( (opcode_i == 7'h13) && (func3_i == 3'h5 ) && (func7_i == 7'h20 ) ) ?  6'd7 :
                      ( (opcode_i == 7'h13) && (func3_i == 3'h6 ) && (func7_i == 7'h0 ) ) ?  6'd8 :
                      ( (opcode_i == 7'h13) && (func3_i == 3'h7 ) && (func7_i == 7'h0 ) ) ?  6'd9 :
                      ( (opcode_i == 7'h17) && (func3_i == 3'h0 ) && (func7_i == 7'h0 ) ) ?  6'd0 :
                      ( (opcode_i == 7'h1B) && (func3_i == 3'h0 ) && (func7_i == 7'h0 ) ) ?  6'd1 :
                      ( (opcode_i == 7'h1B) && (func3_i == 3'h1 ) && (func7_i == 7'h0 ) ) ?  6'd2 :
                      ( (opcode_i == 7'h1B) && (func3_i == 3'h5 ) && (func7_i == 7'h0 ) ) ?  6'd6 :
                      ( (opcode_i == 7'h1B) && (func3_i == 3'h5 ) && (func7_i == 7'h20 ) ) ?  6'd7 :
                      ( (opcode_i == 7'h23) && (func3_i == 3'h0 ) && (func7_i == 7'h0 ) ) ?  6'd0 :
                      ( (opcode_i == 7'h23) && (func3_i == 3'h1 ) && (func7_i == 7'h0 ) ) ?  6'd0 :
                      ( (opcode_i == 7'h23) && (func3_i == 3'h2 ) && (func7_i == 7'h0 ) ) ?  6'd0 :
                      ( (opcode_i == 7'h23) && (func3_i == 3'h3 ) && (func7_i == 7'h0 ) ) ?  6'd0 :
                      ( (opcode_i == 7'h33) && (func3_i == 3'h0 ) && (func7_i == 7'h0 ) ) ?  6'd1 :
                      ( (opcode_i == 7'h33) && (func3_i == 3'h0 ) && (func7_i == 7'h20 ) ) ?  6'd10 :
                      ( (opcode_i == 7'h33) && (func3_i == 3'h1 ) && (func7_i == 7'h0 ) ) ?  6'd2 :
                      ( (opcode_i == 7'h33) && (func3_i == 3'h2 ) && (func7_i == 7'h0 ) ) ?  6'd3 :
                      ( (opcode_i == 7'h33) && (func3_i == 3'h3 ) && (func7_i == 7'h0 ) ) ?  6'd4 :
                      ( (opcode_i == 7'h33) && (func3_i == 3'h4 ) && (func7_i == 7'h0 ) ) ?  6'd5 :
                      ( (opcode_i == 7'h33) && (func3_i == 3'h5 ) && (func7_i == 7'h0 ) ) ?  6'd6 :
                      ( (opcode_i == 7'h33) && (func3_i == 3'h5 ) && (func7_i == 7'h20 ) ) ?  6'd7 :
                      ( (opcode_i == 7'h33) && (func3_i == 3'h6 ) && (func7_i == 7'h0 ) ) ?  6'd8 :
                      ( (opcode_i == 7'h33) && (func3_i == 3'h7 ) && (func7_i == 7'h0 ) ) ?  6'd9 :
                      ( (opcode_i == 7'h37) && (func3_i == 3'h0 ) && (func7_i == 7'h0 ) ) ?  6'd0 :
                      ( (opcode_i == 7'h3B) && (func3_i == 3'h0 ) && (func7_i == 7'h0 ) ) ?  6'd1 :
                      ( (opcode_i == 7'h3B) && (func3_i == 3'h0 ) && (func7_i == 7'h20 ) ) ?  6'd10 :
                      ( (opcode_i == 7'h3B) && (func3_i == 3'h1 ) && (func7_i == 7'h0 ) ) ?  6'd2 :
                      ( (opcode_i == 7'h3B) && (func3_i == 3'h5 ) && (func7_i == 7'h0 ) ) ?  6'd6 :
                      ( (opcode_i == 7'h3B) && (func3_i == 3'h5 ) && (func7_i == 7'h20 ) ) ?  6'd7 :
                      ( (opcode_i == 7'h63) && (func3_i == 3'h0 ) && (func7_i == 7'h0 ) ) ?  6'd11 :
                      ( (opcode_i == 7'h63) && (func3_i == 3'h1 ) && (func7_i == 7'h0 ) ) ?  6'd12 :
                      ( (opcode_i == 7'h63) && (func3_i == 3'h4 ) && (func7_i == 7'h0 ) ) ?  6'd13 :
                      ( (opcode_i == 7'h63) && (func3_i == 3'h5 ) && (func7_i == 7'h0 ) ) ?  6'd14 :
                      ( (opcode_i == 7'h63) && (func3_i == 3'h6 ) && (func7_i == 7'h0 ) ) ?  6'd15 :
                      ( (opcode_i == 7'h63) && (func3_i == 3'h7 ) && (func7_i == 7'h0 ) ) ?  6'd16 :
                      ( (opcode_i == 7'h67) && (func3_i == 3'h0 ) && (func7_i == 7'h0 ) ) ?  6'd0 :
                      ( (opcode_i == 7'h6F) && (func3_i == 3'h0 ) && (func7_i == 7'h0 ) ) ?  6'd17 :
                      ( (opcode_i == 7'h73) && (func3_i == 3'h0 ) && (func7_i == 7'h0 ) ) ?  6'd0 :
                      ( (opcode_i == 7'h73) && (func3_i == 3'h0 ) && (func7_i == 7'h1 ) ) ?  6'd0 :6'd0;

                       

 endmodule : CONTROL
