%cleanup
clear;
clc;
close all;

%interval [a,b]
a = -1;
b = 1;
%degree of polynomial
n = 3;

%plotting parameters
width = 1;
%points to plot
dots = a:0.01:b;

%function to approximate and Chebyshev polynomial approximation
y = tanh(dots);
p = cheb_poly_approx(a, b, n);

%absolute error
error = abs(y-p);
max_error = max(error);
mean_error = mean(error);

%relative error
rel_error = error./y;

%plot
hold on;
plot(dots, y);
plot(dots, p);

%plot
figure(1);
subplot(3,1,1);
plot(dots,y, dots,p, 'linewidth', width);
legend('tanh','Chebyshev polynomial approximation')
grid on;
grid minor;
title('Chebyshev Polynomial Approximation');

subplot(3,1,2);
plot(dots,error,'linewidth', width);
grid on;
grid minor;
title('absolute error');

subplot(3,1,3);
plot(dots,rel_error,'linewidth', width);
grid on;
grid minor;
title('relative error');