function [ y ] = sig_PLA_1991( x )

y = zeros(size(x));

temp1 = x < 0;
temp2 = x >= 0;

y_temp = (0.5+0.25.*(x+abs(fix(x))))./2.^abs(fix(x));
y_1 = y_temp .* temp1;
y_2 = (1-fliplr(y_temp)) .* temp2;
y = y_1 + y_2;

end