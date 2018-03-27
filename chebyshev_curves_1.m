% %cleanup
% clear;
% clc;
% close all;

%interval [a,b]
a = 0;
b = 8;
%degree of polynomial
%n = 3;

%plotting parameters
width = 1;
%points to plot
dots = a:0.01:b;

%function to approximate and Chebyshev polynomial approximation
y = tanh(dots);

max_abs_error = zeros(1,10);
mean_squ_error = zeros(1,10);

for n=1:10
    p = cheb_poly_approx(a, b, n);
    abs_error = max(abs(y-p));
    max_abs_error(n) = abs_error;
    mean_squ_error(n) = immse(double(y), double(p));
end

figure(1);
subplot(2,1,1);
plot(1:10, max_abs_error, 'linewidth', width);
xlabel('degree n of polynomial');
ylabel('max abs error');
legend('N = 1');
hold on;
grid on;
grid minor;

subplot(2,1,2);
plot(1:10, mean_squ_error, 'linewidth', width);
xlabel('degree n of polynomial');
ylabel('mean squared error');
legend('N = 1');
hold on;
grid on;
grid minor;