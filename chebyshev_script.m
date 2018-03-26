%cleanup
clear;
clc;
close all;

%interval [a,b]
a = 0;
b = 2;
%degree of polynomial
n = 3;

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

p_sym = sum(c .* T_ks);

p_cheb_approx = subs(p_sym, dots);

hold on;
plot(dots, tanh(dots));
plot(dots, p_cheb_approx);