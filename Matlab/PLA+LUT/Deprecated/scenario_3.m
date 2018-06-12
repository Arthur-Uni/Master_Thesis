%% cleanup
clear;
close all;
clc;

%% input
x = linspace(-6,6,16001);

%% divide input into segments
x_lin_logical = (abs(x) <= 0.25);
x_lin = x_lin_logical .* x;

x_sat_logical = (abs(x) > 4);
x_sat = x_sat_logical .* x;

% 1st LUT segment 0.25 < x <= 5;
temp1 = abs(x) > 0.25;
temp2 = abs(x) <= 0.5;
x_LUT_1_logical = (temp1 .* temp2);
x_LUT_1 = x_LUT_1_logical .* x;

% 2nd LUT segment 0.5 < x <= 1
temp1 = abs(x) > 0.5;
temp2 = abs(x) <= 1;
x_LUT_2_logical = (temp1 .* temp2);
x_LUT_2 = x_LUT_2_logical .* x;

% 3rd LUT segment 1 < x <= 2
temp1 = abs(x) > 1;
temp2 = abs(x) <= 2;
x_LUT_3_logical = (temp1 .* temp2);
x_LUT_3 = x_LUT_3_logical .* x;

% 4th LUT segment 2 < x <= 3
temp1 = abs(x) > 2;
temp2 = abs(x) <= 3;
x_LUT_4_logical = (temp1 .* temp2);
x_LUT_4 = x_LUT_4_logical .* x;

% 5th LUT segment 3 < x <= 4
temp1 = abs(x) > 3;
temp2 = abs(x) <= 4;
x_LUT_5_logical = (temp1 .* temp2);
x_LUT_5 = x_LUT_5_logical .* x;

%% parameter

wordlength = 16;
fractionlength = wordlength;
signed = 0;

% 1st segment
a_1 = 0.25;
b_1 = 0.5;
NoE_1 = 4;
offset_1 = 0.25;

% 2nd segment
a_2 = 0.5;
b_2 = 1;
NoE_2 = 4;
offset_2 = 0.5;

% 3rd segment
a_3 = 1;
b_3 = 2;
NoE_3 = 8;
offset_3 = 1;

% 4th segment
a_4 = 2;
b_4 = 3;
NoE_4 = 8;
offset_4 = 2;

% 5th segment
a_5 = 3;
b_5 = 4;
NoE_5 = 2;
offset_5 = 3;
%% create LUT

% 1st segment
[LUT_1, LUT_EvaluationPoints_1, LUT_StepSize_1] = createLUT(a_1, b_1, NoE_1, signed, wordlength, fractionlength);
LUT_entries_1 = fi(LUT_1, signed, wordlength, fractionlength);

% 2nd segment
[LUT_2, LUT_EvaluationPoints_2, LUT_StepSize_2] = createLUT(a_2, b_2, NoE_2, signed, wordlength, fractionlength);
LUT_entries_2 = fi(LUT_2, signed, wordlength, fractionlength);

% 3rd segment
[LUT_3, LUT_EvaluationPoints_3, LUT_StepSize_3] = createLUT(a_3, b_3, NoE_3, signed, wordlength, fractionlength);
LUT_entries_3 = fi(LUT_3, signed, wordlength, fractionlength);

% 4th segment
[LUT_4, LUT_EvaluationPoints_4, LUT_StepSize_4] = createLUT(a_4, b_4, NoE_4, signed, wordlength, fractionlength);
LUT_entries_4 = fi(LUT_4, signed, wordlength, fractionlength);

% 5th segment
[LUT_5, LUT_EvaluationPoints_5, LUT_StepSize_5] = createLUT(a_5, b_5, NoE_5, signed, wordlength, fractionlength);
LUT_entries_5 = fi(LUT_5, signed, wordlength, fractionlength);

%% calculate outputs
y_lin = x_lin;
y_sat = double(x_sat_logical) .* sign(x);
y_LUT_1 = calculateLUT(x_LUT_1, LUT_1, LUT_EvaluationPoints_1, LUT_StepSize_1, offset_1) .* x_LUT_1_logical;
y_LUT_2 = calculateLUT(x_LUT_2, LUT_2, LUT_EvaluationPoints_2, LUT_StepSize_2, offset_2) .* x_LUT_2_logical;
y_LUT_3 = calculateLUT(x_LUT_3, LUT_3, LUT_EvaluationPoints_3, LUT_StepSize_3, offset_3) .* x_LUT_3_logical;
y_LUT_4 = calculateLUT(x_LUT_4, LUT_4, LUT_EvaluationPoints_4, LUT_StepSize_4, offset_4) .* x_LUT_4_logical;
y_LUT_5 = calculateLUT(x_LUT_5, LUT_5, LUT_EvaluationPoints_5, LUT_StepSize_5, offset_5) .* x_LUT_5_logical;

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