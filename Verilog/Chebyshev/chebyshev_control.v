module chebyshev_control(clock, resetn, data_in, data_out, sink_ready,, sink_valid, source_ready, source_valid);

// parameter for chebyshev_control module

   parameter   WL;                     // input wordlength
   parameter   CL;                     // Chebyshev coefficients wordlength
   parameter   S;                      // number of segments
   parameter   n;                      // degree of polymial
   parameter   O_BITS;                 // output wordlength (after rounding and truncating)
   localparam  COUNT_BITS = 3;         // number of bits needed to count to n: ceil(ld2(n))
   localparam  MEM_BITS = S*(n+1)*CL;  // number of memory bits

// parameters for chebyshev_saturation module

   parameter   I_BITS;                 // number of integer bits
   parameter   BOUNDARY_BIT_POSITION;  // at which bit to saturate
   localparam  SAT_OUT = WL - (I_BITS - BOUNDARY_BIT_POSITION); // output wordlength for saturation module

// parameters for chebyshev_computation module   
   
   parameter   COMP_WIDENING;          // adder output wordlength widening = ceil(ld(degree of polynomial)) for computational module
   localparam  COMP_OUT = 2*WL + CL + COMP_WIDENING;  // output wordlength of computation module
   localparam  COMP_IN = WL-I_BITS;     // input wordlength for computational module -> only fractional bits of chebyshev_saturation module out
   
   
   input                            clock;
   input                            resetn;
   input       [WL-1:0]             data_in;
   output      [O_BITS-1:0]         data_out;
   
   // control signals
   
   input                            sink_valid;
   output                           sink_ready;
   
   input                            source_ready;
   output                           source_valid;
   
// strucutral coding
   
   // chebyshev coefficients
   reg         [MEM_BITS-1:0]       cheb_coeffs;
   
   // saturation module
   reg                              sign_bit;
   wire        [SAT_OUT-1:0]        sat_output;
   
   //computation module
   wire        [COMP_IN-1:0]        comp_in;
   wire        [CL-1:0]             coeff_in;
   wire        [COMP_OUT-1:0]       comp_out;
   
   //counter module
   wire        [COUNT_BITS-1:0]     counter_out;
   
   // control signals
   
   /* only process data if this module is ready and if the data this module
   receives is valid*/
   wire                             sink_really_valid;
   
   assign sink_really_valid = sink_valid && sink_ready;
   
   chebyshev_saturation sat(
      .data_in(data_in),
      .data_out(sat_output)
   );
   
   defparam 
      sat.WL = WL,
      sat.I_BITS = I_BITS,
      sat.BOUNDARY_BIT_POSITION = BOUNDARY_BIT_POSITION; 
   
   chebyshev_computation_v2 comp(
      .clock(clock),
      .resetn(resetn),
      .data_in(comp_in),
      .coeff_in(coeff_in),
      .data_out(comp_out)
   );
   
   defparam
      comp.WL = COMP_IN,
      comp.CL = CL,
      comp.WIDENING = COMP_WIDENING;
   
   counter c(
      .clock(clock),
      .resetn(resetn),
      .out(counter_out)
   );
   
   defparam
      c.COUNT_FROM = 0,
      c.DATA_WIDTH = COUNT_BITS,
      c.COUNT_TO = n;
   
   // assign only fractional bits of sat_output to comp_in
   assign comp_in = sat_output[WL-I_BITS-1:0];

endmodule