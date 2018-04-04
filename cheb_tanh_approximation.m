%cleanup
clear;
clc;
close all;

%parameter

width = 1.5;
x = -6:0.01:6;
a = -6;
b = 6;
n = 20;
thyp = tanh(x);

%chebyshev approximations
y = cheb_poly_approx(a,b,n,0,0,0,0);

%plot
plot(x,thyp, x,y, 'linewidth', width);
legend('tanh','approximation')
grid on;
grid minor;
title('Chebyshev Approximation');