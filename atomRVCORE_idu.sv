timeunit 1ns; timeprecision 1ns;
module atomRVCORE_idu #(
 parameter DATAWIDTH=32,
 parameter REG_ADRESS_WIDTH=5,
 parameter OPCODE_WIDTH=6,
 parameter REGISTERS=32
	)
	(
	   input clk_i,
     input logic [DATAWIDTH-1:0] result_i,//ALU result input from alu to decide branch enable
     input logic [DATAWIDTH-1:0] instr_i,//32 BIT INSTRUCTION FROM FETCH UNIT
     input logic RWR_EN_if,
     input logic [REG_ADRESS_WIDTH-1:0] RD_if,
     input logic [DATAWIDTH-1:0] WR_if,
     input logic [DATAWIDTH-1:0] PC_i,
	   output logic [DATAWIDTH-1:0] immed_o,//32bit sign extended immedite output from decode and input to fetch unit
     output logic [DATAWIDTH-1:0] address_o,//32 output from decode input to data memory
     output logic [DATAWIDTH-1:0] operand_B_o,//32 bit operand to ALU either immediate or R2
     output logic U_EN_o,//U TYPE INSTRUCTION ENABLE
     output logic UJ_EN_o,//UJ TYPE INSTRUCTION ENABLE
     output logic BE_o,//BRANCH ENABLE SIGNAL FROM decode to fetch unit
     output logic JALRE_o,//JUMP AND LINK ENABLE SIGNAL FROM decode to FETCH
     output logic UJE_o,//UJ ENABLE SIGNAL FROM DECODE UNIT TO FETCH
     output logic IWR_EN_o,//INSTRUCTION WRITE ENABLE SIGNAL TO WRITE ON INSTRUCTION MEM
     output logic [OPCODE_WIDTH-1:0] ALUop_o,//ALU OPCODE SWITCH FOR OPERATION to ALU
     output logic IR_EN_o,//Instruction Read enable signal to instruction memory
     output logic PCrst_o,//PC reset signal to fetch
     output logic DR_EN_o,//Data read enable signal to DATA memory
     output logic DWR_EN_o,//Data write enable signal to data memory
     output logic [DATAWIDTH-1:0] operand_A_o,//
     output logic [REG_ADRESS_WIDTH-1:0] RD_o,
     output logic [DATAWIDTH-1:0] R2_o,
     output logic RWR_EN_o,
     output logic [DATAWIDTH-1:0] PC_o,
     output logic LUI_EN_o
     );
  
    logic I_EN;
    logic R_EN;
    logic S_EN;
    logic SB_EN;
    logic U_EN;
    logic UJ_EN;
    logic RWR_EN;
    logic BE;
    logic JALRE;
    logic UJE;
    logic ALUop;
    logic regrst;
    logic DR_EN;
    logic DWR_EN;
    logic LUI_EN;
    logic [REG_ADRESS_WIDTH-1:0] RS1;//
    logic [REG_ADRESS_WIDTH-1:0] RS2;//
    logic [REG_ADRESS_WIDTH-1:0] RD;//
    logic [REG_ADRESS_WIDTH-1:0] R1;//
    logic [REG_ADRESS_WIDTH-1:0] R2;//
    logic [6:0] opcode;//
    logic [2:0] func3;//
    logic [6:0] func7;//
    logic [DATAWIDTH-1:0] immed;
    logic [DATAWIDTH-1:0] address;
    logic [DATAWIDTH-1:0] operand_B;
    logic [DATAWIDTH-1:0] operand_A;

    logic [DATAWIDTH-1:0] R [0:REGISTERS-1];
integer i;

initial begin

    for (i=0;i<REGISTERS;i++)begin

     R[i] = 0;

     end

end

always @ (posedge clk_i)begin

    if (regrst==1'b1) begin

        for (i=0;i<REGISTERS;i++)

            R[i]<=0;

        end

    else if (regrst==1'b0 && RWR_EN_if==1'b1)begin

            if (RD_if==5'd0)

                R[0]<=32'd0;

            else
                 R[RD_if]<=WR_if;       

        end

end

assign R1 = R[RS1];

assign R2 = R[RS2];
assign operand_A =R1;


	always_comb begin 
     opcode= instr_i[6:0] ;
      
       // address=32'd0;


        if (R_EN==1'b1 && I_EN !=1'b1 && S_EN!=1'b1 && SB_EN != 1'b1 && U_EN!=1'b1 && UJ_EN != 1'b1) begin
     	 RD   = instr_i[11:7];
     	 func3 = instr_i[14:12];
     	 RS1   = instr_i[19:15];
     	 RS2   = instr_i[24:20];
     	 func7 =instr_i[31:25];
         end
        else if (I_EN==1'b1 && R_EN!=1'b1 && S_EN!=1'b1 && SB_EN != 1'b1 && U_EN!=1'b1 && UJ_EN != 1'b1) begin
     	 RD    = instr_i[11:7];
     	 func3 = instr_i[14:12];
     	 RS1   = instr_i[19:15];
     	 func7 =instr_i[31:25];
     	 immed = {{20{instr_i[31]}},instr_i[31:20]};
         end
        else if (I_EN!=1'b1 && R_EN!=1'b1 && S_EN==1'b1 && SB_EN != 1'b1 && U_EN!=1'b1 && UJ_EN != 1'b1) begin
     	 func3 = instr_i[14:12];
     	 RS1   = instr_i[19:15];
     	 RS2   = instr_i[24:20];
     	 immed={{20{instr_i[31]}},instr_i[31:25],instr_i[11:7]};
       func7=7'd0;
         end
        else if (I_EN!=1'b1 && R_EN!=1'b1 && S_EN!=1'b1 && SB_EN == 1'b1 && U_EN!=1'b1 && UJ_EN != 1'b1) begin
     	 func3 = instr_i[14:12];
     	 RS1   = instr_i[19:15];
     	 RS2   = instr_i[24:20];
     	 immed = {{20{instr_i[31]}},instr_i[31],instr_i[7],instr_i[30:25],instr_i[11:8]};
       func7=7'd0;

         end
        else if (I_EN!=1'b1 && R_EN!=1'b1 && S_EN!=1'b1 && SB_EN != 1'b1 && U_EN==1'b1 && UJ_EN != 1'b1) begin
     	 RD  = instr_i[11:7];
     	 immed={{12{instr_i[31]}},instr_i[31:12]};
       func7=7'd0;
     	 
     	 end
        else if (I_EN!=1'b1 && R_EN!=1'b1 && S_EN!=1'b1 && SB_EN != 1'b1 && U_EN!=1'b1 && UJ_EN == 1'b1) begin
         RD   = instr_i[11:7];
         immed = {{12{instr_i[31]}},instr_i[31],instr_i[19:12],instr_i[20],instr_i[30:21]};
         func7=7'd0;
         end
        else begin
    
         RD    = 5'd0;
         func3 = 3'd0;
         RS1   = 5'd0;
         RS2   = 5'd0;
         func7 =7'd0;  
         end

        if (DR_EN==1'b1 || DWR_EN)
        address=immed+R1;
        if (SB_EN == 1'b1 || R_EN == 1'b1 || S_EN == 1'b1 )
            operand_B= R2;
        else
         operand_B =  immed;

     end

    always_ff @(posedge clk_i) begin   //CREATING STAGE FOR DECODE WITH CLOCK EDGE
     PC_o<=PC_i;
     immed_o<=immed;
     address_o<=address;
     operand_B_o<=operand_B;
     operand_A_o<=operand_A;
     ALUop_o<=ALUop;
     U_EN_o<=U_EN;
     UJ_EN_o<=UJ_EN;
     BE_o<=BE;
     JALRE_o<=JALRE;
     UJE_o<=UJE;
     DR_EN_o<=DR_EN;
     DWR_EN_o<=DWR_EN;
     RWR_EN_o<=RWR_EN;
     RD_o<=RD;
     LUI_EN_o<=LUI_EN;
     R2_o<=R2;
        end

    always_comb begin 
        
    
        IWR_EN_o=1'b0;
        IR_EN_o=1'b1;
        regrst=1'b0;
        PCrst_o=1'b1;
        
     end
    localparam    R_TYPE  = 7'b0110011, 

                  I_TYPE  = 7'b0010011, 

                  STORE   = 7'b0100011,

                  LOAD    = 7'b0000011,

                  BRANCH  = 7'b1100011,

                  JALR    = 7'b1100111,

                  JAL     = 7'b1101111;



    assign RWR_EN = ((opcode == R_TYPE) | (opcode == I_TYPE) | (opcode == LOAD)

                   | (opcode == JALR) | (opcode == JAL) )? 1'b1 : 1'b0; 

    assign DWR_EN = (opcode == STORE)?   1'b1 : 1'b0; 

    assign BE     = (result_i == 32'd1 && SB_EN==1'b1 )?  1'b1 : 1'b0; 

    assign DR_EN       = (opcode == LOAD)?    1'b1 : 1'b0; 

    assign I_EN   =   ((opcode == 7'b0000011) | (opcode == 7'b0010011)
                        |(opcode == 7'b0011011) | (opcode == 7'b1100111)
                        | (opcode == 7'b1110011)  )?  1'b1 : 1'b0;

    assign R_EN   =   ((opcode == 7'b0110011) | (opcode == 7'b0111011) )?  1'b1 : 1'b0;

    assign S_EN   =   ((opcode == 7'b0100011))?  1'b1 : 1'b0;

    assign SB_EN  =   ((opcode == 7'b1100011))?  1'b1 : 1'b0;

    assign U_EN   =   ((opcode == 7'b0110111))?  1'b1 : 1'b0;

    assign LUI_EN   =   ((opcode == 7'b0010111))?  1'b1 : 1'b0;

    assign UJ_EN  =   ((opcode == 7'b1101111))?  1'b1 : 1'b0;
    
    assign JALRE  =    (opcode == JALR)? 1'b1 : 1'b0;

    assign UJE    =   (opcode == JAL)? 1'b1 : 1'b0;

    assign ALUop  =    ((opcode == 7'h13) && (func3 == 3'h0 ) & (func7 == 7'h0 )) ?  6'd1 :  //addi,add,addiw
                      ( (opcode == 7'h13) && (func3 == 3'h1 ) && (func7 == 7'h0 ) ) ?  6'd2 :
                      ( (opcode == 7'h13) && (func3 == 3'h2 ) && (func7 == 7'h0 ) ) ?  6'd3 :
                      ( (opcode == 7'h13) && (func3 == 3'h3 ) && (func7 == 7'h0 ) ) ?  6'd4 :
                      ( (opcode == 7'h13) && (func3 == 3'h4 ) && (func7 == 7'h0 ) ) ?  6'd5 :
                      ( (opcode == 7'h13) && (func3 == 3'h5 ) && (func7 == 7'h0 ) ) ?  6'd6 :
                      ( (opcode == 7'h13) && (func3 == 3'h5 ) && (func7 == 7'h20 ) ) ?  6'd7 :
                      ( (opcode == 7'h13) && (func3 == 3'h6 ) && (func7 == 7'h0 ) ) ?  6'd8 :
                      ( (opcode == 7'h13) && (func3 == 3'h7 ) && (func7 == 7'h0 ) ) ?  6'd9 :
                      ( (opcode == 7'h17) && (func3 == 3'h0 ) && (func7 == 7'h0 ) ) ?  6'd0 :
                      ( (opcode == 7'h1B) && (func3 == 3'h0 ) && (func7 == 7'h0 ) ) ?  6'd1 :
                      ( (opcode == 7'h1B) && (func3 == 3'h1 ) && (func7 == 7'h0 ) ) ?  6'd2 :
                      ( (opcode == 7'h1B) && (func3 == 3'h5 ) && (func7 == 7'h0 ) ) ?  6'd6 :
                      ( (opcode == 7'h1B) && (func3 == 3'h5 ) && (func7 == 7'h20 ) ) ?  6'd7 :
                      ( (opcode == 7'h23) && (func3 == 3'h0 ) && (func7 == 7'h0 ) ) ?  6'd0 :
                      ( (opcode == 7'h23) && (func3 == 3'h1 ) && (func7 == 7'h0 ) ) ?  6'd0 :
                      ( (opcode == 7'h23) && (func3 == 3'h2 ) && (func7 == 7'h0 ) ) ?  6'd0 :
                      ( (opcode == 7'h23) && (func3 == 3'h3 ) && (func7 == 7'h0 ) ) ?  6'd0 :
                      ( (opcode == 7'h33) && (func3 == 3'h0 ) && (func7 == 7'h0 ) ) ?  6'd1 :
                      ( (opcode == 7'h33) && (func3 == 3'h0 ) && (func7 == 7'h20 ) ) ?  6'd10 :
                      ( (opcode == 7'h33) && (func3 == 3'h1 ) && (func7 == 7'h0 ) ) ?  6'd2 :
                      ( (opcode == 7'h33) && (func3 == 3'h2 ) && (func7 == 7'h0 ) ) ?  6'd3 :
                      ( (opcode == 7'h33) && (func3 == 3'h3 ) && (func7 == 7'h0 ) ) ?  6'd4 :
                      ( (opcode == 7'h33) && (func3 == 3'h4 ) && (func7 == 7'h0 ) ) ?  6'd5 :
                      ( (opcode == 7'h33) && (func3 == 3'h5 ) && (func7 == 7'h0 ) ) ?  6'd6 :
                      ( (opcode == 7'h33) && (func3 == 3'h5 ) && (func7 == 7'h20 ) ) ?  6'd7 :
                      ( (opcode == 7'h33) && (func3 == 3'h6 ) && (func7 == 7'h0 ) ) ?  6'd8 :
                      ( (opcode == 7'h33) && (func3 == 3'h7 ) && (func7 == 7'h0 ) ) ?  6'd9 :
                      ( (opcode == 7'h37) && (func3 == 3'h0 ) && (func7 == 7'h0 ) ) ?  6'd0 :
                      ( (opcode == 7'h3B) && (func3 == 3'h0 ) && (func7 == 7'h0 ) ) ?  6'd1 :
                      ( (opcode == 7'h3B) && (func3 == 3'h0 ) && (func7 == 7'h20 ) ) ?  6'd10 :
                      ( (opcode == 7'h3B) && (func3 == 3'h1 ) && (func7 == 7'h0 ) ) ?  6'd2 :
                      ( (opcode == 7'h3B) && (func3 == 3'h5 ) && (func7 == 7'h0 ) ) ?  6'd6 :
                      ( (opcode == 7'h3B) && (func3 == 3'h5 ) && (func7 == 7'h20 ) ) ?  6'd7 :
                      ( (opcode == 7'h63) && (func3 == 3'h0 ) && (func7 == 7'h0 ) ) ?  6'd11 :
                      ( (opcode == 7'h63) && (func3 == 3'h1 ) && (func7 == 7'h0 ) ) ?  6'd12 :
                      ( (opcode == 7'h63) && (func3 == 3'h4 ) && (func7 == 7'h0 ) ) ?  6'd13 :
                      ( (opcode == 7'h63) && (func3 == 3'h5 ) && (func7 == 7'h0 ) ) ?  6'd14 :
                      ( (opcode == 7'h63) && (func3 == 3'h6 ) && (func7 == 7'h0 ) ) ?  6'd15 :
                      ( (opcode == 7'h63) && (func3 == 3'h7 ) && (func7 == 7'h0 ) ) ?  6'd16 :
                      ( (opcode == 7'h67) && (func3 == 3'h0 ) && (func7 == 7'h0 ) ) ?  6'd0 :
                      ( (opcode == 7'h6F) && (func3 == 3'h0 ) && (func7 == 7'h0 ) ) ?  6'd17 :
                      ( (opcode == 7'h73) && (func3 == 3'h0 ) && (func7 == 7'h0 ) ) ?  6'd0 :
                      ( (opcode == 7'h73) && (func3 == 3'h0 ) && (func7 == 7'h1 ) ) ?  6'd0 :6'd0;

   

endmodule : atomRVCORE_idu
