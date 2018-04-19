// ###################################
// # Module: computation module of chebyshev 
// # 			 polynomial approximation calculating
// #			 the chebyshev polynomial sequentially
// ###################################

module chebyshev_computation(clock, resetn, data_in, coeff_in, data_out);

   parameter WORD_LENGTH  = 16;
   parameter COEFF_LENGTH = 16;
   
   // WIDENING = ceil(ld(degree of polynomial))
   localparam WIDENING = 2;
   
   localparam MULT_OUT = 2*WORD_LENGTH + COEFF_LENGTH;
   localparam ADDER_OUT = MULT_OUT + WIDENING;
   localparam ADDER_OUT_TRIM = WORD_LENGTH + COEFF_LENGTH;
   
   input    clock;
   input    resetn;

   input    [WORD_LENGTH-1:0]    data_in;
   input    [COEFF_LENGTH-1:0]   coeff_in;

   output   [WORD_LENGTH-1:0]    data_out;

   reg      [WORD_LENGTH-1:0]    in;
   reg      [ADDER_OUT-1:0]      out;
   reg      [MULT_OUT-1:0]       temp;

   reg      [COEFF_LENGTH-1:0]   coeff;
   
   wire     [ADDER_OUT-1:0]      adder_out;
   wire     [ADDER_OUT_TRIM-1:0] adder_out_trim;
   wire     [ADDER_OUT_TRIM:0]   rounding;

   mult m (
      .clock(clock),
      .resetn(resetn),
      .in_a(in),
      .in_b(adder_out_trim),
      .out(temp)
   );
   
   adder a (
      .clock(clock),
      .resetn(resetn),
      .in_a(mult_out),
      .in_b(coeff),
      .out(adder_out)
   );

   always @(posedge clock or negedge resetn)
      begin
         if(!resetn)
            begin
               in             <= {WORD_LENGTH{1'b0}};
               out            <= {WORD_LENGTH{1'b0}};
               coeff          <= {WORD_LENGTH{1'b0}};
               temp           <= {WORD_LENGTH{1'b0}};
            end
         else
            begin
               in <= data_in;
               coeff <= coeff_in;
               out <= data_out;
            end
      end
   
   // round half up: xxx.xxxx
   //   add 1/2 LSB +000.0010
   //                --------
   //                yyy.yyyx
   // truncate:      yyy.yy--
   
   assign rounding = adder_out[ADDER_OUT-1:0] + {{(ADDER_OUT_TRIM){1'b0}}, 1'b1, {(ADDER_OUT-ADDER_OUT_TRIM-1){1'b0}} }; //add 1/2 lsb
   assign adder_out_trim = rounding[ADDER_OUT-1:(ADDER_OUT-ADDER_OUT_TRIM)];  //truncate result
   
endmodule