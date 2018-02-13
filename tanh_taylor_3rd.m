function [ y ] = tanh_taylor_3rd( x )

y = x - ((1/3) .* x.^3) + ((2/15) .* x.^5);

end

