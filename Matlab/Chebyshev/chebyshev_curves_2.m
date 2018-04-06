%cleanup
clear;
clc;
close all;

%interval [a,b]
a1 = 0;
b1 = 4;
a2 = 4;
b2 = 8;
S = 2; %number of segments
%degree of polynomial
%n = 3;

%plotting parameters
width = 1;
%points to plot
dots1 = linspace(a1, b1);
dots2 = linspace(a2, b2);

%function to approximate and Chebyshev polynomial approximation
y1 = tanh(dots1);
y2 = tanh(dots2);
y = [y1, y2];

%parameters
max_degree = 10;
min_degree = 1;
degree_size = max_degree - min_degree +1;       %number of degree steps

max_abs_error = zeros(1,max_degree);
mean_squ_error = zeros(1,max_degree);
C = zeros(1,max_degree);

hold on;
grid on;
grid minor;

for n=min_degree:max_degree
    p1 = cheb_poly_approx(a1, b1, n, 0,0,0,0);
    p2 = cheb_poly_approx(a2, b2, n, 0,0,0,0);
    p = [p1, p2];
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
legend('N = 2');
hold on;
grid on;
grid minor;

subplot(2,1,2);
plot(C, mean_squ_error, 'linewidth', width);
xlabel('degree n of polynomial');
ylabel('mean squared error');
legend('N = 2');
hold on;
grid on;
grid minor;