%% cleanup
clear;
close all;
clc;

%% inputs
x_fractionlength = 12;
x = -6:2^-x_fractionlength:6;

NoE_1 = 2;
NoE_2 = 2;
NoE_3 = 1;

signed = 0;
wordlength = 8;
fractionlength = 8;

a_1 = 0.5;
b_1 = 1;
x_start_1 = 0.5;
y_start_1 = 0.5;
offset_1 = x_start_1;

a_2 = 1;
b_2 = 3;
x_start_2 = 1;
y_start_2 = tanh(x_start_2);
offset_2 = x_start_2;

a_3 = 3;
b_3 = 4;
x_start_3 = 3;
y_start_3 = tanh(x_start_3);
offset_3 = x_start_3;

%% create LUTs
[ LUT_1 LUT_EvaluationPoints_1, LUT_StepSize_1] = createLUT(a_1, b_1, x_start_1, y_start_1, NoE_1, signed, wordlength, fractionlength);
[ LUT_2 LUT_EvaluationPoints_2, LUT_StepSize_2] = createLUT(a_2, b_2, x_start_2, y_start_2, NoE_2, signed, wordlength, fractionlength);
[ LUT_3 LUT_EvaluationPoints_3, LUT_StepSize_3] = createLUT(a_3, b_3, x_start_3, y_start_3, NoE_3, signed, wordlength, fractionlength);

%% create logical matrices for each segment
% linear region
x_lin_logical = (abs(x) <= 0.5);
x_lin = x_lin_logical .* x;

% saturation region
x_sat_logical = (abs(x) > 4);
x_sat = x_sat_logical .* (1 - 2^-x_fractionlength);

% 1st LUT segment 0.5 < x <= 1;
temp1 = abs(x) > 0.5;
temp2 = abs(x) <= 1;
x_LUT_1_logical = (temp1 .* temp2);
% x_LUT_1 = x_LUT_1_logical .* x;

% 2nd LUT segment 1 < x <= 3
temp1 = abs(x) > 1;
temp2 = abs(x) <= 3;
x_LUT_2_logical = (temp1 .* temp2);
% x_LUT_2 = x_LUT_2_logical .* x;

% 3rd LUT segment 3 < x <= 4
temp1 = abs(x) > 3;
temp2 = abs(x) <= 4;
x_LUT_3_logical = (temp1 .* temp2);
% x_LUT_3 = x_LUT_3_logical .* x;

%% calculate outputs
y_lin = abs(x_lin) .* sign(x);
y_sat = abs(x_sat) .* sign(x);
y_LUT_1 = calculateLUTPLA(x, LUT_1, LUT_StepSize_1, 0, 0, a_1, b_1, offset_1) .* x_LUT_1_logical;
y_LUT_2 = calculateLUTPLA(x, LUT_2, LUT_StepSize_2, 0, 0, a_2, b_2, offset_2) .* x_LUT_2_logical;
y_LUT_3 = calculateLUTPLA(x, LUT_3, LUT_StepSize_3, 0, 0, a_3, b_3, offset_3) .* x_LUT_3_logical;

%% bring everything together
y = (y_lin + y_sat + y_LUT_1 + y_LUT_2 + y_LUT_3);