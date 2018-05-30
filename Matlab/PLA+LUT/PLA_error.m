%% cleanup
clear;
clc;
close all;

x = 0:(4/500):4;

y = PLA(x);
y = fi(y, false, 8,8);
y = double(y);
t = tanh(x);

abs_error = abs(t-y);
max_abs_error = max(abs_error);

rel_error = abs_error ./ t;

temp1 = x <= 0.25;
temp2 = temp1 ~= 1;

LUT_entries = temp2 .* abs_error;

LUT_entries = fi(LUT_entries, false, 4, 4);
LUT_entries = double(LUT_entries);

y1 = temp1 .* x;
y2 = temp2 .* (y - LUT_entries);

y = y1 + y2;