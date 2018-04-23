clc;
clear;

c2 = 0.5;
c1 = 0.5;
c0 = 0;

c2 = fi(c2, true, 4,2);
c1 = fi(c1, true, 4,2);
c0 = fi(c0, true, 4,2);

c2_shifted = fi(c2, true, 13, 9);
c1_shifted = fi(c1, true, 13, 9);
c0_shifted = fi(c0, true, 13, 9);

x = 0.5;

x = fi(x, true, 4,3);
x
x.bin

adder_out0 = c2_shifted;
adder_out0
adder_out0.bin
adder_out_trim0 = fi(adder_out0, true, 8,6);
adder_out_trim0
adder_out_trim0.bin

mult_out0 = adder_out_trim0 * x;
mult_out0
mult_out0.bin

adder_out1 = mult_out0 + c1;
adder_out1
adder_out1.bin
adder_out_trim1 = fi(adder_out1, true, 8,6);
adder_out_trim1
adder_out_trim1.bin

mult_out1 = adder_out_trim1 * x;
mult_out1
mult_out1.bin

adder_out2 = mult_out1 + c0;
adder_out2
adder_out2.bin
adder_out_trim2 = fi(adder_out2, true, 8,6);
adder_out_trim2
adder_out_trim2.bin