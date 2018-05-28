module chebyshev_saturation (data_in, data_out);
   
// parameters and local parameters

   parameter   WL;  //wordlength
   parameter   I_BITS; //# integer bits
   parameter   BOUNDARY_BIT_POSITION; // at which bit to saturate
   
   localparam  O_BITS = WL - (I_BITS - BOUNDARY_BIT_POSITION); // remaining output bits with unnecessary integer bits removed
   localparam  F_BITS = WL - I_BITS;
// input and output declaration
   
   input       [WL-1:0]       data_in;
   output      [O_BITS-1:0]   data_out;
   
// register and wire declaration
   
   wire        [I_BITS-1:0]   integer_part;
   wire        [F_BITS-1:0]   fractional_part;
   wire        [I_BITS-1:0]   twos_complement;  // needed for saturation check
   
   wire                       sign_flag;
   
   wire                       saturation_flag;
   wire        [WL-1:0]       output_vector;
   
// structural coding
   
   assign integer_part = data_in[WL-1:I_BITS];
   assign fractional_part = data_in[F_BITS-1:0];
   
   /* check if saturation flag needs to be set;
      twos complement is needed for the case of negative inputs to check if it is bigger than the saturation bounds, in this case [-4;4]
   */
   assign twos_complement = (sign_flag == 1'b1) ? ~integer_part + 1 : { {I_BITS{1'b0}} };
   
   assign saturation_flag = (sign_flag == 1'b1 && twos_complement >= 4'd4 && fractional_part != { {F_BITS{1'b0}} }) ? 1 : (sign_flag == 1'b0 && integer_part >= 4'd4 && fractional_part != { {F_BITS{1'b0}} }) ? 1 : (sign_flag == 1'b0 && integer_part >= 4'd4 && fractional_part == { {F_BITS{1'b0}} }) ? 1 : 0;
   
   assign sign_flag = data_in[WL-1];
   
   /* if saturation and sign bit are set, saturate to biggest possible negative value (eg: input 110010_001110 -> saturation bit position = 3 -> output ---100_000000)
      or if saturation bit is set, but sign bit is not set, saturate to biggest possible positive value (eg: input 010010_001110 -> saturation bit position = 3 -> output ---011_111111)
      otherwise: output = input minus unnecessary input bits (eg: input 000010_001110 -> saturation bit position = 3 -> output ---010_001110)
   */
   assign output_vector = (saturation_flag == 1'b1 && sign_flag == 1'b1) ? { {I_BITS - BOUNDARY_BIT_POSITION {1'b1}}, {1'b1}, {WL - (I_BITS - BOUNDARY_BIT_POSITION + 1){1'b0}} }: (saturation_flag == 1'b1 && sign_flag == 1'b0) ? { {I_BITS - BOUNDARY_BIT_POSITION {1'b0}}, {1'b0}, {WL - (I_BITS - BOUNDARY_BIT_POSITION + 1){1'b1}} } : data_in;
   assign data_out = output_vector[O_BITS-1:0];
   
endmodule