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
dots1 = linspace(a1, b1);
dots2 = linspace(a2, b2);
dots3 = linspace(a3, b3);
dots4 = linspace(a4, b4);

%function to approximate and Chebyshev polynomial approximation
y1 = tanh(dots1);
y2 = tanh(dots2);
y3 = tanh(dots3);
y4 = tanh(dots4);
y = [y1, y2, y3, y4];

max_degree = 10;
min_degree = 3;
degree_size = max_degree - min_degree +1;       %number of degree steps

min_word = 8;
max_word = 12;
word_size = ((max_word-min_word)/2) + 1;        %number of word steps
step_size = 2;

max_abs_error = zeros(degree_size,word_size);
mean_squ_error = zeros(degree_size,word_size);
C = zeros(degree_size,word_size);                                    %number of coefficients
N = zeros(degree_size,word_size);                                    %memory utilization
mode = 1;

for n=min_degree:max_degree
    j = n-2;
    for wordlength=min_word:step_size:max_word
        i = 0.5*wordlength - 3;
        var = wordlength - 2;
        p1 = cheb_poly_approx(a1, b1, n, 1, mode, wordlength, var);
        p2 = cheb_poly_approx(a2, b2, n, 1, mode, wordlength, var);
        p3 = cheb_poly_approx(a3, b3, n, 1, mode, wordlength, var);
        p4 = cheb_poly_approx(a4, b4, n, 1, mode, wordlength, var);
        p = [p1, p2, p3, p4];
        abs_error = max(abs(y-p));
        max_abs_error(j, i) = abs_error;
        mean_squ_error(j, i) = immse(double(y), double(p));
        C(j, i) = (n+1)*S;
        N(j, i) = C(j,i)*wordlength;
        i = i+1;
    end
end

best_abs_error = zeros(degree_size,1);
best_mse = zeros(degree_size,1);

for i=1:degree_size
    best_abs_error(i,1) = min(max_abs_error(i,1:end));
    best_mse (i,1) = min(mean_squ_error(i,1:end));
end

figure(2)

plot(N, max_abs_error, 'linewidth', width);
xlabel('# of memory bits');
ylabel('max abs error');
hold on;
grid on;