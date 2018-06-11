function [ y, LUT_entries ] = sc1( x, NoE )

%% divide input into segments
x_lin_logical = (abs(x) <= 0.5);
x_lin = x_lin_logical .* x;

x_sat_logical = (abs(x) > 2.5);
x_sat = x_sat_logical .* x;

temp1 = abs(x) > 0.5;
temp2 = abs(x) <= 2.5;
x_LUT_logical = (temp1 .* temp2);
x_LUT = x_LUT_logical .* x;

%% parameter
a = 0.5;
b = 2.5;
signed = 0;
wordlength = 8;
fractionlength = wordlength;
offset = 0.5;

%% create LUT

[LUT, LUT_EvaluationPoints, LUT_StepSize] = createLUT(a, b, NoE, signed, wordlength, fractionlength);
LUT_entries = fi(LUT, signed, wordlength, fractionlength);

%% calculate outputs
y_lin = x_lin;
y_sat = double(x_sat_logical) .* sign(x);
y_LUT = calculateLUT(x_LUT, LUT, LUT_EvaluationPoints, LUT_StepSize, offset) .* x_LUT_logical;

%% bring everything together
y = (y_lin + y_sat + y_LUT);
end

