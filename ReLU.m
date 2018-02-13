function [ y ] = ReLU( x )

y = max(0,x);

%alternative
%y = (x+abs(x))/2;

end

