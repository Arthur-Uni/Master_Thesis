%cleanup
clear;
clc;
close all;

%interval [a,b]
a = 0;
b = 8;
S = 1; %number of segments
%degree of polynomial
%n = 3;

%plotting parameters
width = 1;
%points to plot
dots = linspace(a,b);

%function to approximate and Chebyshev polynomial approximation
y = tanh(dots);

%parameters
max_degree = 10;
min_degree = 1;
degree_size = max_degree - min_degree +1;       %number of degree steps

max_abs_error = zeros(1,max_degree);
mean_squ_error = zeros(1,max_degree);
C = zeros(1,10);    %number of coefficients

for n=min_degree:max_degree
    p = cheb_poly_approx(a, b, n, 0);
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
legend('N = 1');
hold on;
grid on;
grid minor;

subplot(2,1,2);
plot(C, mean_squ_error, 'linewidth', width);
xlabel('degree n of polynomial');
ylabel('mean squared error');
legend('N = 1');
hold on;
grid on;
grid minor;