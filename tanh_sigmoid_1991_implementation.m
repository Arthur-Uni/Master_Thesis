%cleanup
clear;
clc;
close all;

%parameter

width = 1.5;
x = -6:0.01:6;
xp = 0:0.01:6;
xn = -6:0.01:0;
thyp = tanh(x);

%negative x
yn = 2.*sig_PLA_1991(2.*xn)-1;

%positive x
yp = -fliplr(yn);

%combined
yn(601) =[];
y = [yn, yp];

%absolute error
error = abs(thyp-y);
max_error = max(error);
mean_error = mean(error);

%relative error
rel_error = error./thyp;

%plot
figure(1);
plot(x,thyp, x,y, 'linewidth', width);
legend('tanh','approximation')
grid on;
grid minor;
title('Shift Approximation');