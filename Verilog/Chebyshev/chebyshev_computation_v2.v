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

//   reg signed     [(WL+CL)-1:0]        adder_out_trim_reg;
   
   reg signed     [CL-1:0]             coeff;
   
   wire signed    [ADDER_OUT-1:0]      adder_out;
   wire signed    [ADDER_OUT-1:0]      coeff_shifted;
   wire signed    [ADDER_OUT-1:0]      adder_out_shifted;
   wire signed    [MULT_OUT -1:0]      mult_out;
   wire signed    [ADDER_OUT_TRIM-1:0] adder_out_trim;
   wire signed    [ADDER_OUT-1:0]      rounding;

   always @(posedge clock or negedge resetn)
      begin
         if(!resetn)
            begin
               in             <= {WL{1'b0}};
               out            <= {ADDER_OUT{1'b0}};
               coeff          <= {CL{1'b0}};
               temp           <= {MULT_OUT{1'b0}};
//               adder_out_trim_reg      <= {(WL+CL){1'b0}};
            end
         else
            begin
               in             <= data_in;
               coeff          <= coeff_in;
               temp           <= mult_out;
               out            <= out + adder_out;
//               adder_out_trim_reg <= adder_out_trim;
            end
      end
   
   // round half up: xxx.xxxx
   //   add 1/2 LSB +000.0010
   //                --------
   //                yyy.yyyx
   // truncate:      yyy.yy--
   
// assign mult_out            = in * adder_out_trim_reg;
   assign mult_out            = in * adder_out_trim;
   assign adder_out           = temp + coeff_shifted;
   assign coeff_shifted = coeff << (ADDER_OUT_TRIM-2);  //shift coefficient before adding
   assign adder_out_shifted = adder_out << 1;
   assign rounding = adder_out_shifted[ADDER_OUT-1:0] + {{(ADDER_OUT_TRIM){1'b0}}, 1'b1, {(ADDER_OUT-ADDER_OUT_TRIM-1){1'b0}} }; //add 1/2 lsb
   assign adder_out_trim = rounding[ADDER_OUT-1:(ADDER_OUT-ADDER_OUT_TRIM)];  //truncate result
   assign data_out = out;
   
endmodule