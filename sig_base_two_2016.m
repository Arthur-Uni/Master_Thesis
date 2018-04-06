function [ y ] = sig_base_two_2016( x )

temp = 2.^(-1.5.*x);

y = 1./(1+temp);

end

