module shift_PLA_tb();

   localparam W_IN = 12;      // input wordlength
   localparam W_OUT = 8;     // output wordlength
   localparam IN_I = 5;      // # number of input integer bits
   localparam BOUNDARY = 3;  // # position of relevant MSB for shift operation, otherwise output is asymptotic bound of tanh (+1,-1)

   reg                          clock;
   reg                          resetn;

   reg       [ W_IN-1:0 ]       in;

   wire      [ W_OUT-1:0 ]      out;

   shift_PLA DUT (
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
      resetn = 1; in = 12'b11111_0011001;
      # 10
      in = 12'b00110_0100001;
      # 10
      in = 12'b00001_1110110;
      # 10
      in = 12'b00100_0000000;
      # 10
      in = 12'b00010_0000000; 
      # 10
      in = 12'b11100_0100000;
   end

endmodule