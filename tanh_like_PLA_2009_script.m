%cleanup
clear;
clc;
close all;

%parameter

width = 1;

x = -6:0.01:6;

n = 1;

%function
y = tanh_like_PLA_2009(x, n);

t = T(x, n);

tanh = tanh(x);

%absolute error

error = abs(t-y);
max_error = max(error);
mean_error = mean(error);

%relative error

rel_error = error./t;

%plot
figure(1);
subplot(3,1,1);
plot(x,tanh, x,t, x,y, 'linewidth', width);
legend('tanh', 'tanh-like; n = 0','approx; n = 0')
grid on;
grid minor;
title('tanh-like PLA (2007)');

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