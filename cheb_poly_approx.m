function [ y ] = cheb_poly_approx( a, b, n, q_en, mode, wordlength, var)
%Chebyshev polynomial approximation of tanh(x)

%  Parameters:
%
%    Input, real a, b, the domain of definition.
%
%    Input, integer n, the order of the polynomial
%
%    Input, boolean q_en, enable quantization
%
%    Output, vector y, the Chebyshev polynomial approximation for vector x

%nodes to plot
dots = a:0.01:b;

%calculate chebyshev nodes
k=(0:n);
x_k = cos((2*k+1)*pi/(2*(n+1)));

%adjust chebyshev nodes for arbitrary interval
x_ks = 0.5.*(a-b).*x_k + 0.5 .* (a+b);

%calculate function nodes at x_ks
fnodes = tanh(x_ks);

%build T_k(x) for adjusted interval
syms x;
x = (2*x-(a+b))/(b-a);
T_ks = chebyshevT(k, x);

%calculate chebyshev coefficients
c = (0:n);
c(1) = sum(fnodes)/(n+1);
for i=2:(n+1)
c(i) = (2/(n+1)) * sum(fnodes .* subs(T_ks(i), x_ks));
end

if(q_en)
    c = cheb_quantize(c, mode, wordlength, var);
    %dots = cheb_quantize(dots, mode, wordlength, var);
end

%calculate polynomial approximation with variable x
p_sym = sum(c .* T_ks);

%substitute variable x with interval values
y = subs(p_sym, dots);

end

