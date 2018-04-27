function [ abs_error, mse, N, C ] = cheb_quantized( S, a, b, pts, n, wordlength, fractionlength, coeff_wordlength, coeff_fractionlength, input_wordlength, input_fractionlength )
%%
% parameters
% a,b interval borders
% S number of equidistant segments
% n degree of polynomial
% *wordlength: wordlengths of intermediate results, final results,
% coefficients and inputs respectively
%%
% initialization parameters

% number of segments with a size of integer power of two
S_POT = log2(S)+1;

interval_size = b-a;
max_step_size = interval_size / S;

if(mod(b-a, 2) ~= 0 || a >= b)
    error('interval size is not a power of two or left border of interval is bigger than the right');
end

%combine a and b in matrix AB
AB_POT = zeros(S_POT,2);

%%
% create matrices for intervals to the power of two in [a,b] and save boundaries of
% each segment in matrix AB
for i=1:S_POT
    AB_POT(i,1) = floor(S/(2^i)) * max_step_size;
    AB_POT(i,2) = S/(2^(i-1)) * max_step_size;
end

%flip matrices upside down
AB_POT = flipud(AB_POT);
AB_POT

%%
% function to approximate(tanh in this case)
Y_POT = zeros(S_POT,pts);
for i=1:S_POT
    x = linspace(AB_POT(i,1), AB_POT(i,2),pts);
    Y_POT(i,1:pts) = tanh(x);
end

%%
% chebyshev approximation

% matrix storing polynomial approximation values calculated for each segment
P_POT = zeros(S_POT,pts);                                                                    
coeffs = (n+1)*S_POT;

for k=1:S_POT
    P_POT(k,1:pts) = cheb_horner_quantized(S, AB_POT(k,1), AB_POT(k,2),...
         n, wordlength, fractionlength, coeff_wordlength, coeff_fractionlength,...
         input_wordlength, input_fractionlength);
end

abs_error = max(abs(Y_POT(:)-P_POT(:)));
mse = immse(double(Y_POT), double(P_POT));
N = coeffs * coeff_wordlength;
C = 2*n*(wordlength + coeff_wordlength + input_wordlength);

end

