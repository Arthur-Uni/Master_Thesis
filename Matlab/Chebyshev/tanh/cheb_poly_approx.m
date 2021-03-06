function [ y] = cheb_poly_approx( a, b, n, q_en, mode, wordlength, var)
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
%dots = linspace(a,b);
dots = linspace(-1,1);

%calculate chebyshev nodes
k=(0:n);
x_k = cos((2*k+1)*pi/(2*(n+1)));

%adjust chebyshev nodes for arbitrary interval
x_ks = 0.5.*(a-b).*x_k + 0.5 .* (a+b);

%calculate function nodes at x_ks
fnodes = tanh(x_ks);

%build T_k(x) for adjusted interval
syms x real;
%x2 = (2*x1-(a+b))/(b-a); %from x1:[a,b] -> x2:[-1,1]
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

%quantization
if(q_en)
    c = cheb_quantize(c, mode, wordlength, var);
    %dots = cheb_quantize(dots, mode, wordlength, var);
end

%%calculate polynomial approximation with variable x
%p_sym = sum(c .* T_ks);

%calculate polynomial approximation for: x2 = (x1*(b-a)+(a+b))*0.5; %from x1:[-1,1] -> x2:[a,b]
p_sym = sum(c .* subs(T_ks, ((x*(b-a)+(a+b))*0.5)));
p_sym = expand(p_sym);

%substitute variable x with interval values
y = subs(p_sym, dots); % calculated for normalized inputs!!
y = double(y);
%y = subs(p_sym, dots);

end