%cleanup
clear;
clc;
close all;

%parameter

width = 1.5;
fontSize = 16;
x_ticks = -4:4;

x = linspace(-4,4, 199);
xp = linspace(0,4);
xn = linspace(-4,0);
sig = tanh(x);

%negative x
yn = 2.*sig_PLA_1991(2.*xn) - 1;

%positive x
yp = -1.*fliplr(yn);

%combined
yn(100) = [];
y = [yn, yp];

%absolute error
error = abs(sig-y);
max_error = max(error);
mean_error = mean(error);

%relative error
rel_error = error./sig;

%plot
figure(1);
subplot(3,1,1);
plot(x,sig, x,y, 'linewidth', width);
legend('tanh','approx')
grid on;
grid minor;
title('PLA (1991)');
xlabel('x', 'FontSize', fontSize);
ylabel('y(x)', 'FontSize', fontSize);
set(gca, 'XTick', x_ticks, 'FontSize', fontSize);

subplot(3,1,2);
plot(x,error,'linewidth', width);
grid on;
grid minor;
title('absolute error');
xlabel('x', 'FontSize', fontSize);
ylabel('absolute error', 'FontSize', fontSize);
set(gca, 'XTick', x_ticks, 'FontSize', fontSize);

subplot(3,1,3);
plot(x,rel_error,'linewidth', width);
grid on;
grid minor;
title('relative error');
xlabel('x', 'FontSize', fontSize);
ylabel('relative error', 'FontSize', fontSize);
set(gca, 'XTick', x_ticks, 'FontSize', fontSize);