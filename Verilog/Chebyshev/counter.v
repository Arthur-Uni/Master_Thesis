module counter(clock, resetn, enable, out);

   parameter   COUNT_FROM;
   parameter   DATA_WIDTH;
   parameter   COUNT_TO;

   input                         clock;
   input                         resetn;
   
   input                         enable;

   output reg [DATA_WIDTH-1:0]   out;
   
   always @(posedge clock or negedge resetn)
      begin
         if(!resetn)
            begin
               out <= COUNT_FROM;
            end
         else if(enable && out < COUNT_TO)
            begin
               out <= out + 1;
            end
         else
            begin
               out <= out;
            end
      end
   
endmodule