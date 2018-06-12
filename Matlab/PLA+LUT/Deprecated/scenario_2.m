%% cleanup
clear;
close all;
clc;

%% input
x = linspace(-6,6,16001);

%% divide input into segments
x_lin_logical = (abs(x) <= 0.5);
x_lin = x_lin_logical .* x;

x_sat_logical = (abs(x) > 4);
x_sat = x_sat_logical .* x;

% 1st LUT segment 0.5 < x <= 1;
temp1 = abs(x) > 0.5;
temp2 = abs(x) <= 1;
x_LUT_1_logical = (temp1 .* temp2);
x_LUT_1 = x_LUT_1_logical .* x;

% 2nd LUT segment 1 < x <= 3
temp1 = abs(x) > 1;
temp2 = abs(x) <= 3;
x_LUT_2_logical = (temp1 .* temp2);
x_LUT_2 = x_LUT_2_logical .* x;

% 3rd LUT segment 3 < x <= 4
temp1 = abs(x) > 3;
temp2 = abs(x) <= 4;
x_LUT_3_logical = (temp1 .* temp2);
x_LUT_3 = x_LUT_3_logical .* x;

%% parameter

wordlength = 8;
fractionlength = wordlength;
signed = 0;

% 1st segment
a_1 = 0.5;
b_1 = 1;
NoE_1 = 4;
offset_1 = 0.5;

% 2nd segment
a_2 = 1;
b_2 = 3;
NoE_2 = 4;
offset_2 = 1;

% 3rd segment
a_3 = 3;
b_3 = 4;
NoE_3 = 2;
offset_3 = 3;

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

%% calculate outputs
y_lin = x_lin;
y_sat = double(x_sat_logical) .* sign(x);
y_LUT_1 = calculateLUT(x_LUT_1, LUT_1, LUT_EvaluationPoints_1, LUT_StepSize_1, offset_1) .* x_LUT_1_logical;
y_LUT_2 = calculateLUT(x_LUT_2, LUT_2, LUT_EvaluationPoints_2, LUT_StepSize_2, offset_2) .* x_LUT_2_logical;
y_LUT_3 = calculateLUT(x_LUT_3, LUT_3, LUT_EvaluationPoints_3, LUT_StepSize_3, offset_3) .* x_LUT_3_logical;

%% bring everything together
y = (y_lin + y_sat + y_LUT_1 + y_LUT_2 + y_LUT_3);

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