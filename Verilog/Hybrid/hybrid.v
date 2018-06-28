module hybrid(clock, resetn, in, out);

   parameter W_IN;      // input wordlength
   parameter W_OUT = 9;     // output wordlength
   parameter IN_I;      // # number of input integer bits
   
   localparam ABS_SIZE = W_IN - 1;     // size of the absolute value of the input after truncating to wanted size
   localparam IN_F = W_IN-IN_I;
   
   input                      clock;
   input                      resetn;
   input    [W_IN-1:0]        in;
   output   [W_OUT-1:0]       out;

   reg                        sign;
   reg      [W_OUT-1:0]       abs_out;
   wire     [W_IN-1:0]        abs_in;
   wire     [ABS_SIZE-1:0]    abs_in_cut;
   wire                       bypass;     //used to determine if output is determined by PLA or by LUT
   wire     [IN_I-1:0]        integer_part;
   wire     [IN_F-1:0]        fractional_part;
   wire     [W_OUT-1:0]       PLA_out;
   wire     [W_OUT-1:0]       LUT_out;
   
   assign abs_in = (sign == 1'b1) ? (~in + 1'b1) : in;   // build twos complement if input is a negative number
   assign abs_in_cut = abs_in[W_IN-2:0];     // truncate value to wanted length
   
   /*
   if input is smaller than 0.5 -> bypass = 1
   else if input is equal to 0.5 -> bypass = 1
   else -> bypass = 0
   
   */
   assign bypass = (fractional_part[IN_F-1] == 1'b0 && integer_part | { {IN_I{1'b0}} } == { {IN_I{1'b0}} }) ? 1 : (abs_in | { {IN_I{1'b0}}, 1'b1, {IN_F-1{1'b0}} } == { {IN_I{1'b0}}, 1'b1, {IN_F-1{1'b0}} } ) ? 1 : 0; 
   assign integer_part = abs_in[W_IN-1:IN_F];
   
   assign fractional_part = abs_in[IN_F-1:0];
   
   assign PLA_out = (sign == 1'b1) ? (~abs_out+1) : abs_out; // build twos complement of the result if input was negative
   
   assign LUT_out = (sign == 1'b1) ? { 1'b1, (~abs_out[7:0]+1) } : { sign, abs_out[7:0]};
   
   assign out = (bypass == 1'b1) ? PLA_out : LUT_out;
   
   always@(posedge clock or negedge resetn)
   begin
      if(!resetn)
         begin
            sign <= 1'b0;
         end
      else
         begin
            sign <= in[W_IN-1];
         end
   end
   
   always@(posedge clock or negedge resetn)
   begin
      if(!resetn)
         begin
            abs_out <= { {8{1'b0}} };
         end
      else if(!bypass)
         begin
            case(abs_in_cut)
               7'b0010001 : abs_out[7:0] = 8'b10000000;  
               7'b0010010 : abs_out[7:0] = 8'b10000000;  
               7'b0010011 : abs_out[7:0] = 8'b10000101;  
               7'b0010100 : abs_out[7:0] = 8'b10001011;  
               7'b0010101 : abs_out[7:0] = 8'b10010001;  
               7'b0010110 : abs_out[7:0] = 8'b10010110;  
               7'b0010111 : abs_out[7:0] = 8'b10011011;  
               7'b0011000 : abs_out[7:0] = 8'b10100000;  
               7'b0011001 : abs_out[7:0] = 8'b10100101;  
               7'b0011010 : abs_out[7:0] = 8'b10101010;  
               7'b0011011 : abs_out[7:0] = 8'b10101110;  
               7'b0011100 : abs_out[7:0] = 8'b10110010;  
               7'b0011101 : abs_out[7:0] = 8'b10110110;  
               7'b0011110 : abs_out[7:0] = 8'b10111010;  
               7'b0011111 : abs_out[7:0] = 8'b10111110;  
               7'b0100000 : abs_out[7:0] = 8'b11000001;  
               7'b0100001 : abs_out[7:0] = 8'b11000101;  
               7'b0100010 : abs_out[7:0] = 8'b11001000;  
               7'b0100011 : abs_out[7:0] = 8'b11001011;  
               7'b0100100 : abs_out[7:0] = 8'b11001110;  
               7'b0100101 : abs_out[7:0] = 8'b11010001;  
               7'b0100110 : abs_out[7:0] = 8'b11010011;  
               7'b0100111 : abs_out[7:0] = 8'b11010110;  
               7'b0101000 : abs_out[7:0] = 8'b11011000;  
               7'b0101001 : abs_out[7:0] = 8'b11011010;  
               7'b0101010 : abs_out[7:0] = 8'b11011100;  
               7'b0101011 : abs_out[7:0] = 8'b11011110;  
               7'b0101100 : abs_out[7:0] = 8'b11100000;  
               7'b0101101 : abs_out[7:0] = 8'b11100010;  
               7'b0101110 : abs_out[7:0] = 8'b11100100;  
               7'b0101111 : abs_out[7:0] = 8'b11100101;  
               7'b0110000 : abs_out[7:0] = 8'b11100111;  
               7'b0110001 : abs_out[7:0] = 8'b11101000;  
               7'b0110010 : abs_out[7:0] = 8'b11101010;  
               7'b0110011 : abs_out[7:0] = 8'b11101011;  
               7'b0110100 : abs_out[7:0] = 8'b11101100;  
               7'b0110101 : abs_out[7:0] = 8'b11101101;  
               7'b0110110 : abs_out[7:0] = 8'b11101111;  
               7'b0110111 : abs_out[7:0] = 8'b11110000;  
               7'b0111000 : abs_out[7:0] = 8'b11110001;  
               7'b0111001 : abs_out[7:0] = 8'b11110001;  
               7'b0111010 : abs_out[7:0] = 8'b11110010;  
               7'b0111011 : abs_out[7:0] = 8'b11110011;  
               7'b0111100 : abs_out[7:0] = 8'b11110100;  
               7'b0111101 : abs_out[7:0] = 8'b11110101;  
               7'b0111110 : abs_out[7:0] = 8'b11110101;  
               7'b0111111 : abs_out[7:0] = 8'b11110110;  
               7'b1000000 : abs_out[7:0] = 8'b11110111;  
               7'b1000001 : abs_out[7:0] = 8'b11110111;  
               7'b1000010 : abs_out[7:0] = 8'b11111000;  
               7'b1000011 : abs_out[7:0] = 8'b11111000;  
               7'b1000100 : abs_out[7:0] = 8'b11111001;  
               7'b1000101 : abs_out[7:0] = 8'b11111001;  
               7'b1000110 : abs_out[7:0] = 8'b11111001;  
               7'b1000111 : abs_out[7:0] = 8'b11111010;  
               7'b1001000 : abs_out[7:0] = 8'b11111010;  
               7'b1001001 : abs_out[7:0] = 8'b11111011;  
               7'b1001010 : abs_out[7:0] = 8'b11111011;  
               7'b1001011 : abs_out[7:0] = 8'b11111011;  
               7'b1001100 : abs_out[7:0] = 8'b11111011;  
               7'b1001101 : abs_out[7:0] = 8'b11111100;  
               7'b1001110 : abs_out[7:0] = 8'b11111100;  
               7'b1001111 : abs_out[7:0] = 8'b11111100;  
               7'b1010000 : abs_out[7:0] = 8'b11111100;
               default    : abs_out[7:0] = 8'b11111111;    //saturation
            endcase
         end
   end
      

endmodule