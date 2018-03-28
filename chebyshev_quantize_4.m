% %cleanup
% clear;
% clc;
% close all;

%interval [a,b]
a1 = 0;
b1 = 2;
a2 = 2;
b2 = 4;
a3 = 4;
b3 = 6;
a4 = 6;
b4 = 8;
S = 4; %number of segments

%degree of polynomial
%n = 3;

%plotting parameters
width = 1;
%points to plot
dots1 = a1:0.01:b1;
dots2 = a2:0.01:b2;
dots3 = a3:0.01:b3;
dots4 = a4:0.01:b4;

%function to approximate and Chebyshev polynomial approximation
y1 = tanh(dots1);
y2 = tanh(dots2);
y3 = tanh(dots3);
y4 = tanh(dots4);
y = [y1, y2, y3, y4];

max_abs_error = zeros(1,10);
mean_squ_error = zeros(1,10);
C = zeros(1,10); %number of coefficients

hold on;
grid on;
grid minor;

for n=1:10
    p1 = cheb_poly_approx(a1, b1, n);
    p2 = cheb_poly_approx(a2, b2, n);
    p3 = cheb_poly_approx(a3, b3, n);
    p4 = cheb_poly_approx(a4, b4, n);
    p = [p1, p2, p3, p4];
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
legend('N = 4');
hold on;
grid on;
grid minor;

subplot(2,1,2);
plot(C, mean_squ_error, 'linewidth', width);
xlabel('degree n of polynomial');
ylabel('mean squared error');
legend('N = 4');
hold on;
grid on;
grid minor;