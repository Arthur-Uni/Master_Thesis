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
dots = linspace(a, b);

%function to approximate and Chebyshev polynomial approximation
y = tanh(dots);

max_degree = 10;
min_degree = 3;
degree_size = max_degree - min_degree +1;       %number of degree steps

min_word = 8;
max_word = 10;
word_size = ((max_word-min_word)/2) + 1;        %number of word steps
step_size = 2;

max_abs_error = zeros(degree_size,word_size);
mean_squ_error = zeros(degree_size,word_size);
C = zeros(degree_size,word_size);                                    %number of coefficients
N = zeros(degree_size,word_size);                                    %memory utilization

mode = 1;                              %1 = fixed point, 2 = floating point

for n=min_degree:max_degree
    j = n-2;
    for wordlength = min_word:step_size:max_word
        i = 0.5*wordlength - 3;
        var = wordlength - 1;%mode = 1 => fractional part length; mode = 2 => length of exponent
        p = cheb_poly_approx(a, b, n, 1, mode, wordlength, var);
        abs_error = max(abs(y-p));
        max_abs_error(j, i) = abs_error;
        mean_squ_error(j, i) = immse(double(y), double(p));
        C(j, i) = (n+1)*S;
        N(j, i) = C(j,i) * wordlength;
        i = i+1;
    end
end

best_abs_error = zeros(max_degree,1);
best_mse = zeros(max_degree,1);
for i=1:degree_size
    best_abs_error(i,1) = min(max_abs_error(i,1:end));
    best_mse (i,1) = min(mean_squ_error(i,1:end));
end

% for i=1:8
%     figure(1);
%     subplot(2,1,1);
%     plot(N(i,1:2), max_abs_error(i,1:2), 'linewidth', width);
%     xlabel('# of memory bits');
%     ylabel('max abs error');
%     hold on;
%     grid on;
%     grid minor;
% 
%     subplot(2,1,2);
%     plot(N(i,1:2), mean_squ_error(i,1:2), 'linewidth', width);
%     xlabel('# of memory bits');
%     ylabel('mean squared error');
%     hold on;
%     grid on
%     grid minor; 
% end

figure(2)

%subplot(2,1,1);
plot(N, max_abs_error, 'linewidth', width);
xlabel('# of memory bits');
ylabel('max abs error');
hold on;
grid on;
grid minor;

% subplot(2,1,2);
% plot(N, mean_squ_error, 'linewidth', width);
% xlabel('# of memory bits');
% ylabel('mean squared error');
% hold on;
% grid on
% grid minor;