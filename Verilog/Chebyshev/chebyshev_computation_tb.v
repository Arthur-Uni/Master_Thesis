module chebyshev_computation_tb();

   parameter WL_A_TB = 2;   //word length of a_reg for testbench
   parameter WL_B_TB = 2;   //word length of mult2 for testbench

   reg                              clock;
   reg                              resetn;

   reg signed  [WL_A_TB-1:0]        data_in;
   reg signed  [WL_B_TB-1:0]        coeff_in;

   wire signed [WL_A_TB-1:0]        data_out;
   
   chebyshev_computation DUT(
      .clock(clock),
      .resetn(resetn),
      .data_in(data_in),
      .coeff_in(coeff_in),
      .data_out(data_out)
   );
   
   defparam
      DUT.WL = WL_A_TB,
      DUT.CL = WL_B_TB;
      
   initial begin
      clock <= 1'b0;
      resetn <= 1'b0;
   end
   
   always  
      #5  clock =  !clock;
      
endmodule