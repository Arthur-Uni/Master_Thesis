% %cleanup
% clear;
% clc;
% close all;

%interval [a,b]
a1 = 0;
b1 = 4;
a2 = 4;
b2 = 8;
%degree of polynomial
%n = 3;

%plotting parameters
width = 1;
%points to plot
dots1 = a1:0.01:b1;
dots2 = a2:0.01:b2;

%function to approximate and Chebyshev polynomial approximation
y1 = tanh(dots1);
y2 = tanh(dots2);
y = [y1, y2];

max_abs_error = zeros(1,10);
mean_squ_error = zeros(1,10);

hold on;
grid on;
grid minor;

for n=1:10
    p1 = cheb_poly_approx(a1, b1, n);
    p2 = cheb_poly_approx(a2, b2, n);
    p = [p1, p2];
    abs_error = max(abs(y-p));
    max_abs_error(n) = abs_error;
    mean_squ_error(n) = immse(double(y), double(p));
end

figure(1);
subplot(2,1,1);
plot(1:10, max_abs_error, 'linewidth', width);
xlabel('degree n of polynomial');
ylabel('max abs error');
legend('N = 2');
hold on;
grid on;
grid minor;

subplot(2,1,2);
plot(1:10, mean_squ_error, 'linewidth', width);
xlabel('degree n of polynomial');
ylabel('mean squared error');
legend('N = 2');
hold on;
grid on;
grid minor;