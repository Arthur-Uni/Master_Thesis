function [ y ] = PLA( x )

x_sat = abs(x) > 0.25;
x_lin = x_sat ~= 1;

y_sat = x_sat .* sign(x);
y_lin = x_lin .* x;

y = y_sat + y_lin;

end

