module tb_REG_FILE (
  input clk_i,
  output logic regrst_o,  // Asynchronous reset active low
  output logic [4:0] RS1_o,
  output logic [4:0] RS2_o,
  output logic [4:0] RD_o,
  input logic [31:0] R1_i,
  input logic [31:0] R2_i,
  output logic [31:0] WR_o,
  output logic RWR_EN_o
   );
  timeunit 1ns; timeprecision 1ns;
    initial begin


     
     @(posedge clk_i);
     RS1_o = 5'd1;
     RS2_o = 5'd0;
     regrst_o =1'b0;
     RWR_EN_o=1'b1;
     WR_o  =32'd345;
     RD_o  = 5'd1;


      @(posedge clk_i);
     RS1_o = 5'd1;
     RS2_o = 5'd2;
     regrst_o =1'b0;
     RWR_EN_o=1'b1;
     WR_o  =32'd346;
     RD_o  = 5'd2;

     @(posedge clk_i);
     RS1_o = 5'd0;
     RS2_o = 5'd1;
     regrst_o =1'b0;
     RWR_EN_o=1'b1;
     WR_o  =32'd346;
     RD_o  = 5'd0;

     @(posedge clk_i);
     RS1_o = 5'd10;
     RS2_o = 5'd2;
     regrst_o =1'b0;
     RWR_EN_o=1'b0;
     WR_o  =32'd20;
     RD_o  = 5'd10;

     @(posedge clk_i);
     RS1_o = 5'd10;
     RS2_o = 5'd11;
     regrst_o =1'b0;
     RWR_EN_o=1'b1;
     WR_o  =32'd21;
     RD_o  = 5'd11;


     @(posedge clk_i);
     RS1_o = 5'b11111;
     RS2_o = 5'b11110;
     regrst_o =1'b0;
     RWR_EN_o=1'b1;
     WR_o  =32'd30;
     RD_o  = 5'b11111;



     end 
endmodule

