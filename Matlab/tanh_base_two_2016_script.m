%cleanup
clear;
clc;
close all;

%parameter

width = 1;
x = -5:0.01:5;
t = tanh(x);

%function
y = 1 - 2.* sig_base_two_2016(-2.*x);

%absolute error
error = abs(t-y);
max_error = max(error);
mean_error = mean(error);

%relative error
rel_error = error./t;

%plot
figure(1);
subplot(3,1,1);
plot(x,t, x,y, 'linewidth', width);
legend('tanh','approx')
grid on;
grid minor;
title('tanh base two (2016)');

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