function [ y ] = LeakyReLU( x, alpha )

y = max(0,x) + alpha * min(0,x);

end

