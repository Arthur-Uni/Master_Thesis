% %cleanup
% clear;
% clc;
% close all;

%interval [a,b]
a1 = 0;
b1 = 4;
a2 = 4;
b2 = 8;
S = 2; %number of segments
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

max_abs_error = zeros(10,15);
mean_squ_error = zeros(10,15);
C = zeros(10,15);
N = zeros(10,15);
mode = 1;

for n=1:10
    for wordlength = 4:2:32
        i = 0.5*wordlength - 1;
        var = wordlength - 2;
        
        
        
        p1 = cheb_poly_approx(a1, b1, n, 1, mode, wordlength, var);
        p2 = cheb_poly_approx(a2, b2, n, 1, mode, wordlength, var);
        p = [p1, p2];
        abs_error = max(abs(y-p));
        max_abs_error(n, i) = abs_error;
        mean_squ_error(n, i) = immse(double(y), double(p));
        C(n, i) = (n+1)*S;
        N(n, i) = C(n)*wordlength;
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