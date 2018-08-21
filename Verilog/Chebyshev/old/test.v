module test();
 
  reg signed [7:0] x;
  reg[7:0] y;
  
  reg[7:0] z;
  reg[7:0] w;
 
  initial 
	begin
    x =8'b11100000;
	 y =8'b00000001;
    z = x >>> y;
    w = x >> y;
	end
 
endmodule