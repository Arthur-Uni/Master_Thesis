module shift_PLA(clock, resetn, in, out);

/*
PLA approximation for the tanh function using only shift operations and bit manipulations
input form:   in = x^n ... x^0 . x^-1 x^-2 ...

for negative inputs:

   output form: out =           1 . 1 x^-2 x^-3 ...
                                 -> shifted right by the amount of the input integer part
                                 and fractional part is filled with zeros

for positive inputs:
   
   output form: out =           0 . 1 0 x^-2 x^-3 ...
                                 -> shifted right by the amount of the input integer part
                                 and fractional part is filled with ones
*/

parameter W_IN;      // input wordlength
parameter W_OUT;     // output wordlength
parameter IN_I;      // # number of input integer bits
parameter IN_F;      // # number of input fractional bits
parameter OUT_F;     // # number of output fractional bits -> determines accuracy
parameter BOUNDARY;  // # position of relevant MSB for shift operation, otherwise output is asymptotic bound of tanh (+1,-1)

localparam I_INDEX = W_IN - IN_I;
localparam SAT_BITS = W_IN - BOUNDARY;

input                        clock;
input                        resetn;

input       [ W_IN-1:0 ]     in;

output      [ W_OUT-1:0 ]    out;

wire        [ IN_I-1:0 ]     integer_part;
wire        [ IN_F-1:0 ]     fractional_part;
wire signed [ IN_F-1:0 ]     temp; // this is needed to obtain the correct form before the shifting
wire                         sign_bit;
wire        [ OUT_F-1:0 ]    temp_shift_result;
wire        [ W_OUT-1:0 ]    shift_result;   // integer bit restored
wire        [ SAT_BITS:0 ]   shift_amount;   // >> shift_amount with widening of 1 bit to accomodate for left shift
wire                         saturation;
wire        [ IN_I-1:0]      twos_complement;

// divide input into integer and fractional part and keep sign bit
assign sign_bit = in[W_IN-1];
assign integer_part = in[W_IN-1:I_INDEX];
assign fractional_part = in[I_INDEX-1:0];

// perform shift operation
assign shift_amount = in[SAT_BITS:I_INDEX] << 1; // input integer part times 2
assign temp = (sign_bit == 1'b1) ? { 1'b1, fractional_part[I_INDEX-2:0] } : { 1'b1, 1'b0, fractional_part[I_INDEX-2:1] };
assign temp_shift_result = (sign_bit == 1'b0) ? temp >>> shift_amount : temp >> shift_amount; // >> -> binary shift; >>> -> arithmetic shift

// check if output is forced to asymptotic bounds
assign twos_complement = (sign_bit == 1'b1) ? ~integer_part + 1 : { {IN_I{1'b0}} };
assign saturation = (sign_bit == 1'b0 && integer_part[IN_I-2:0]> 3'd4) ? 1 : (sign_bit == 1'b1 && twos_complement > 3'd4) ? 1 : 0;

// build output
assign shift_result = { sign_bit, temp_shift_result };
/*
if saturation bit is set and input is negative, saturate to -1
else if saturation bit is set and inout is positive, saturate to ~1
else out = shift_result
*/
assign out = (saturation == 1'b1 && sign_bit == 1'b1) ? { sign_bit, {W_OUT-2{1'b0}} } : (saturation == 1'b1 && sign_bit == 1'b0) ? { sign_bit, {W_OUT-2{1'b1}} } : shift_result;

endmodule