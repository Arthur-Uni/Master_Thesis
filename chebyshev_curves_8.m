% %cleanup
% clear;
% clc;
% close all;

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
%degree of polynomial
%n = 3;

%plotting parameters
width = 1;
%points to plot
dots1 = a1:0.01:b1;
dots2 = a2:0.01:b2;
dots3 = a3:0.01:b3;
dots4 = a4:0.01:b4;
dots5 = a5:0.01:b5;
dots6 = a6:0.01:b6;
dots7 = a7:0.01:b7;
dots8 = a8:0.01:b8;

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

max_abs_error = zeros(1,10);
mean_squ_error = zeros(1,10);

hold on;
grid on;
grid minor;

for n=1:10
    p1 = cheb_poly_approx(a1, b1, n);
    p2 = cheb_poly_approx(a2, b2, n);
    p3 = cheb_poly_approx(a3, b3, n);
    p4 = cheb_poly_approx(a4, b4, n);
    p5 = cheb_poly_approx(a5, b5, n);
    p6 = cheb_poly_approx(a6, b6, n);
    p7 = cheb_poly_approx(a7, b7, n);
    p8 = cheb_poly_approx(a8, b8, n);
    p = [p1, p2, p3, p4, p5, p6, p7, p8];
    abs_error = max(abs(y-p));
    max_abs_error(n) = abs_error;
    mean_squ_error(n) = immse(double(y), double(p));
end

figure(1);
subplot(2,1,1);
plot(1:10, max_abs_error, 'linewidth', width);
xlabel('degree n of polynomial');
ylabel('max abs error');
legend('N = 8');
hold on;
grid on;
grid minor;

subplot(2,1,2);
plot(1:10, mean_squ_error, 'linewidth', width);
xlabel('degree n of polynomial');
ylabel('mean squared error');
legend('N = 8');
hold on;
grid on;
grid minor;