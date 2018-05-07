module chebyshev_control(clock, resetn, data_in, data_out, sink_ready, sink_valid, source_ready, source_valid);

// parameter for chebyshev_control module

   parameter   WL;                 // input wordlength
   parameter   CL;                 // Chebyshev coefficients wordlength
   parameter   S;                  // number of segments
   parameter   O_BITS;             // output wordlength (after rounding and truncating)

// parameters for chebyshev_saturation module

   localparam  SAT_IN = WL;        // input wordlength for saturation module
   parameter   SAT_OUT;            // output wordlength for saturation module
   parameter   I_BITS;             // number of integer bits

// parameters for chebyshev_computation module   

   localparam  COMP_IN = WL-IBITS; // input wordlength for computational module -> only fractional bits of chebyshev_saturation module out
   parameter   COMP_WIDENING;      // adder output wordlength widening = ceil(ld(degree of polynomial)) for computational module
   
   input                      clock;
   input                      resetn;
   input       [WL-1:0]       data_in;
   output      [O_BITS-1:0]   data_out;
   

endmodule