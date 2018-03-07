%clear
close all;
clear;
clc;

%initialization
a = 0; %interval left
b = 4; %interval right
n = 4; %degree of chebyshev polynomial
c=-1;
d=1;
x=linspace(a,b,fix(b-a)*20);
t=c+(d-c)/(b-a)*(x-a);
fxact=tanh(x); %builds exact solution on x

%build the Chebyshev nodes x_k
vec=(0:n);
nodes=cos((2*vec+1)*pi/(2*(n+1)));
%evaluate f at the nodes

fnodes = tanh(a+(b-a)/(d-c)*(nodes-c));
c(1)=sum(fnodes)/(n+1);
for j=2:(n+1)
c(j)=(2/(n+1))*fnodes*cos((j-1)*acos(nodes))';
end

%build T_k(x)
for k=1:(n+1)
cheb(k,:)=cos((k-1)*acos(t));
end

%finally here is the approximation
chebapp=c*cheb;

%This is the error
err=max(abs(fxact-chebapp));
plot(x,fxact,x,chebapp)
title(['n = ', int2str(n),' error = ', num2str(err)])
xlabel('x-axis')
grid