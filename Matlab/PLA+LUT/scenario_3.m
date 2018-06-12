%% cleanup
clear;
close all;
clc;

%% inputs
x_fractionlength = 12;
x = -6:2^-x_fractionlength:6;

%% divide input into segments
x_lin_logical = (abs(x) <= 0.25);
x_lin = x_lin_logical .* x;

x_sat_logical = (abs(x) > 4);
x_sat = x_sat_logical .* (1 - 2^-x_fractionlength);

% 1st LUT segment 0.25 < x <= 5;
temp1 = abs(x) > 0.25;
temp2 = abs(x) <= 0.5;
x_LUT_1_logical = (temp1 .* temp2);
% x_LUT_1 = x_LUT_1_logical .* x;

% 2nd LUT segment 0.5 < x <= 1
temp1 = abs(x) > 0.5;
temp2 = abs(x) <= 1;
x_LUT_2_logical = (temp1 .* temp2);
% x_LUT_2 = x_LUT_2_logical .* x;

% 3rd LUT segment 1 < x <= 2
temp1 = abs(x) > 1;
temp2 = abs(x) <= 2;
x_LUT_3_logical = (temp1 .* temp2);
% x_LUT_3 = x_LUT_3_logical .* x;

% 4th LUT segment 2 < x <= 3
temp1 = abs(x) > 2;
temp2 = abs(x) <= 3;
x_LUT_4_logical = (temp1 .* temp2);
% x_LUT_4 = x_LUT_4_logical .* x;

% 5th LUT segment 3 < x <= 4
temp1 = abs(x) > 3;
temp2 = abs(x) <= 4;
x_LUT_5_logical = (temp1 .* temp2);
% x_LUT_5 = x_LUT_5_logical .* x;

%% parameter

wordlength = 8;
fractionlength = wordlength;
signed = 0;

% 1st segment
a_1 = 0.25;
b_1 = 0.5;
x_start_1 = 0.25;
y_start_1 = 0.25;
offset_1 = x_start_1;
NoE_1 = 4;

% 2nd segment
a_2 = 0.5;
b_2 = 1;
x_start_2 = 0.5;
y_start_2 = tanh(x_start_2);
offset_2 = x_start_2;
NoE_2 = 4;

% 3rd segment
a_3 = 1;
b_3 = 2;
x_start_3 = 1;
y_start_3 = tanh(x_start_3);
offset_3 = x_start_3;
NoE_3 = 4;

% 4th segment
a_4 = 2;
b_4 = 3;
x_start_4 = 2;
y_start_4 = tanh(x_start_4);
offset_4 = x_start_4;
NoE_4 = 4;

% 5th segment
a_5 = 3;
b_5 = 4;
x_start_5 = 3;
y_start_5 = tanh(x_start_5);
offset_5 = x_start_5;
NoE_5 = 4;

%% create LUTs
[ LUT_1 LUT_EvaluationPoints_1, LUT_StepSize_1] = createLUT(a_1, b_1, x_start_1, y_start_1, NoE_1, signed, wordlength, fractionlength);
[ LUT_2 LUT_EvaluationPoints_2, LUT_StepSize_2] = createLUT(a_2, b_2, x_start_2, y_start_2, NoE_2, signed, wordlength, fractionlength);
[ LUT_3 LUT_EvaluationPoints_3, LUT_StepSize_3] = createLUT(a_3, b_3, x_start_3, y_start_3, NoE_3, signed, wordlength, fractionlength);
[ LUT_4 LUT_EvaluationPoints_4, LUT_StepSize_4] = createLUT(a_4, b_4, x_start_4, y_start_4, NoE_4, signed, wordlength, fractionlength);
[ LUT_5 LUT_EvaluationPoints_5, LUT_StepSize_5] = createLUT(a_5, b_5, x_start_5, y_start_5, NoE_5, signed, wordlength, fractionlength);

%% calculate outputs
y_lin = abs(x_lin) .* sign(x);
y_sat = abs(x_sat) .* sign(x);
y_LUT_1 = calculateLUTPLA(x, LUT_1, LUT_StepSize_1, 0, 0, a_1, b_1, offset_1) .* x_LUT_1_logical;
y_LUT_2 = calculateLUTPLA(x, LUT_2, LUT_StepSize_2, 0, 0, a_2, b_2, offset_2) .* x_LUT_2_logical;
y_LUT_3 = calculateLUTPLA(x, LUT_3, LUT_StepSize_3, 0, 0, a_3, b_3, offset_3) .* x_LUT_3_logical;
y_LUT_4 = calculateLUTPLA(x, LUT_4, LUT_StepSize_4, 0, 0, a_4, b_4, offset_4) .* x_LUT_4_logical;
y_LUT_5 = calculateLUTPLA(x, LUT_5, LUT_StepSize_5, 0, 0, a_5, b_5, offset_5) .* x_LUT_5_logical;

%% bring everything together
y = (y_lin + y_sat + y_LUT_1 + y_LUT_2 + y_LUT_3 + y_LUT_4 + y_LUT_5);

%% plot
% parameters
width = 2;
fontSize = 14;

figure(1)
hold on;
grid on;

plot(x, tanh(x), 'LineWidth', width);
plot(x, y, 'LineWidth', width);
xlabel('wordlength', 'FontSize', fontSize);
ylabel('error quotient', 'FontSize', fontSize);
set(gca, 'FontSize', fontSize);