function [ y ] = tanh_like_PLA_2009( x, n )

temp = 2^n.* abs(x);
integ = fix(temp);

y = sign(x) .* (1 + (1./(2.^(integ))) .* (0.5.*(temp - integ) - 1));

end

