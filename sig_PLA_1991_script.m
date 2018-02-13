%cleanup
clear;
clc;
close all;

%parameter

width = 1;
x = -5:0.01:5;
xp = 0:0.01:5;
xn = -5:0.01:0;
sig = sig(x);

%negative x
yn = sig_PLA_1991(xn);

%positive x
yp = fliplr(1-yn);

%combined
yn(401) =[];
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
legend('sigmoid','approx')
grid on;
grid minor;
title('PLA (1991)');

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