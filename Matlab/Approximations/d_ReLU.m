function [ y ] = d_ReLU( x )

y = ones(size(x));
y(x<0) = 0;

end

