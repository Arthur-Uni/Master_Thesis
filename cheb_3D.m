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

%function to approximate
y1 = tanh(dots1);
y2 = tanh(dots2);
y3 = tanh(dots3);
y4 = tanh(dots4);
y = [y1, y2, y3, y4];

%parameters
max_degree = 10;
min_degree = 1;
degree_size = max_degree - min_degree +1;       %number of degree steps

min_word = 4;
max_word = 32;
word_size = ((max_word-min_word)/2) + 1;        %number of word steps
step_size = 2;

max_abs_error = zeros(degree_size,word_size);
mean_squ_error = zeros(degree_size,word_size);
C = zeros(degree_size,word_size);               %number of coefficients
N = zeros(degree_size,word_size);               %memory utilization

mode = 1;

%chebyshev approximations
for n=1:10
    for wordlength=min_word:step_size:max_word
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

%plot
figure(1)
s = surf(N,min_degree:max_degree, max_abs_error, log(max_abs_error));
xlabel('memory utilization in number of bits');
ylabel('computational effort in degree of polynomial');
zlabel('max absolute error');