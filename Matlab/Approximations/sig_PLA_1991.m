function [ y ] = sig_PLA_1991( x )

y = (0.5+0.25.*(x+abs(fix(x))))./2.^abs(fix(x));

end