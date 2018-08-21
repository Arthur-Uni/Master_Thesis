module mult_tb();

parameter WL_A_TB = 4;   //word length of a_reg for testbench
parameter WL_B_TB = 5;   //word length of mult2 for testbench

localparam WL_OUT = WL_A + WL_B;

reg                  clock;
reg                  resetn;

reg  signed [WL_A_TB-1:0]   in_a;
reg  signed [WL_B_TB-1:0]   in_b;

wire signed [(WL_OUT-1):0]   out;

mult DUT(
      .clock(clock),
      .resetn(resetn),
      .in_a(in_a),
      .in_b(in_b),
      .out(out)
   );
   
   defparam
      DUT.WL_A = WL_A_TB,
      DUT.WL_B = WL_B_TB;

initial begin
   clock <= 1'b1;
   resetn <= 1'b1;
end

always @(posedge clock or negedge resetn)
begin
   #10 clock = ~clock;
   #10 clock = ~clock;
   resetn <= 1'b0;
   #10 clock = ~clock;
   #10 clock = ~clock;
   resetn <= 1'b1;
   #10 clock = ~clock;
   #10 clock = ~clock;
   in_a = 4'b0010;
   in_b = 5'b10001;
   #10 clock = ~clock;
	#10 clock = ~clock;
   in_a = 4'b1111;
   in_b = 5'b11111;
	#10 clock = ~clock;
   #10 clock = ~clock;
   in_a = 4'b1000;
   in_b = 5'b10101;
	#10 clock = ~clock;
	#10 clock = ~clock;
	#10 clock = ~clock;
end

endmodule