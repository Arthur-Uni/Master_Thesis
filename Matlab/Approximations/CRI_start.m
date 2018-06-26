function [ y ] = CRI_start( x )

temp1 = x >= -2;
temp2 = x <= 2;
x_lin = temp1 .* temp2;

x_pos = x > 2;

y_lin = (0.5.*(1 + 0.5.*x)) .* x_lin;
y_neg = zeros(size(x));
y_pos = ones(size(x)) .* x_pos;

y = y_lin + y_pos + y_neg;

end

