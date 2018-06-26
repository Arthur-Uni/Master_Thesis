function [ y, y_fixed_point ] = sig_PLA_1991_v2( x, wordlength )

% set global fimath settings
globalfimath('OverflowAction','Saturate','RoundingMethod','Round')

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

fractionlength = wordlength - 1;

%% negative part
if(~isempty(x_neg))
    
    % get integer part of x_neg
    x_neg_integer = abs(fix(x_neg));
    
    % get fractional part of x_neg
    x_neg_fractional = x_neg + x_neg_integer;
    
    % convert to signed fixed point format
    x_neg_fractional = fi(x_neg_fractional, true, wordlength, fractionlength);
    
    T = numerictype(0, wordlength, wordlength);
    
    x_neg_reinterpret = reinterpretcast(x_neg_fractional, T);
    
    %% manipulate bit stream to directly convert to y_neg_fixed_point
    
    % remove sign bit
    % x_neg_fractional = bitset(x_neg_fractional, wordlength, 0);
    
    % shift two two bits to the right
    x_neg_reinterpret = bitshift(x_neg_reinterpret, -2);
    
    % add 0.5 shifted one place to the right
    x_neg_reinterpret = bitset(x_neg_reinterpret, wordlength - 2);
    
    %% shift x_neg_fractional to acquire y_neg_fixed_point
    
    for i=1:size(x_neg_fractional,2)
        y_neg_fixed_point(i) = bitshift(x_neg_reinterpret(i), -x_neg_integer(i));
    end
    
    T2 = numerictype(1, wordlength, wordlength - 1);
    
    y_neg_fixed_point_reinterpret = reinterpretcast(y_neg_fixed_point, T2);
    
end

%% positive part
if(~isempty(x_pos))
    
    x_pos_integer = abs(fix(x_pos));
    
    x_pos_fractional = x_pos - x_pos_integer;
    
    x_pos_fractional = fi(x_pos_fractional, false, wordlength, wordlength);
    
    x_pos_fractional = bitshift(x_pos_fractional, -2);
    
    x_pos_fractional = bitset(x_pos_fractional, wordlength);
    
    for i=1:size(x_pos_fractional,2)
        y_pos_fixed_point(i) = bitshift(x_pos_fractional(i), -x_pos_integer(i));
        k = wordlength;
        
        % fill with ones from left side
        for j=1:x_pos_integer(i)
            y_pos_fixed_point(i) = bitset(y_pos_fixed_point(i), k);
            k = k - 1;
        end
        
    end
    
end

%% bring everything together for fixed point part
if(isempty(x_neg))
    y_fixed_point = y_pos_fixed_point;
elseif(isempty(x_pos))
    y_fixed_point = y_neg_fixed_point;
else
    y_fixed_point = [y_neg_fixed_point y_pos_fixed_point];
end

end