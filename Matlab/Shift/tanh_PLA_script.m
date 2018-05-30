%% cleanup
clear;
clc;
close all;

%% parameters

% set global fimath settings
globalfimath('OverflowAction','Saturate','RoundingMethod','Round');

a = -4;
b = 4;
dots = linspace(a,b);

width = 1.5;
fontSize = 16;

input_wordlength = 8;
input_fractionlength = input_wordlength - 3;

output_wordlength = 6;
% output_fractionlength is automatically set in tanh_PLA function

%% quantization
x = fi(dots, true, input_wordlength, input_fractionlength);

% x = double(x);

%% approximation
t = tanh(dots);
% [y, y_fixed] = tanh_PLA(dots, output_wordlength);
y = tanh_PLA(dots);
y_fixed = tanh_shift_v2(x, output_wordlength);

%% error calculation

% absolute error
abs_error = abs(t-y);
max_abs_error = max(abs_error);

abs_error_fixed = abs(t-y_fixed);
max_abs_error_fixed = max(abs_error_fixed);

%relative error
rel_error = abs_error./t;

rel_error_fixed = abs_error_fixed./t;

%% plot

figure(1);

hold on;
grid on;
plot(dots, y_fixed, 'LineWidth', 2*width);
% plot(dots, y, 'LineWidth', width);
% plot(dots, t, 'LineWidth', width);
xlabel('x', 'FontSize', fontSize);
ylabel('f(x)', 'FontSize', fontSize);
set(gca, 'FontSize', fontSize);
legend('q approx','approx','tanh(x)');