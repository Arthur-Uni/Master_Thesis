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
width = 1.5;
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

max_abs_error = zeros(10,15);
mean_squ_error = zeros(10,15);
C = zeros(10,15);
N = zeros(10,15);
mode = 1;

for n=1:10
    for wordlength=4:2:32
        i = 0.5*wordlength - 1;
        var = wordlength - 2;
        p1 = cheb_poly_approx(a1, b1, n, 1, mode, wordlength, var);
        p2 = cheb_poly_approx(a2, b2, n, 1, mode, wordlength, var);
        p3 = cheb_poly_approx(a3, b3, n, 1, mode, wordlength, var);
        p4 = cheb_poly_approx(a4, b4, n, 1, mode, wordlength, var);
        p = [p1, p2, p3, p4];
        abs_error = max(abs(y-p));
        max_abs_error(n, i) = abs_error;
        mean_squ_error(n, i) = immse(double(y), double(p));
        C(n, i) = (n+1)*S;
        N(n, i) = C(n)*wordlength;
        i = i+1;
    end
end

figure(1)

subplot(2,1,1);
s = surf(N,1:10, max_abs_error, log(max_abs_error));
xlabel('memory utilization');
ylabel('computational effort');
zlabel('max absolute error');
hold on;
grid on;
grid minor;