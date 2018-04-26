function [ N, M, C ] = cheb_quantized_segmentation( S )
%%
%paramter
% input S, integer, number of segments
% output M, double, matrix containing max_abs_error
% output N, double, matrix containing # of memory bits
%%
%%
% quantize final result, quantize intermediate result of horner scheme
% multiplication and addition, obtained coefficients are quantized and 
% inputs are quantized

%%
%cleanup
%clear;
clc;
%close all;

%%
%initialization parameters

%degree of polynomial
%n = 3;

%number of segments
S_POT = log2(S)+1;

%number of points for linspace function
pts = 100;

%interval [a,b]: length must be a power of two so that the interval can be
%divided into powers of two
a = 0;
b = 8;

if(mod(b-a, 2) ~= 0)
    error('interval size is not a power of two');
end
%interval_size = (b-a)/S;

%combine a and b in matrix AB
AB_POT = zeros(S_POT,2);

%plotting points in interval [a,b]
Dots_POT = zeros(S_POT,pts);

% plotting parameters
width = 1.5;

%%
%create matrices for intervals to the power of two in [a,b] and save boundaries of
%each segment in matrix AB
for i=1:S_POT
    AB_POT(i,1) = floor(S/(2^i));
    AB_POT(i,2) = S/(2^(i-1));
    Dots_POT(i,1:100) = linspace(AB_POT(i,1), AB_POT(i,2), pts);
end

%flip matrices upside down
AB_POT = flipud(AB_POT);
Dots_POT = flipud(Dots_POT);

%%
%function to approximate(tanh in this case)

% Y = zeros(S,pts);
% for i=1:S
%     x = linspace(AB(i,1), AB(i,2),pts);
%     Y(i,1:pts) = tanh(x);
% end

Y_POT = zeros(S_POT,pts);
for i=1:S_POT
    x = linspace(AB_POT(i,1), AB_POT(i,2),pts);
    Y_POT(i,1:pts) = tanh(x);
end

%%
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
Coeffs = zeros(degree_size,word_size);          %number of coefficients
M = zeros(degree_size,word_size);               %memory utilization
C = zeros(degree_size,word_size);               %computational effort
                                                
P_POT = zeros(S_POT,pts);                       %matrix storing polynomial 
                                                %approximation values
                                                %calculated for each
                                                %segment
                                                
coeff_wordlength = 16;
coeff_fractionlength = coeff_wordlength - 2;

input_wordlength = 16;
input_fractionlength = input_wordlength - 1;
                                                
if(min_degree ~= 1)
    temp = min_degree-1;
else
    temp = 0;
end
%%                                            
for n=min_degree:max_degree
    i = 1;
    for temp_wordlength = min_word:step_size:max_word
        temp_fractionlength = temp_wordlength-1;
        for k=1:S_POT
            P_POT(k,1:pts) = cheb_horner_quantized(AB_POT(k,1), AB_POT(k,2),...
                n, temp_wordlength, temp_fractionlength, coeff_wordlength, coeff_fractionlength,...
                input_wordlength, input_fractionlength);
        end
        abs_error = max(abs(Y_POT(:)-P_POT(:)));
        max_abs_error(n - temp, i) = abs_error;
        mean_squ_error(n - temp, i) = immse(double(Y_POT), double(P_POT));
        Coeffs(n - temp, i) = (n+1)*S_POT;
        M(n - temp, i) = Coeffs(n - temp)*coeff_wordlength;
        C(n - temp, i) = 2*n*(temp_wordlength + coeff_wordlength + input_wordlength);
        i = i+1;
    end
end

N = max_abs_error;

end

