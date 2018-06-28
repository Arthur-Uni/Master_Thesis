module hybrid(clock, resetn, in, out)

   parameter W_IN;
   parameter W_OUT;
   
   localparam 

   input                clock;
   input                resetn;
   input  [W_IN-1:0]    in;
   output [W_OUT-1:0]   out;

   reg                  sign;
   reg [W_OUT-1:0]      abs_out;
   wire [W_IN-1:0]      abs_in;
   wire []
   
   
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
      if(!resten)
         begin
            abs_out <= { {W_OUT{1'b0}} };
         end
      else
         begin
            case()
         end
   end
      

endmodule