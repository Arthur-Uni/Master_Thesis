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
S = 8;   %number of segments
%degree of polynomial
%n = 3;

%plotting parameters
width = 1;
%points to plot
dots1 = linspace(a1,b1);
dots2 = linspace(a2,b2);
dots3 = linspace(a3,b3);
dots4 = linspace(a4,b4);
dots5 = linspace(a5,b5);
dots6 = linspace(a6,b6);
dots7 = linspace(a7,b7);
dots8 = linspace(a8,b8);

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

max_degree = 10;
min_degree = 1;
degree_size = max_degree - min_degree +1;       %number of degree steps

min_word = 4;
max_word = 32;
word_size = ((max_word-min_word)/2) + 1;        %number of word steps
step_size = 2;

max_abs_error = zeros(degree_size,word_size);
mean_squ_error = zeros(degree_size,word_size);
C = zeros(degree_size,word_size);                                    %number of coefficients
N = zeros(degree_size,word_size);                                    %memory utilization
mode = 1;

for n=min_degree:max_degree
    for wordlength = min_word:step_size:max_word
        i = 0.5*wordlength - 1;
        var = wordlength - 2;
        p1 = cheb_poly_approx(a1, b1, n, 1, mode, wordlength, var);
        p2 = cheb_poly_approx(a2, b2, n, 1, mode, wordlength, var);
        p3 = cheb_poly_approx(a3, b3, n, 1, mode, wordlength, var);
        p4 = cheb_poly_approx(a4, b4, n, 1, mode, wordlength, var);
        p5 = cheb_poly_approx(a5, b5, n, 1, mode, wordlength, var);
        p6 = cheb_poly_approx(a6, b6, n, 1, mode, wordlength, var);
        p7 = cheb_poly_approx(a7, b7, n, 1, mode, wordlength, var);
        p8 = cheb_poly_approx(a8, b8, n, 1, mode, wordlength, var);
        p = [p1, p2, p3, p4, p5, p6, p7, p8];
        abs_error = max(abs(y-p));
        max_abs_error(n ,i) = abs_error;
        mean_squ_error(n, i) = immse(double(y), double(p));
        C(n, i) = (n+1)*S;
        N(n, i) = C(n)*wordlength;
        i = i+1;
    end
end

best_abs_error = zeros(degree_size,1);
best_mse = zeros(degree_size,1);

for i=1:degree_size
    best_abs_error(i,1) = min(max_abs_error(i,1:end));
    best_mse (i,1) = min(mean_squ_error(i,1:end));
end

for i=1:10
    figure(1);
    subplot(2,1,1);
    plot(N(i,1:word_size), max_abs_error(i,1:word_size), 'linewidth', width);
    xlabel('# of memory bits');
    ylabel('max abs error');
    hold on;
    grid on;
    grid minor;

    subplot(2,1,2);
    plot(N(i,1:word_size), mean_squ_error(i,1:word_size), 'linewidth', width);
    xlabel('# of memory bits');
    ylabel('mean squared error');
    hold on;
    grid on
    grid minor; 
end

figure(2)

subplot(2,1,1);
plot(N, max_abs_error, 'linewidth', width);
xlabel('# of memory bits');
ylabel('max abs error');
hold on;
grid on;
grid minor;

subplot(2,1,2);
plot(N, mean_squ_error, 'linewidth', width);
xlabel('# of memory bits');
ylabel('mean squared error');
hold on;
grid on
grid minor;