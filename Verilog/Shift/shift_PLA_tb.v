module shift_PLA_tb();

   localparam W_IN = 12;      // input wordlength
   localparam W_OUT = 8;     // output wordlength
   localparam IN_I = 5;      // # number of input integer bits
   localparam BOUNDARY;  // # position of relevant MSB for shift operation, otherwise output is asymptotic bound of tanh (+1,-1)

//   input                        clock;
//   input                        resetn;

   reg       [ W_IN-1:0 ]       in;

   wire        [ W_OUT-1:0 ]    out;

   shift_PLA DUT (
//      .clock(clock),
//      .resetn(resetn),
      .in(in),
      .out(out)
   );

endmodule