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

max_abs_error = zeros(10,15);
mean_squ_error = zeros(10,15);
C = zeros(10,15);                                    %number of coefficients
N = zeros(10,15);                                    %memory utilization
mode = 1;                              %1 = fixed point, 2 = floating point

for n=1:10
    for wordlength = 4:2:32
        i = 0.5*wordlength - 1;
        var = wordlength - 1;%mode = 1 => fractional part length; mode = 2 => length of exponent
        p = cheb_poly_approx(a, b, n, 1, mode, wordlength, var);
        abs_error = max(abs(y-p));
        max_abs_error(n, i) = abs_error;
        mean_squ_error(n, i) = immse(double(y), double(p));
        C(n, i) = (n+1)*S;
        N(n, i) = C(n) * wordlength;
        i = i+1;
    end
end

best_abs_error = zeros(10,1);
best_mse = zeros(10,1);
for i=1:10
    best_abs_error(i,1) = min(max_abs_error(i,1:end));
    best_mse (i,1) = min(mean_squ_error(i,1:end));
end

for i=1:10
    figure(1);
    subplot(2,1,1);
    plot(N(i,1:15), max_abs_error(i,1:15), 'linewidth', width);
    xlabel('# of memory bits');
    ylabel('max abs error');
    hold on;
    grid on;
    grid minor;

    subplot(2,1,2);
    plot(N(i,1:15), mean_squ_error(i,1:15), 'linewidth', width);
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
