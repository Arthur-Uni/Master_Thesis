module counter_tb();

   localparam   COUNT_FROM = 0;
   localparam   DATA_WIDTH = 2;
   localparam   COUNT_TO = 3;

   reg                         clock;
   reg                         resetn;
   
   reg                         enable;

   wire     [DATA_WIDTH-1:0]   out;
   
   counter DUT(
      .clock(clock),
      .resetn(resetn),
      .enable(enable),
      .out(out)
   );
   
   defparam
      DUT.COUNT_FROM = COUNT_FROM,
      DUT.DATA_WIDTH = DATA_WIDTH,
      DUT.COUNT_TO = COUNT_TO;
   
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
      # 10 resetn = 1; enable = 1;
      # 10 enable = 0;
      # 10 
      # 10 enable = 1;
   end

endmodule