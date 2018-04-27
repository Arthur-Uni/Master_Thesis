%% cleanup
clear;
clc;
close all;

%%
% parameters
S = 4;

a = 0;
b = 4;

pts = 100;

max_degree = 10;
min_degree = 1;
degree_size = max_degree - min_degree +1;       %number of degree steps

min_word = 4;
max_word = 32;
word_size = ((max_word-min_word)/2) + 1;        %number of word steps
step_size = 2;

coeff_min_word = 4;
coeff_max_word = 32;
coeffs_wordsize = coeff_max_word-coeff_min_word + 1;

input_min_word = 2;
input_max_word = 32;
input_wordsize = input_max_word-input_min_word + 1;

total_results_size = word_size * coeffs_wordsize * input_wordsize; 

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
    for wordlength = min_word:step_size:max_word
        fractionlength = wordlength - 1;
        for coeff_wordlength = coeff_min_word:coeff_max_word
            coeff_fractionlength = coeff_wordlength -2;
            for input_wordlength = input_min_word:input_max_word
                input_fractionlength = input_wordlength - 1;
            [max_abs_error(n - temp, i), mean_squ_error(n - temp, i), N(n - temp, i), C(n - temp, i)] = ...
                cheb_quantized(S, a, b, pts, n, wordlength, fractionlength, ... 
                coeff_wordlength, coeff_fractionlength, input_wordlength, input_fractionlength);
            i = i+1;
            end
        end
    end
end

%%
% plot
figure(1);
s_N = scatter(N, max_abs_error, 'x');

figure(2);
s_C = scatter(C, max_abs_error, 'x');