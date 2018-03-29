% %cleanup
% clear;
% clc;
% close all;
%interval [a,b]
a = 0;
b = 8;
S = 1;                                                  %number of segments
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
C = zeros(1,10);                                    %number of coefficients
N = zeros(1,10);                                    %memory utilization
mode = 1;                              %1 = fixed point, 2 = floating point

for n=1:10
    for wordlength = 4:2:32
    var = wordlength - 1;%mode = 1 => fractional part length; mode = 2 => length of exponent
    p = cheb_poly_approx(a, b, n, 1, mode, wordlength, var);
    abs_error = max(abs(y-p));
    max_abs_error(n) = abs_error;
    mean_squ_error(n) = immse(double(y), double(p));
    C(n) = (n+1)*S;
    N(n) = C(n) * wordlength;
    end
end

figure(1);
subplot(2,1,1);
plot(N, max_abs_error, 'linewidth', width);
xlabel('degree n of polynomial');
ylabel('max abs error');
legend('N = 1');
hold on;
grid on;
grid minor;

subplot(2,1,2);
plot(N, mean_squ_error, 'linewidth', width);
xlabel('degree n of polynomial');
ylabel('mean squared error');
legend('N = 1');
hold on;
grid on;
grid minor;