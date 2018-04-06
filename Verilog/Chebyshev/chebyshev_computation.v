// ###################################
// # Module: computation module of chebyshev 
// # 			 polynomial approximation calculating
// #			 the chebyshev polynomial sequentially
// ###################################

module ids_chebyshev_computation(clock, resetn, data_in, coeff_in, data_out)

parameter WORD_LENGTH  = 16;
parameter COEFF_LENGTH = 16;

input    clock;
input    resetn;

input    [WORD_LENGTH-1:0]    data_in;
input    [COEFF_LENGTH-1:0]   coeff_in;

output   [WORD_LENGTH-1:0]    data_out;

reg      [WORD_LENGTH-1:0]    in;
reg      [WORD_LENGTH-1:0]    out;

reg      [COEFF_LENGTH-1:0]   coeff;
reg      [COEFF_LENGTH-1:0]   coeff_buffer;

always @(posedge clock or negedge resetn)
   begin
      if(!resetn)
         begin
            in             <= {WORD_LENGTH{1'b0}};
            out            <= {WORD_LENGTH{1'b0}};
            coeff          <= {WORD_LENGTH{1'b0}};
            coeff_buffer   <= {WORD_LENGTH{1'b0}};
         end
      else
         begin
            in <= data_in;
            coeff_buffer <= coeff_in;
            coeff_buffer <= coeff;
         end
   end

endmodule