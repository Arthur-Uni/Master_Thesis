// ###################################
// # Module: computation module of chebyshev 
// # 			 polynomial approximation calculating
// #			 the chebyshev polynomial sequentially
// ###################################

module chebyshev_computation(clock, resetn, data_in, coeff_in, data_out);

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

   mult m (
      .clock(clock),
      .resetn(resetn),
      .in_a(in),
      .in_b(adder_out_trim),
      .out(mult_out)
   );
   
   defparam
      m.WL_A = WL,
      m.WL_B = WL + CL;
   
   adder a (
      .clock(clock),
      .resetn(resetn),
      .in_a(mult_out),
      .in_b(coeff_shifted),
      .out(adder_out)
   );
   
   defparam
      a.WL_A = MULT_OUT,
      a.WL_B = ADDER_OUT,
      a.WIDENING = WIDENING;

   always @(posedge clock or negedge resetn)
      begin
         if(!resetn)
            begin
               in             <= {WL{1'b0}};
               out            <= {WL{1'b0}};
               coeff          <= {WL{1'b0}};
               temp           <= {WL{1'b0}};
            end
         else
            begin
               in             <= data_in;
               coeff          <= coeff_in;
               temp           <= mult_out;
               out            <= adder_out;
            end
      end
   
   // round half up: xxx.xxxx
   //   add 1/2 LSB +000.0010
   //                --------
   //                yyy.yyyx
   // truncate:      yyy.yy--
   
   assign coeff_shifted = coeff << (ADDER_OUT_TRIM-1);  //shift coefficient before adding
   assign adder_out_shifted = adder_out << 1;
   assign rounding = adder_out_shifted[ADDER_OUT-1:0] + {{(ADDER_OUT_TRIM){1'b0}}, 1'b1, {(ADDER_OUT-ADDER_OUT_TRIM-1){1'b0}} }; //add 1/2 lsb
   assign adder_out_trim = rounding[ADDER_OUT-1:(ADDER_OUT-ADDER_OUT_TRIM)];  //truncate result
   assign data_out = out;
   
endmodule