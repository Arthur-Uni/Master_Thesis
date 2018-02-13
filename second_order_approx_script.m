%cleanup
clear;
clc;
close all;

%parameter

width = 1;
x = -4:0.01:4;
sig = sig(x);

%function
y = second_order_approx(x);

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
legend('sigmoid','approx')
grid on;
grid minor;
title('second order approximation');

subplot(3,1,2);
plot(x,error,'linewidth', width);
grid on;
grid minor;
title('absolute error');

subplot(3,1,3);
plot(x,rel_error,'linewidth', width);
grid on;
grid minor;
title('relative error');