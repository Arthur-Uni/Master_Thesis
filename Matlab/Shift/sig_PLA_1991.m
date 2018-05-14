function [ y ] = sig_PLA_1991( x )

%% get all negative values of x
neg_logical = x < 0;
x_neg = neg_logical .* x;
% remove all entries that zero
x_neg(x_neg == 0) = [];

%% get all positive values of x
pos_logical = x >= 0;
x_pos = pos_logical .* x;
% remove all entries which are explicitly smaller than zero
x_pos(x < 0) = [];

%% formula for negative x
if(~isempty(x_neg))
    y_neg = (0.5+0.25.*(x_neg+abs(fix(x_neg))))./2.^abs(fix(x_neg));
end

%% formula for positive x
if(~isempty(x_pos))
    y_pos = 1 + (-0.5 + 0.25 .* (x_pos - abs(fix(x_pos))))./2.^abs(fix(x_pos));
end

%% bring everything together
if(isempty(x_neg))
    y = y_pos;
elseif(isempty(x_pos))
    y = y_neg;
else
    y = [y_neg y_pos];
end

%% fixed point part

%% negative part
if(~isempty(x_neg))
    
    x_neg_integer = abs(fix(x_neg));
    
    x_neg_fractional = abs(x_neg + x_neg_integer);
    x_neg_fractional = fi(x_neg_fractional, false, 32, 32);
    
    x_neg_fractional = bitshift(x_neg_fractional, -2);
    
    x_neg_fractional = bitset(x_neg_fractional, 31);
    
    x_neg_fractional = bitshift(x_neg_fractional, - x_neg_integer);
end

%% positive part
if(~isempty(x_pos))
    
    x_pos_fractional = x_pos - abs(fix(x_pos));
    
    x_pos_fractional = fi(x_pos_fractional, false, 32, 31);
    
    x_pos_fractional = bitshift(x_pos_fractional, -2);
    
    x_pos_fractional = bitset(x_pos_fractional, 31);
    
    x_pos_fractional = bitshift(x_pos_fractional, -abs(fix(x_pos)));
    
end

end