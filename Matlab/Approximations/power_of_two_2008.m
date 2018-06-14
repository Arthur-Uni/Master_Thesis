function [ y, dx ] = power_of_two_2008( x )

 y = sign(x).*(1-(1./2.^(abs(x))));
 dx = (x.*log(2).*2.^(-abs(x)).*sign(x))./abs(x);
end

