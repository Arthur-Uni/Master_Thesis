function [ y, c, x_k, x_ks ] = cheb_horner_v2( x, a, b, n )
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

% transform x from interval [a,b] to [0,1]
x_transform = (x-a) .* (1/(b-a));

[c, x_k, x_ks] = cheb_poly_coeffs(a,b,n);

k = length(x);
l = length(c);

temp = ones(1,k);

temp(:) = c(1);

for i=2:l
    temp = temp.*x_transform + c(i);
end

y = temp;

end

