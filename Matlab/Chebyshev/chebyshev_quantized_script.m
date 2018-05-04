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

% min_word = 4;
% max_word = 32;
% word_size = ((max_word-min_word)/2) + 1;        %number of word steps
% step_size = 2;

min_input = 4;
max_input = 32;
word_size = max_input - min_input + 1;

max_abs_error = zeros(degree_size,word_size);
mean_squ_error = zeros(degree_size,word_size);
Coeffs = zeros(degree_size,word_size);          %number of coefficients
N = zeros(degree_size,word_size);               %memory utilization
C = zeros(degree_size,word_size);               %computational effort

coeff_wordlength = 16;

if(min_degree ~= 1)
    temp = min_degree-1;
else
    temp = 0;
end

%%
% chebyshev computation and calculation of abs error and mse

for n=min_degree:max_degree
   i = 1;
    for input_wordlength = min_input:max_input
        input_fractionlength = input_wordlength - 1;
        [max_abs_error(n - temp, i), mean_squ_error(n - temp, i), N(n - temp, i), C(n - temp, i)] = ...
            cheb_quantized(S, a, b, pts, n,  coeff_wordlength, ...
                coeff_fractionlength, input_wordlength, input_fractionlength);
        i = i+1;
    end
    
end

