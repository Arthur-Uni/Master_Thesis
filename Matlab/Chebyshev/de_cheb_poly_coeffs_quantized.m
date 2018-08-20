function [ c_poly ] = de_cheb_poly_coeffs_quantized(  a, b, n, wordlength, fract, f_handle )
%Chebyshev polynomial approximation of tanh(x)

%  Parameters:
%
%    Input, real a, b, the domain of definition.
%
%    Input, integer n, the order of the polynomial
%
%    Input, integer wordlength, total wordlength
%
%    Input, integer fract, fractional bits of total wordlength
%
%   Input, function handle f_handle, function to approximate 
%
%    Output, vector c_poly, final polynomial coefficients quantized

%calculate chebyshev nodes
k=(0:n);
x_k = cos((2*k+1)*pi/(2*(n+1)));

%adjust chebyshev nodes for arbitrary interval
x_ks = 0.5.*(a-b).*x_k + 0.5 .* (a+b);

%calculate function nodes at x_ks
fnodes = f_handle(x_ks);

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
%p_sym = sum(c .* subs(T_ks, ((x*(b-a)+(a+b))*0.5)));

%calculate polynomial approximation for: x2 = (x1*(b-a)+(a+b))*0.5; %from x1:[0,1] -> x2:[a,b]
p_sym = sum(c .* subs(T_ks, (x*(b-a)+a)));
p_sym = expand(p_sym);

c_poly_temp = double(coeffs(p_sym, 'All'));
% debuggin purposes
% c_temp = abs(c_poly_temp) > 1023.99;
% if(nnz(c_temp) ~= 0)
%     warning('foo');
% end

%quantization
c_poly = fixed_point(c_poly_temp, wordlength-fract, fract);

end

