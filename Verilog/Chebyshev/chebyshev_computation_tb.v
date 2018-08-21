module chebyshev_computation_tb();

// ###################################
// # Module: - testbench for chebyshev_computation_v2.v
// ###################################

   localparam WL = 4;   //input word length
   localparam CL = 4;   //coefficient word length
   localparam WIDENING = 1;

   localparam OUT = 2*WL + CL + WIDENING;
   
   reg                              clock;
   reg                              resetn;

   reg signed  [WL-1:0]             data_in;
   reg signed  [CL-1:0]             coeff_in;

   wire signed [OUT-1:0]            data_out;
   
   chebyshev_computation_v2 DUT(
      .clock(clock),
      .resetn(resetn),
      .data_in(data_in),
      .coeff_in(coeff_in),
      .data_out(data_out)
   );
   
   defparam
      DUT.WL = WL,
      DUT.CL = CL,
      DUT.WIDENING = WIDENING;
   
// generate clock signal
   initial begin 
      clock = 1;
      forever begin
         #5 clock = ~clock;
      end 
   end
   
   initial begin
      resetn = 1;
      # 10 resetn = 0;
      # 10 resetn = 1; data_in = 4'b0_100; coeff_in = 4'b00_10;
      # 10 data_in = 4'b0_110; coeff_in = 4'b00_11;
      # 10 data_in = 4'b0_101; coeff_in = 4'b00_01;
      # 10 data_in = 4'b0; coeff_in = 4'b0;
   end
      
endmodule