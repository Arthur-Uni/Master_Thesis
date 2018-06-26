module shift_PLA_tb_v2();

   localparam W_IN = 10;      // input wordlength
   localparam W_OUT = 10;     // output wordlength
   localparam IN_I = 4;      // # number of input integer bits
   localparam BOUNDARY = 1;  // # position of relevant MSB for shift operation, otherwise output is asymptotic bound of tanh (+1,-1)

   reg                          clock;
   reg                          resetn;

   reg       [ W_IN-1:0 ]       in;

   wire      [ W_OUT-1:0 ]      out;

   shift_PLA_v2 DUT (
      .clock(clock),
      .resetn(resetn),
      .in(in),
      .out(out)
   );
   defparam
      DUT.W_IN = W_IN,
      DUT.W_OUT = W_OUT,
      DUT.IN_I = IN_I,
      DUT.BOUNDARY = BOUNDARY;
      
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
      resetn = 1; in = 10'b1011_000000;
      # 10
      in = 10'b1011_010000;
      # 10
      in = 10'b1011_100000;
      # 10
      in = 10'b1011_110000;
      # 10
      in = 10'b1100_000000; 
      # 10
      in = 10'b1100_010000;
      # 10
      in = 10'b1100_100000;
      # 10
      in = 10'b1100_110000;
      # 10
      in = 10'b1101_000000;
      # 10
      in = 10'b1101_010000;
      # 10
      in = 10'b1101_100000;
      # 10
      in = 10'b1101_110000;
      # 10
      in = 10'b1110_000000;
      # 10
      in = 10'b1110_010000;
      # 10
      in = 10'b1110_100000;
      # 10
      in = 10'b1110_110000;
      # 10
      in = 10'b1111_000000;
      # 10
      in = 10'b1111_010000;
      # 10
      in = 10'b1111_100000;
      # 10
      in = 10'b1111_110000;
      # 10
      in = 10'b0000_000000;
      # 10
      in = 10'b0000_010000;
      # 10
      in = 10'b0000_100000;
      # 10
      in = 10'b0000_110000;
      # 10
      in = 10'b0001_000000;
      # 10
      in = 10'b0001_010000;
      # 10
      in = 10'b0001_100000;
      # 10
      in = 10'b0001_110000;
      # 10
      in = 10'b0010_000000;
      # 10
      in = 10'b0010_010000;
      # 10
      in = 10'b0010_100000;
      # 10
      in = 10'b0010_110000;
      # 10
      in = 10'b0011_000000;
      # 10
      in = 10'b0011_010000;
      # 10
      in = 10'b0011_100000;
      # 10
      in = 10'b0011_110000;
      # 10
      in = 10'b0100_000000;
      # 10
      in = 10'b0100_010000;
      # 10
      in = 10'b0100_100000;
      # 10
      in = 10'b0100_110000;
      # 10
      in = 10'b0101_000000;
   end

endmodule