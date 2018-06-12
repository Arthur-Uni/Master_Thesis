function [ y, LUT_Entries ] = sc1( x, NoE, x_fractionlength )

%% divide input into segments
x_lin_logical = (abs(x) <= 0.5);
x_lin = x_lin_logical .* x;

x_sat_logical = (abs(x) > 2.5);
x_sat = x_sat_logical .* (1 - 2^-x_fractionlength);

temp1 = abs(x) > 0.5;
temp2 = abs(x) <= 2.5;
x_LUT_logical = (temp1 .* temp2);
% x_LUT = x_LUT_logical .* x;

%% parameter
a = 0.5;
b = 2.5;

signed = 0;
wordlength = 8;
fractionlength = 8;
x_start = 0.5;
y_start = 0.5;
offset = x_start;

%% create LUT
[ LUT, LUT_EvaluationPoints, LUT_StepSize ] = createLUT(a, b, x_start, y_start, NoE, signed, wordlength, fractionlength);
LUT_Entries = LUT;
%% calculate outputs
y_lin = x_lin;
y_sat = abs(x_sat) .* sign(x);
y_LUT = calculateLUTPLA(x, LUT, LUT_StepSize, 0, 0, a, b, offset) .* x_LUT_logical;

%% bring everything together
y = (y_lin + y_sat + y_LUT);

end

