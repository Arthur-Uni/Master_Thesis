%% cleanup
clear;
close all;
clc;

%% inputs
x_fractionlength = 12;
x = -4:2^-x_fractionlength:4;

NoE_1 = 2;
NoE_2 = 4;
NoE_3 = 4;
NoE_4 = 2;
NoE_5 = 2;

%% calculate outputs and get LUT entries
[ y, LUT_Entries ] = sc3(x, NoE_1, NoE_2, NoE_3, NoE_4, NoE_5, x_fractionlength);

%% error calculations
t = tanh(x);
abs_error = abs(t-y);
rel_error = abs_error ./ t;
mse = 1/numel(t) .* sum((t-y).^2);

%% plot

% parameters
width = 2;
fontSize = 14;

figure(1)

% subplot(3,1,1);
hold on;
plot(x, t, 'LineWidth', width);
plot(x, y, 'LineWidth', width);
xlabel('x', 'FontSize', fontSize);
ylabel('f(x)', 'FontSize', fontSize);
set(gca, 'FontSize', fontSize);

% subplot(3,1,2);
% plot(x, abs_error, 'LineWidth', width);
% xlabel('x', 'FontSize', fontSize);
% ylabel('absolute error', 'FontSize', fontSize);
% set(gca, 'FontSize', fontSize);
% 
% subplot(3,1,3);
% plot(x, rel_error, 'LineWidth', width);
% xlabel('x', 'FontSize', fontSize);
% ylabel('relative error', 'FontSize', fontSize);
% set(gca, 'FontSize', fontSize);