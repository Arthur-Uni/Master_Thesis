function [ y ] = cheb_horner( a, b, n, q_en, wordlength, var)
%  Parameters:
%
%    Input, real a, b, the domain of definition.
%
%    Input, integer n, the order of the polynomial
%
%    Input, boolean q_en, enable quantization
%
%    Input, integer mode, quantization mode: 1 = fixed point, 2 = floating point
%
%    Input, integer wordlength
%
%    Input, integer var
%
%    Output, vector y, final polynomial approximation

dots = linspace(0,1);

c = cheb_poly_coeffs(a,b,n);

k = length(dots);
l = length(c);

temp = ones(1,k);

temp(:) = c(1);

for i=2:l
    temp = temp.*dots + c(i);
end

% quantize the final result to have an output of wordlength bits
if(q_en)
    temp = fi(temp, true, wordlength, var);
end

y = temp;

end

