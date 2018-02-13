%cleanup
clear;
clc;
close all;

%parameter
alpha = 1;
width = 1;
x = -5:0.01:5;
ELU = ELU(x, alpha);

%function
y = ELU_base_two(x, alpha);

%absolute error
error = abs(ELU-y);
max_error = max(error);
mean_error = mean(error);

%relative error
rel_error = error./ELU;

%plot
figure(1);
subplot(3,1,1);
plot(x,ELU, x,y, 'linewidth', width);
legend('ELU','approx')
grid on;
grid minor;
title('ELU base two (2016)');

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