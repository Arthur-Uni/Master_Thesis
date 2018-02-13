function [ y ] = power_of_two_PLA_2008( x )

integ = fix(x);
fract = abs(x-integ);

y = sign(x).* (((1./2.^abs(integ)).*(0.5.*abs(fract)-1))+1);

end

