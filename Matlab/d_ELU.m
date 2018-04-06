function [ y ] = d_ELU( x, alpha )

comp = zeros(size(x));

temp = (x < comp).*alpha.*exp(x);

temp(401) = 1;

y = temp + (x > comp);

end

