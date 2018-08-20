function [ M, MSE, coeffs, C, N ] = cheb_de_tanh_function_quantized( S )
%%
%initialization parameters

% set default interpreter
set(0,'defaulttextInterpreter','latex');

%number of segments
S_POT = log2(S)+1;

%number of points for linspace function
pts = 101;

%interval [a,b]: length must be a power of two so that the interval can be
%divided into powers of two
a = 0;
b = 4;

if(mod(b-a, 2) ~= 0)
    error('interval size is not a power of two');
end
%interval_size = (b-a)/S;
%%
%initialization parameters

interval_size = b-a;
max_step_size = interval_size / S;

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
%% function to approximate
Y_POT = zeros(S_POT,pts);
X = zeros(S_POT,pts);
for i=1:S_POT
    x = linspace(AB_POT(i,1), AB_POT(i,2),pts);
    Y_POT(i,1:pts) = 1-tanh(x).^2;
    X(i,1:pts) = x;
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
f_handle = @de_tanh;
                                                
if(min_degree ~= 1)
    temp = min_degree-1;
else
    temp = 0;
end

%%                                            
for n=min_degree:max_degree
    i = 1;
    coeff_wordlength = de_coeffs_setup(S,n); 
    coeff_fractionlength = de_coeffs_setup_fract( S, n, coeff_wordlength );
    for input_wordlength = min_word:step_size:max_word
        input_fractionlength = input_wordlength - 1;
        for k=1:S_POT
            c = de_cheb_poly_coeffs_quantized(AB_POT(k,1), AB_POT(k,2), n, coeff_wordlength ,coeff_fractionlength, f_handle);
            P_POT(k,1:pts) = de_cheb_horner_quantized_v2(X(k,1:end), S, AB_POT(k,1), AB_POT(k,2), n, ...
                c, coeff_wordlength, input_wordlength, input_fractionlength);
        end
        
%% quadratic regression: y = beta2 * x^2 + beta1 * x + beta0
        combined_wordlength = input_wordlength + coeff_wordlength;
        beta2 = 0.017147623788177732140347586664575;
        beta1 = 0.3410854832771987865669416351011;
        beta0 = 5.5892904331629633674083379446529;
%%
        abs_error = max(abs(Y_POT(:)-P_POT(:)));
        max_abs_error(n - temp, i) = abs_error;
        mean_squ_error(n - temp, i) = immse(double(Y_POT), double(P_POT));
        Coeffs(n - temp, i) = (n+1)*S_POT;
        N(n - temp, i) = Coeffs(n - temp)*coeff_wordlength;
        C(n - temp, i) = ceil(n * (beta2 * combined_wordlength^2 + beta1 * combined_wordlength + beta0));
        i = i+1;
    end
end

M = max_abs_error;
MSE = mean_squ_error;
coeffs = c;

end

