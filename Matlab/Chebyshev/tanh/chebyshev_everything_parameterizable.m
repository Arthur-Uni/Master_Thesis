%% cleanup
clear;
clc;
close all;

%%
% parameters

% set global fimath settings
globalfimath('OverflowAction','Saturate','RoundingMethod','Round');

S = 4;

a = 0;
b = 4;

pts = 100;

max_degree = 10;
min_degree = 1;
degree_size = max_degree - min_degree +1;       %number of degree steps

% min_word = 4;
% max_word = 16;
% word_size = ((max_word-min_word)/2) + 1;        %number of word steps
% step_size = 2;

coeff_min_word = 8;
coeff_max_word = 16;
coeffs_wordsize = coeff_max_word-coeff_min_word + 1;

input_min_word = 6;
input_max_word = 16;
input_wordsize = input_max_word-input_min_word + 1;

total_results_size = coeffs_wordsize * input_wordsize; 

max_abs_error = zeros(degree_size,total_results_size);
mean_squ_error = zeros(degree_size,total_results_size);
Coeffs = zeros(degree_size,total_results_size);          %number of coefficients
N = zeros(degree_size,total_results_size);               %memory utilization
C = zeros(degree_size,total_results_size);               %computational effort

if(min_degree ~= 1)
    temp = min_degree-1;
else
    temp = 0;
end

%%
% chebyshev computation and calculation of abs error and mse

for n=min_degree:max_degree
   i = 1;
    for input_wordlength = input_min_word:input_max_word
        input_fractionlength = input_wordlength - 1;
        for coeff_wordlength = coeff_min_word:coeff_max_word
            coeff_fractionlength = coeff_wordlength -2;
            [max_abs_error(n - temp, i), mean_squ_error(n - temp, i), N(n - temp, i), C(n - temp, i)] = ...
                cheb_quantized(S, a, b, pts, n, coeff_wordlength, coeff_fractionlength, ...
                input_wordlength, input_fractionlength);
            i = i+1;
        end
    end
end

%%
% plot
figure(1);
s_N = scatter(N(:), max_abs_error(:), 'x');

figure(2);
s_C = scatter(C(:), max_abs_error(:), 'x');

%%
% pareto optimization
M = max_abs_error;

P1 = cheb_pareto_v2(M, N);
P2 = cheb_pareto_v2(M, C);

Ones1 = P1>0;
Ones2 = P2>0;

M_pareto1 = Ones1 .* M;
N_pareto1 = Ones1 .* N;
M_pareto2 = Ones2 .* M;
C_pareto2 = Ones2 .* C;

M_pareto1(M_pareto1==0) = [];
N_pareto1(N_pareto1==0) = [];
M_pareto2(M_pareto2==0) = [];
C_pareto2(C_pareto2==0) = [];

figure(1)
s_pareto_1 = scatter(N_pareto1, M_pareto1, 75, 'x', 'LineWidth', 2.5);
xlabel('memory bits');
ylabel('maximum absolute error');
title('pareto front for memory utilization');

figure(2)
s_1 = scatter(N(:), M(:), 75, 'x', 'r', 'LineWidth', 2.5);
xlabel('memory bits');
ylabel('maximum absolute error');
title('all points for memory utilization');

figure(3)
s_pareto_2 = scatter(C_pareto2, M_pareto2, 75, 'x', 'LineWidth', 2.5);
xlabel('computational effort');
ylabel('maximum absolute error');
title('pareto front for computational effort');

figure(4)
s_2 = scatter(C(:), M(:), 75, 'x', 'r', 'LineWidth', 2.5);
xlabel('computational effort');
ylabel('maximum absolute error');
title('all points for computational effort');