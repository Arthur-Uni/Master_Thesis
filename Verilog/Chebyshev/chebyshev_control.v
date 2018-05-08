module chebyshev_control(clock, resetn, data_in, data_out, valid_output);

// parameter for chebyshev_control module

   parameter   WL;                     // input wordlength
   parameter   CL;                     // Chebyshev coefficients wordlength
   parameter   S;                      // number of segments
   parameter   O_BITS;                 // output wordlength (after rounding and truncating)

// parameters for chebyshev_saturation module

   parameter   I_BITS;                 // number of integer bits
   parameter   BOUNDARY_BIT_POSITION;  // at which bit to saturate
   localparam  SAT_OUT = WL - (I_BITS - BOUNDARY_BIT_POSITION); // output wordlength for saturation module

// parameters for chebyshev_computation module   
   
   parameter   COMP_WIDENING;          // adder output wordlength widening = ceil(ld(degree of polynomial)) for computational module
   localparam  COMP_OUT = 2*WL + CL + COMP_WIDENING;  // output wordlength of computation module
   localparam  COMP_IN = WL-IBITS;     // input wordlength for computational module -> only fractional bits of chebyshev_saturation module out
   
   
   input                      clock;
   input                      resetn;
   input       [WL-1:0]       data_in;
   output      [O_BITS-1:0]   data_out;
   
   output                     valid_output;
   
   // strucutral coding
   
   reg                        sign_bit;
   wire        [SAT_OUT-1:0]  sat_output;
   wire        [COMP_IN-1:0]  comp_in;
   wire        [CL-1:0]       coeff_in;
   wire        [COMP_OUT-1:0] comp_out;
   
   chebyshev_saturation sat(
      .data_in(data_in),
      .data_out(sat_output)
   );
   
   defparam sat.WL = WL,
            sat.I_BITS = I_BITS,
            sat.BOUNDARY_BIT_POSITION = BOUNDARY_BIT_POSITION; 
   
   chebyshev_computation_v2 comp(
      .clock(clock),
      .resetn(resetn),
      .data_in(comp_in),
      .coeff_in(coeff_in),
      .data_out(comp_out)
   );
   
   // assign only fractional bits of sat_output to comp_in
   assign comp_in = sat_output[WL-I_BITS-1:0];

endmodule