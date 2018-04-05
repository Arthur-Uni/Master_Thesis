%cleanup
clear;
clc;
close all;

%interval [a,b]
a1 = 0;
b1 = 1;
a2 = 1;
b2 = 2;
a3 = 2;
b3 = 3;
a4 = 3;
b4 = 4;
a5 = 4;
b5 = 5;
a6 = 5;
b6 = 6;
a7 = 6;
b7 = 7;
a8 = 7;
b8 = 8;
S = 8;   %number of segments
%degree of polynomial
%n = 3;

%plotting parameters
width = 1;
%points to plot
dots1 = linspace(a1,b1);
dots2 = linspace(a2,b2);
dots3 = linspace(a3,b3);
dots4 = linspace(a4,b4);
dots5 = linspace(a5,b5);
dots6 = linspace(a6,b6);
dots7 = linspace(a7,b7);
dots8 = linspace(a8,b8);

%function to approximate and Chebyshev polynomial approximation
y1 = tanh(dots1);
y2 = tanh(dots2);
y3 = tanh(dots3);
y4 = tanh(dots4);
y5 = tanh(dots5);
y6 = tanh(dots6);
y7 = tanh(dots7);
y8 = tanh(dots8);
y = [y1, y2, y3, y4, y5, y6, y7, y8];

%parameters
max_degree = 10;
min_degree = 1;
degree_size = max_degree - min_degree +1;       %number of degree steps

max_abs_error = zeros(1,max_degree);
mean_squ_error = zeros(1,max_degree);
C = zeros(1,max_degree);

for n=min_degree:max_degree
    p1 = cheb_poly_approx(a1, b1, n,0,0,0,0);
    p2 = cheb_poly_approx(a2, b2, n,0,0,0,0);
    p3 = cheb_poly_approx(a3, b3, n,0,0,0,0);
    p4 = cheb_poly_approx(a4, b4, n,0,0,0,0);
    p5 = cheb_poly_approx(a5, b5, n,0,0,0,0);
    p6 = cheb_poly_approx(a6, b6, n,0,0,0,0);
    p7 = cheb_poly_approx(a7, b7, n,0,0,0,0);
    p8 = cheb_poly_approx(a8, b8, n,0,0,0,0);
    p = [p1, p2, p3, p4, p5, p6, p7, p8];
    abs_error = max(abs(y-p));
    max_abs_error(n) = abs_error;
    mean_squ_error(n) = immse(double(y), double(p));
    C(n) = (n+1)*S;
end

figure(1);
subplot(2,1,1);
plot(C, max_abs_error, 'linewidth', width);
xlabel('degree n of polynomial');
ylabel('max abs error');
legend('N = 8');
hold on;
grid on;

subplot(2,1,2);
plot(C, mean_squ_error, 'linewidth', width);
xlabel('degree n of polynomial');
ylabel('mean squared error');
legend('N = 8');
hold on;
grid on;