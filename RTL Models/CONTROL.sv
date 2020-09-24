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
     output logic regrst_o

     );

	always_comb begin 
        

        I_EN_o =1'b0;
        R_EN_o =1'b0;
	    S_EN_o=1'b0;
        SB_EN_o=1'b0;
        U_EN_o=1'b0;
        UJ_EN_o=1'b0;
	    RWR_EN_o=1'b0;
	    BE_o=1'b0;
	    JALRE_o=1'b0;
	    UJE_o=1'b0;
	    IWR_EN_o=1'b0;
	    ALUop_o=6'd0;
        IR_EN_o=1'b1;
        regrst_o=1'b0;






        case (opcode_i)

       	    7'h3 : begin
              I_EN_o=1'b1;
              
                case (func3_i)

                	3'h0: begin
                		case (func7_i)
                		
                		    7'h0: begin

                             

                		     end
                		    7'h20: begin


                		     end

                			default : $display("INVALID INSTRUCTION");

                		endcase

                	 end

                	3'h1: begin

                		case (func7_i)
                		
                		    7'h0: begin



                		     end
                		    7'h20: begin


                		     end

                			default : $display("INVALID INSTRUCTION");

                		endcase

                	 end

                	3'h2: begin
                		case (func7_i)
                		
                		    7'h0: begin



                		     end
                		    7'h20: begin


                		     end

                			default : $display("INVALID INSTRUCTION");

                		endcase

                	 end

                	3'h3: begin
                		case (func7_i)
                		
                		    7'h0: begin



                		     end
                		    7'h20: begin


                		     end

                			default : $display("INVALID INSTRUCTION");

                		endcase

                	 end

                	3'h4: begin
                		case (func7_i)
                		
                		    7'h0: begin



                		     end
                		    7'h20: begin


                		     end

                			default : $display("INVALID INSTRUCTION");

                		endcase

                	 end

                	3'h5: begin
                		case (func7_i)
                		
                		    7'h0: begin



                		     end
                		    7'h20: begin


                		     end

                			default : $display("INVALID INSTRUCTION");

                		endcase

                	 end

                	3'h6: begin
                		case (func7_i)
                		
                		    7'h0: begin



                		     end
                		    7'h20: begin


                		     end

                			default : $display("INVALID INSTRUCTION");

                		endcase

                	 end

                	3'h7: begin
                		case (func7_i)
                		
                		    7'h0: begin



                		     end
                		    7'h20: begin


                		     end

                			default : $display("INVALID INSTRUCTION");

                		endcase

                	 end
              
              	   default : $display("INVALID INSTRUCTION");
                 endcase

             end

            7'h13 : begin
            	I_EN_o=1'b1;
            	case (func3_i)

                	3'h0: begin
                		case (func7_i)
                		
                		    7'h0: begin

                             RWR_EN_o=1'b1;
                             ALUop_o =6'd0;//FOR ADDI 


                		     end
                		    7'h20: begin


                		     end

                			default : $display("INVALID INSTRUCTION");

                		endcase

                	 end

                	3'h1: begin

                		case (func7_i)
                		
                		    7'h0: begin

                             RWR_EN_o=1'b1;
                             ALUop_o=6'd1; //SLLI

                		     end
                		    7'h20: begin


                		     end

                			default : $display("INVALID INSTRUCTION");

                		endcase

                	 end

                	3'h2: begin
                		case (func7_i)
                		
                		    7'h0: begin

                             RWR_EN_o=1'b1;
                             ALUop_o=6'd2;//SLTI

                		     end
                		    7'h20: begin


                		     end

                			default : $display("INVALID INSTRUCTION");

                		endcase

                	 end

                	3'h3: begin
                		case (func7_i)
                		
                		    7'h0: begin

                              RWR_EN_o=1'b1;
                              ALUop_o=6'd3;//SLTIU

                		     end
                		    7'h20: begin


                		     end

                			default : $display("INVALID INSTRUCTION");

                		endcase

                	 end

                	3'h4: begin
                		case (func7_i)
                		
                		    7'h0: begin

                              RWR_EN_o=1'b1;
                              ALUop_o=6'd4;//XORI

                		     end
                		    7'h20: begin


                		     end

                			default : $display("INVALID INSTRUCTION");

                		endcase

                	 end

                	3'h5: begin
                		case (func7_i)
                		
                		    7'h0: begin

                             RWR_EN_o=1'b1;
                             ALUop_o=6'd5;//SRLI

                		     end
                		    7'h20: begin
                            
                             RWR_EN_o=1'b1;
                             ALUop_o=6'd6;//SRAI

                		     end

                			default : $display("INVALID INSTRUCTION");

                		endcase

                	 end

                	3'h6: begin
                		case (func7_i)
                		
                		    7'h0: begin

                             RWR_EN_o=1'b1;
                             ALUop_o=6'd7;//ORI

                		     end
                		    7'h20: begin


                		     end

                			default : $display("INVALID INSTRUCTION");

                		endcase

                	 end

                	3'h7: begin
                		case (func7_i)
                		
                		    7'h0: begin

                             RWR_EN_o=1'b1;
                             ALUop_o=6'd8;//ANDI

                		     end
                		    7'h20: begin


                		     end

                			default : $display("INVALID INSTRUCTION");

                		endcase

                	 end
              
              	   default : $display("INVALID INSTRUCTION");
                 endcase

             end

       	    7'h1B : begin
       	    	I_EN_o=1'b1;
       	    	case (func3_i)

                	3'h0: begin
                		case (func7_i)
                		
                		    7'h0: begin

                             RWR_EN_o=1'b1;
                             ALUop_o=6'd0;//ADDIW

                		     end
                		    7'h20: begin


                		     end

                			default : $display("INVALID INSTRUCTION");

                		endcase

                	 end

                	3'h1: begin

                		case (func7_i)
                		
                		    7'h0: begin

                             RWR_EN_o=1'b1;
                             ALUop_o=6'd1;//SLLIW

                		     end
                		    7'h20: begin


                		     end

                			default : $display("INVALID INSTRUCTION");

                		endcase

                	 end

                	3'h2: begin
                		case (func7_i)
                		
                		    7'h0: begin



                		     end
                		    7'h20: begin


                		     end

                			default : $display("INVALID INSTRUCTION");

                		endcase

                	 end

                	3'h3: begin
                		case (func7_i)
                		
                		    7'h0: begin



                		     end
                		    7'h20: begin


                		     end

                			default : $display("INVALID INSTRUCTION");

                		endcase

                	 end

                	3'h4: begin
                		case (func7_i)
                		
                		    7'h0: begin



                		     end
                		    7'h20: begin


                		     end

                			default : $display("INVALID INSTRUCTION");

                		endcase

                	 end

                	3'h5: begin
                		case (func7_i)
                		
                		    7'h0: begin

                             RWR_EN_o=1'b1;
                             ALUop_o=6'd5;//SRLIW

                		     end
                		    7'h20: begin
                           
                             RWR_EN_o=1'b1;
                             ALUop_o=6'd6;//SRAIW

                		     end

                			default : $display("INVALID INSTRUCTION");

                		endcase

                	 end

                	3'h6: begin
                		case (func7_i)
                		
                		    7'h0: begin



                		     end
                		    7'h20: begin


                		     end

                			default : $display("INVALID INSTRUCTION");

                		endcase

                	 end

                	3'h7: begin
                		case (func7_i)
                		
                		    7'h0: begin



                		     end
                		    7'h20: begin


                		     end

                			default : $display("INVALID INSTRUCTION");

                		endcase

                	 end
              
              	   default : $display("INVALID INSTRUCTION");
                 endcase

       	     end

       	    7'h67 : begin
       	        I_EN_o=1'b1;
       	        case (func3_i)

                	3'h0: begin
                		case (func7_i)
                		
                		    7'h0: begin

                             JALRE_o=1'b1;
                             RWR_EN_o=1'b1;
                             ALUop_o=6'd9;//JALR

                		     end
                		    7'h20: begin


                		     end

                			default : $display("INVALID INSTRUCTION");

                		endcase

                	 end

                	3'h1: begin

                		case (func7_i)
                		
                		    7'h0: begin



                		     end
                		    7'h20: begin


                		     end

                			default : $display("INVALID INSTRUCTION");

                		endcase

                	 end

                	3'h2: begin
                		case (func7_i)
                		
                		    7'h0: begin



                		     end
                		    7'h20: begin


                		     end

                			default : $display("INVALID INSTRUCTION");

                		endcase

                	 end

                	3'h3: begin
                		case (func7_i)
                		
                		    7'h0: begin



                		     end
                		    7'h20: begin


                		     end

                			default : $display("INVALID INSTRUCTION");

                		endcase

                	 end

                	3'h4: begin
                		case (func7_i)
                		
                		    7'h0: begin



                		     end
                		    7'h20: begin


                		     end

                			default : $display("INVALID INSTRUCTION");

                		endcase

                	 end

                	3'h5: begin
                		case (func7_i)
                		
                		    7'h0: begin



                		     end
                		    7'h20: begin


                		     end

                			default : $display("INVALID INSTRUCTION");

                		endcase

                	 end

                	3'h6: begin
                		case (func7_i)
                		
                		    7'h0: begin



                		     end
                		    7'h20: begin


                		     end

                			default : $display("INVALID INSTRUCTION");

                		endcase

                	 end

                	3'h7: begin
                		case (func7_i)
                		
                		    7'h0: begin



                		     end
                		    7'h20: begin


                		     end

                			default : $display("INVALID INSTRUCTION");

                		endcase

                	 end
              
              	   default :$display("INVALID INSTRUCTION") ;
                 endcase

       	     end
       
       	   default : $display("INVALID INSTRUCTION");
         endcase






	 end

 endmodule : CONTROL
