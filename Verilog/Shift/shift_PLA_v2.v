module shift_PLA_v2(clock, resetn, in, out);
/*
PLA approximation for the tanh function using only shift operations and bit manipulations
input form:   in = x^n ... x^0 . x^-1 x^-2 ...

for negative inputs:

   output form: out =           1 . 1 x^-2 x^-3 ...
                                 -> shifted right by the amount of the input integer part
                                 and fractional part is filled with zeros

for positive inputs:
   
   output form: out =           0 . 0 x^-2 x^-3 ...
                                 -> shifted right by the amount of the input integer part
                                 and fractional part is filled with ones
*/

   parameter W_IN;      // input wordlength
   parameter W_OUT;     // output wordlength
   parameter IN_I;      // # number of input integer bits
   parameter BOUNDARY;  // # position of relevant MSB for shift operation, otherwise output is asymptotic bound of tanh (+1,-1)

   localparam IN_F = W_IN - IN_I;      // # number of input fractional bits
   localparam OUT_F = W_OUT - 1;       // # number of output fractional bits -> determines accuracy
   localparam SAT_BITS = W_IN - BOUNDARY;
   localparam F_ADDITIONAL = (IN_F < OUT_F) ? OUT_F - IN_F : 0; 
   localparam F_BITS = (IN_F > OUT_F ) ? IN_F - OUT_F - 1 : 0;

   input                        clock;
   input                        resetn;

   input       [ W_IN-1:0 ]     in;

   output      [ W_OUT-1:0 ]    out;

   wire        [ IN_F-1:0 ]     fractional_part;
   wire signed [ OUT_F:0 ]      temp; // this is needed to obtain the correct form before the shifting
   wire                         sign_bit;
   wire signed [ OUT_F-1:0 ]    temp_shift_result;
   wire        [ W_OUT-1:0 ]    shift_result;
   wire        [ W_IN-1:0 ]     shift_amount_temp;
   wire        [ IN_I-1:0 ]     shift_amount;
   wire        [ W_IN-1:0 ]     twos_complement;
   reg         [ W_IN-1:0 ]     reg_in;
   reg         [ W_OUT-1:0 ]    reg_out;
   
   always @(posedge clock or negedge resetn)
      begin
         if(!resetn)
            begin
               reg_in <= { {W_IN{1'b0}} };
               reg_out <= { {W_OUT{1'b0}} };
            end
         else
            begin
               reg_in <= in;
               reg_out <= out;
            end
      end

// divide input into integer and fractional part and keep sign bit
   assign sign_bit = reg_in[W_IN-1];
   assign fractional_part = reg_in[IN_F-1:0];

// perform shift operation
   assign shift_amount_temp = (sign_bit == 1'b1) ? twos_complement << 1 : reg_in << 1; // input * 2
   assign shift_amount = shift_amount_temp[W_IN-1 : (W_IN-IN_I)]; // take only integer bits
   
   //a trick is used to use arithmetic shift for positive inputs, that's why the structure is {1, 0, fractional_part, additional} instead of {0, fractional_part, additional}
   assign temp = (sign_bit == 1'b1) ? { 1'b1, fractional_part[IN_F-2:F_BITS], {F_ADDITIONAL{1'b0}} } : { 1'b1, 1'b0, fractional_part[IN_F-2:F_BITS], {F_ADDITIONAL{1'b0}} };
   assign temp_shift_result = (sign_bit == 1'b0) ? temp >>> shift_amount : temp >> shift_amount; // >> -> binary shift ( no sign extension); >>> -> arithmetic shift (sign extension)

   assign twos_complement = (sign_bit == 1'b1) ? ~reg_in + 1 : { {W_IN{1'b0}} };

// build output
   assign shift_result = { sign_bit, temp_shift_result[OUT_F-1:0] };  // integer bit restored
/*
if saturation bit is set and input is negative, saturate to -1
else if saturation bit is set and input is positive, saturate to ~1
else out = shift_result
*/
   assign out = shift_result;

endmodule