function [ y ] = power_of_two_2008( x )

 y = sign(x).*(1-(1./2.^(abs(x))));

end

