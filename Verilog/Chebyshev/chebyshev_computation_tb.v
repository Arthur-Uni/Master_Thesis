module chebyshev_computation_tb();

   parameter WL_A_TB = 8;   //word length of a_reg for testbench
   parameter WL_B_TB = 8;   //word length of mult2 for testbench

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
   
// generate clock signal
   initial begin 
      clock = 0;
      forever begin
         #10 clock = ~clock;
      end 
   end
   
   initial begin
      resetn = 0;
      # 10 resetn = 1; data_in = 8'b00101011; coeff_in = 8'b00001111;
      # 30 data_in = 8'b00000010; coeff_in = 8'b00000001;
      # 50 data_in = 8'b00000001; coeff_in = 8'b00000000;      
   end
      
endmodule