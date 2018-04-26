function [ M, N, C ] = cheb_segmentation( S, a, b, pts )
%%
% quantize final result only (signed fixed point) during chebyshev
% polynomial approximation, every other calculation inbetween is 
% performed with matlab default floating point precision

% S needs to be a power of two such that interval [a,b] can be
% divided into integer powers of two
%%

%%
%initialization parameters

%degree of polynomial
%n = 3;
     
S_POT = log2(S)+1;

interval_size = b-a;
max_step_size = interval_size / S;

if(mod(b-a, 2) ~= 0)
    error('interval size is not a power of two');
end

%combine a and b in matrix AB
AB_POT = zeros(S_POT,2);

%%
%create matrices for intervals to the power of two in [a,b] and save boundaries of
%each segment in matrix AB
for i=1:S_POT
    AB_POT(i,1) = floor(S/(2^i)) * max_step_size;
    AB_POT(i,2) = S/(2^(i-1)) * max_step_size;
end

%flip matrices upside down
AB_POT = flipud(AB_POT);
AB_POT
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
N = zeros(degree_size,word_size);               %memory utilization
C = zeros(degree_size,word_size);               %computational effort

P_POT = zeros(S_POT,pts);                       %matrix storing polynomial 
                                                %approximation values
                                                %calculated for each
                                                %segment
                                                
q_en = 1;

if(min_degree ~= 1)
    temp = min_degree-1;
else
    temp = 0;
end
%%                                            
for n=min_degree:max_degree
    i = 1;
    for temp_wordlength = min_word:step_size:max_word
        var = temp_wordlength-1;
        for k=1:S_POT
            P_POT(k,1:pts) = cheb_horner(AB_POT(k,1), AB_POT(k,2), n, q_en,...
                temp_wordlength, var);
        end
        abs_error = max(abs(Y_POT(:)-P_POT(:)));
        max_abs_error(n - temp, i) = abs_error;
        mean_squ_error(n - temp, i) = immse(double(Y_POT), double(P_POT));
        Coeffs(n - temp, i) = (n+1)*S_POT;
        N(n - temp, i) = Coeffs(n - temp)*32; % 32 = wordlength of not quantized coefficients
        C(n - temp, i) = 2*n*(temp_wordlength + 32 + 32); % number of operations * wordlength(quantized output + coefficients + inputs) = computational effort
        i = i+1;
    end
end

M = max_abs_error;
end

