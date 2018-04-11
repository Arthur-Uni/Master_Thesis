function [ c_poly ] = cheb_poly_coeffs( a, b, n, q_en, mode, wordlength, var)
%Chebyshev polynomial approximation of tanh(x)

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
%    Output, vector c_poly, final polynomial coefficients

%calculate chebyshev nodes
k=(0:n);
x_k = cos((2*k+1)*pi/(2*(n+1)));

%adjust chebyshev nodes for arbitrary interval
x_ks = 0.5.*(a-b).*x_k + 0.5 .* (a+b);

%calculate function nodes at x_ks
fnodes = tanh(x_ks);

%build T_k(x) for adjusted interval
syms x real;
%interval transformation: x2 = (2*x1-(a+b))/(b-a); %from x1:[a,b] -> x2:[-1,1]
T_ks = chebyshevT(k, (2*x-(a+b))/(b-a));

%calculate chebyshev coefficients
c = (0:n);
c(1) = sum(fnodes)/(n+1);
for i=2:(n+1)
c(i) = (2/(n+1)) * sum(fnodes .* subs(T_ks(i), x_ks));
end

%make sure really small c's are zero
e = 1e-9;
for i=1:(n+1)
    if(sign(c(i))*c(i) <= e)
        c(i) = 0;
    end
end

%calculate polynomial approximation for: x2 = (x1*(b-a)+(a+b))*0.5; %from x1:[-1,1] -> x2:[a,b]
p_sym = sum(c .* subs(T_ks, ((x*(b-a)+(a+b))*0.5)));
p_sym = expand(p_sym);
h = horner(p_sym);

c_poly_temp = double(coeffs(h, 'All'));

%quantization
if(q_en)
    c_poly = cheb_quantize(c_poly_temp, mode, wordlength, var); %format: [cn,...,c0]
    %c_poly = fi(c_poly, true, wordlength, var); %just a test to see if
                                                 %cheb_quantize works as intended
else
    c_poly = c_poly_temp;
    c_poly = double(c_poly); %format: [cn,...,c0]
end

end

