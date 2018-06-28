module hybrid_tb();

   localparam W_IN = 8;      // input wordlength
   localparam W_OUT = 9;     // output wordlength
   localparam IN_I = 3;      // # number of input integer bits
   
   reg                      clock;
   reg                      resetn;
   reg    [W_IN-1:0]        in;
   wire   [W_OUT-1:0]       out;
   
   hybrid DUT (
      .clock(clock),
      .resetn(resetn),
      .in(in),
      .out(out)
   );
   defparam
      DUT.W_IN = W_IN,
      DUT.W_OUT = W_OUT,
      DUT.IN_I = IN_I;
      
   // generate clock signal
   initial begin 
      clock = 1;
      forever begin
         #5 clock = ~clock;
      end 
   end
   
   initial begin
      resetn = 1;
      # 10 resetn = 0;
      resetn = 1; in = 8'b000_10001;
      # 10 in = 8'b001_10001;
      # 10 in = 8'b000_00011;
   end  

endmodule