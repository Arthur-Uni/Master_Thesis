%% cleanup
clear;
close all;
clc;

%%
x = -6:2^-12:6;

[y, LUT_entries] = sc1(x, 4);

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

subplot(3,1,1);
hold on;
plot(x, t, 'LineWidth', width);
plot(x, y, 'LineWidth', width);
xlabel('x', 'FontSize', fontSize);
ylabel('f(x)', 'FontSize', fontSize);
set(gca, 'FontSize', fontSize);

subplot(3,1,2);
plot(x, abs_error, 'LineWidth', width);
xlabel('x', 'FontSize', fontSize);
ylabel('absolute error', 'FontSize', fontSize);
set(gca, 'FontSize', fontSize);

subplot(3,1,3);
plot(x, rel_error, 'LineWidth', width);
xlabel('x', 'FontSize', fontSize);
ylabel('relative error', 'FontSize', fontSize);
set(gca, 'FontSize', fontSize);