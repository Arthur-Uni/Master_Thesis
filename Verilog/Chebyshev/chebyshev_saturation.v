module chebyshev_saturation (data_in, data_out);
   parameter WL;  //wordlength
   parameter I_BITS; //# integer bits
   parameter BOUNDARY_BIT_POSITION; // at which bit to saturate
   
   
   input    [WL-1:0]       data_in;
   output   [WL-1:0]       data_out;
   
   wire     [I_BITS-1:0]   integer_part;
   
   wire                    sign_flag;
   wire     [WL-1:0]       sign_extension;
   
   wire                    saturation_flag;
   wire     [WL-1:0]       saturation;
   
   wire     [I_BITS-BOUNDARY_BIT_POSITION-1:0]   test;
   
   assign integer_part = data_in[WL-1:I_BITS];
   
   assign saturation_flag = ((integer_part[I_BITS-1:BOUNDARY_BIT_POSITION] ^ { {I_BITS-BOUNDARY_BIT_POSITION{1'b0}} } ) != { {I_BITS-BOUNDARY_BIT_POSITION{1'b0}} }) ? 1 : 0;
   assign test = (integer_part[I_BITS-1:BOUNDARY_BIT_POSITION] ^ { {I_BITS-BOUNDARY_BIT_POSITION{1'b0}} } );
   assign sign_flag = data_in[WL-1];
   assign saturation = (saturation_flag == 1'b1 && sign_flag == 1'b1) ? {{I_BITS{1'b1}}, {WL-I_BITS{1'b0}} } : {{I_BITS-1{1'b0}}, 1'b1, {WL-I_BITS{1'b0}} };
   assign data_out = (saturation_flag == 1'b1) ? saturation : data_in;
   
endmodule