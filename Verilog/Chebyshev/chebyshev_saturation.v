module chebyshev_saturation (data_in, data_out);
   
// parameters and local parameters

   parameter WL;  //wordlength
   parameter I_BITS; //# integer bits
   parameter BOUNDARY_BIT_POSITION; // at which bit to saturate
   
   localparam O_BITS = WL - (I_BITS - BOUNDARY_BIT_POSITION); // remaining output bits with unnecessary integer bits removed
   
// input and output declaration
   
   input    [WL-1:0]       data_in;
   output   [O_BITS-1:0]   data_out;
   
// register and wire declaration
   
   wire     [I_BITS-1:0]   integer_part;
   
   wire                    sign_flag;
   
   wire                    saturation_flag;
   wire     [WL-1:0]       saturation;
   
   wire     [WL-I_BITS-1:0] test1;
   wire       [I_BITS-1:0]               test2;
   wire                     test3;
   
// structural coding
   
   assign integer_part = data_in[WL-1:I_BITS];
   
   /* check if saturation flag needs to be set: 
      if any of the integer bits left of the saturation bit are set (this includes the case, where the input is exactly the biggest possible negative saturation value) -> saturation_flag = 1
      or if input is exactly the biggest positive saturation value -> saturation_flag = 1
      or if input integer part is exactyl the biggest positive saturation value and has fractional bits which are unequal to 0 -> saturation_flag = 1
      otherwise: saturation_flag = 0
   */
   assign saturation_flag = ((integer_part[I_BITS-1:BOUNDARY_BIT_POSITION] ^ { {I_BITS-BOUNDARY_BIT_POSITION{1'b0}} } ) != 1'b0 ) ? 1 : (( { {I_BITS-BOUNDARY_BIT_POSITION{1'b0}}, {1'b1}, {WL - (I_BITS - BOUNDARY_BIT_POSITION + 1){1'b0}} } == data_in ) != 1'b0 ) ? 1 : ( ({ {I_BITS-BOUNDARY_BIT_POSITION{1'b0}}, {1'b1}, {BOUNDARY_BIT_POSITION-1{1'b0}} } == integer_part) && ( ({ {WL-I_BITS{1'b0}} } ^ data_in[WL-I_BITS-1:0]) != 1'b0)) ? 1 : 0;
   
   assign test1 = data_in[WL-I_BITS-1:0];
   assign test2 = { {I_BITS-BOUNDARY_BIT_POSITION{1'b0}}, {1'b1}, {BOUNDARY_BIT_POSITION-1{1'b0}} };
   assign test3 = ({ {I_BITS-BOUNDARY_BIT_POSITION-1{1'b0}}, {1'b1}, {I_BITS-BOUNDARY_BIT_POSITION{1'b0}} } == integer_part);
   
   assign sign_flag = data_in[WL-1];
   
   /* if saturation and sign bit are set, saturate to biggest possible negative value (eg: input 110010_001110 -> saturation bit position = 3 -> output ---100_000000)
      or if saturation bit is set, but sign bit is not set, saturate to biggest possible positive value (eg: input 010010_001110 -> saturation bit position = 3 -> output ---011_111111)
      otherwise: output = input minus unnecessary input bits (eg: input 000010_001110 -> saturation bit position = 3 -> output ---010_001110)
   */
   assign saturation = (saturation_flag == 1'b1 && sign_flag == 1'b1) ? { {I_BITS - BOUNDARY_BIT_POSITION {1'b1}}, {1'b1}, {WL - (I_BITS - BOUNDARY_BIT_POSITION + 1){1'b0}} }: (saturation_flag == 1'b1 && sign_flag == 1'b0) ? { {I_BITS - BOUNDARY_BIT_POSITION {1'b0}}, {1'b0}, {WL - (I_BITS - BOUNDARY_BIT_POSITION + 1){1'b1}} } : data_in;
   assign data_out = saturation[O_BITS-1:0];
   
endmodule