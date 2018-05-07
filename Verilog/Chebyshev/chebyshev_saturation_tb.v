module chebyshev_saturation_tb ();

   localparam WL = 12;            //wordlength
   localparam I_BITS = 6;        //# integer bits
   localparam BOUNDARY_BIT_POSITION = 3;  // which integer bit is relevant for the saturation_flag (counted from LSB of integer part upwards)
   localparam O_BITS = WL - (I_BITS - BOUNDARY_BIT_POSITION);
   
   reg    [WL-1:0]       data_in;
   wire   [O_BITS-1:0]       data_out;
   
   chebyshev_saturation DUT(
         .data_in(data_in),
         .data_out(data_out)
      );
   defparam
      DUT.WL = WL,
      DUT.I_BITS = I_BITS,
      DUT.BOUNDARY_BIT_POSITION = BOUNDARY_BIT_POSITION;
      
   initial begin
      data_in = 12'b111110_001100;
      # 10
      data_in = 12'b000100_000001;
      # 10
      data_in = 12'b000001_110110;
      # 10
      data_in = 12'b000100_000000;
      # 10
      data_in = 12'b000010_000000; 
      # 10
      data_in = 12'b111100_000000;
   end
   
endmodule