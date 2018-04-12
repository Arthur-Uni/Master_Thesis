function [ y ] = cheb_horner( a, b, n, q_en, mode, wordlength, var)
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

c = cheb_poly_coeffs(a,b,n,q_en,mode,wordlength,var);
% c.bin
% c.int
% c.value

k = length(dots);
l = length(c);
temp = c(1)*ones(1,k);

for i=2:l
    temp(:) = temp.*dots + c(i);
end

if(q_en)
    temp = fi(temp, true, wordlength, var);
end

y = temp;

end

