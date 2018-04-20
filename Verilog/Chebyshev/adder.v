module adder(clock, resetn, in_a, in_b, out);

   parameter WL_A;   //word length of in_a
   parameter WL_B;   //word length of in_b
   
   // WIDENING = ceil(ld(degree of polynomial + 1))
   parameter WIDENING;
   
   //adder widening: wordlength of output is wordlength of bigger input wordlength + ceil(ld(degree of polynomial + 1))
   localparam WL_OUT = (WL_A>WL_B)? WL_A+WIDENING : WL_B+WIDENING;

   input                      clock;
   input                      resetn;

   input  [WL_A-1:0]          in_a;
   input  [WL_B-1:0]          in_b;

   output [WL_OUT-1:0]          out;
   
   reg signed [WL_A-1:0]      a_reg;
   reg signed [WL_B-1:0]      b_reg;

   reg  signed [WL_OUT-1:0]     out_reg;
   
   wire signed [WL_OUT-1:0]     adder_out;
   
   assign adder_out = a_reg + b_reg;
   assign out = out_reg;
   
   always @(posedge clock or negedge resetn)
      begin if(!resetn)
         begin
            a_reg     <= {WL_A{1'b0}};
            b_reg     <= {WL_B{1'b0}};
            out_reg   <= {WL_OUT{1'b0}};
         end else
         begin
            a_reg     <= in_a;
            b_reg     <= in_b;
            out_reg   <= adder_out;
         end
      end

endmodule