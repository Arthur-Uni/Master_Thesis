function [ y ] = tanh_PLA_v2( x )

x = 2.*x;

%% get all negative values of x
neg_logical = x < 0;
x_neg = neg_logical .* x;
% remove all entries that zero
% x_neg(x_neg == 0) = [];

%% get all positive values of x
pos_logical = x >= 0;
x_pos = pos_logical .* x;
% remove all entries which are explicitly smaller than zero
% x_pos(x < 0) = [];

%% formula for negative x
if(~isempty(x_neg))
    y_neg = (0.5+0.25.*(x_neg+abs(fix(x_neg))))./2.^abs(fix(x_neg)) .* neg_logical;
    y_neg = y_neg .* neg_logical;
end

%% formula for positive x
if(~isempty(x_pos))
    y_pos = 1 + (-0.5 + 0.25 .* (x_pos - abs(fix(x_pos))))./2.^abs(fix(x_pos));
    y_pos = y_pos .* pos_logical;
end

%% bring everything together
y_temp = y_neg + y_pos;
y = 2.*y_temp - 1;

end

