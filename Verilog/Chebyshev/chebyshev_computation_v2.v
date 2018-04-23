module chebyshev_computation_v2(clock, resetn, data_in, coeff_in, data_out);

// ###################################
// # Module: computation module of chebyshev 
// # 			 polynomial approximation calculating
// #			 the chebyshev polynomial sequentially
// ###################################

   parameter WL;  //input word length
   parameter CL;  //coefficient length
   
   // WIDENING = ceil(ld(degree of polynomial))
   parameter WIDENING;
   
   localparam MULT_OUT = 2*WL + CL;
   localparam ADDER_OUT = MULT_OUT + WIDENING;
   localparam ADDER_OUT_TRIM = WL + CL;
   
   input                               clock;
   input                               resetn;

   input          [WL-1:0]             data_in;
   input          [CL-1:0]             coeff_in;

   output         [ADDER_OUT-1:0]      data_out;

   reg signed     [WL-1:0]             in;
   reg signed     [ADDER_OUT-1:0]      out;
   reg signed     [MULT_OUT-1:0]       temp;
   
   reg signed     [CL-1:0]             coeff;
   
   wire signed    [ADDER_OUT-1:0]      adder_out;
   wire signed    [ADDER_OUT-1:0]      coeff_shifted;
   wire signed    [ADDER_OUT-1:0]      adder_out_shifted;
   wire signed    [MULT_OUT -1:0]      mult_out;
   wire signed    [ADDER_OUT_TRIM-1:0] adder_out_trim;
   wire signed    [ADDER_OUT-1:0]      rounding;
   wire signed    [ADDER_OUT-1:0]      rounding_shifted;

   always @(posedge clock or negedge resetn)
      begin
         if(!resetn)
            begin
               in             <= {WL{1'b0}};
               out            <= {ADDER_OUT{1'b0}};
               coeff          <= {CL{1'b0}};
               temp           <= {MULT_OUT{1'b0}};
            end
         else
            begin
               in             <= data_in;
               coeff          <= coeff_in;
               temp           <= mult_out;
               out            <= adder_out;
            end
      end
   
   // construct shifted coefficient so that trimming of first addition can be done correctly:
   // size of coeff_shifted is the same as adder out with the format:
   // format:     0s                                        0                                         coeff                               0s
   // length:  WIDENING    add one zero, because adder_out has (3 + WIDENING) integer bits   now comes the coefficient           fill the rest with zeros
   //                               and coeff has only 2 integere bits by design                                           the size of the remaining fractional bits
   //                                                                                                                         (ADDER_OUT-WIDENING-(CL-2)-3)
   // check, if coeff_in is a negative number: if not, fill left of coeff with zeros, otherwise with ones
   assign coeff_shifted = (coeff_in[CL-1] == 1'b0) ? { {WIDENING{1'b0}}, 1'b0, coeff, {(ADDER_OUT-WIDENING-(CL-2)-3){1'b0}} } : { {WIDENING{1'b1}}, 1'b1, coeff, {(ADDER_OUT-WIDENING-(CL-2)-3){1'b0}} } ;
   
   // shift adder_out to the left to get the format: xxx.yyyyyyy
   assign adder_out_shifted = adder_out << WIDENING;
   
   // round half up: xxx.xxxx
   //   add 1/2 LSB +000.0010
   //                --------
   //                yyy.yyyx
   // truncate:      yyy.yy--
   assign rounding = adder_out_shifted[ADDER_OUT-1:0] + {1'b0, {(ADDER_OUT_TRIM){1'b0}}, 1'b1, {(ADDER_OUT-ADDER_OUT_TRIM-2){1'b0}} }; //add 1/2 lsb
   assign rounding_shifted = rounding << 1;
   assign adder_out_trim = rounding_shifted[ADDER_OUT-1:(ADDER_OUT-ADDER_OUT_TRIM)];  //truncate result
   
   assign mult_out            = in * adder_out_trim;
   assign adder_out           = temp + coeff_shifted;
   
   assign data_out = out;
   
endmodule