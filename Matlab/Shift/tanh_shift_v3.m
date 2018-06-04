function [ y_fixed_point ] = tanh_shift_v2( x, wordlength )

%% get all negative values of x
neg_logical = x < 0;
x_neg = neg_logical .* x;

%% get all positive values of x
pos_logical = x >= 0;
x_pos = pos_logical .* x;

%% fixed point part

fractionlength = wordlength - 1;

%% negative part
if(~isempty(x_neg))
    
    % get integer part of x_neg
    x_neg_integer = abs(fix(x_neg));
    
    x_neg_integer_temp = abs(fix(2.*x_neg));
    
    % get fractional part of x_neg
    x_neg_fractional = x_neg + x_neg_integer;
    
    % convert to signed fixed point format
    x_neg_fractional = fi(x_neg_fractional, true, wordlength, fractionlength);
    
    % remove first fractional bit
    x_neg_fractional = bitset(x_neg_fractional, wordlength-1, 0);
    
    % remove sign bit
    x_neg_fractional = bitset(x_neg_fractional, wordlength, 0);
    
    % reinterpret x as having only fractional part without sign
    T = numerictype(0, wordlength, wordlength);
    
    x_neg_reinterpret = reinterpretcast(x_neg_fractional, T);
    
    x_neg_reinterpret = bitshift(x_neg_reinterpret, 1);
    
    x_neg_reinterpret = bitset(x_neg_reinterpret, wordlength);
    
    %% shift x_neg_fractional to acquire y_neg_fixed_point
    
    for i=1:size(x_neg_fractional,2)
        y_neg_fixed_point(i) = bitshift(x_neg_reinterpret(i), -x_neg_integer_temp(i));
    end
    
    y_neg_fixed_point = bitshift(y_neg_fixed_point, -1);
    
    y_neg_fixed_point = bitset(y_neg_fixed_point, wordlength);
    
    T2 = numerictype(1, wordlength, wordlength - 1);
    
    y_neg_fixed_point_reinterpret = reinterpretcast(y_neg_fixed_point, T2);
    
    y_neg_fixed_point_reinterpret = double(y_neg_fixed_point_reinterpret) .* neg_logical;
    
    y_neg_fixed_point_reinterpret = fi(y_neg_fixed_point_reinterpret, true, wordlength, fractionlength);
    
end

%% positive part
if(~isempty(x_pos))
    
    x_pos_integer = abs(fix(x_pos));
    
    % modified shift amount for inputs being 2*x
    x_pos_integer_temp = abs(fix(2.*x_pos));
    
    % get fractional part
    x_pos_fractional = x_pos - x_pos_integer;
    
    x_pos_fractional = fi(x_pos_fractional, false, wordlength, wordlength);
    
    % remove first fractional bit
    x_pos_fractional = bitset(x_pos_fractional, wordlength, 0);
    x_pos_fractional = bitshift(x_pos_fractional, 1);
    
    x_pos_fractional = bitshift(x_pos_fractional, -1);
    
    % x_pos_fractional = bitset(x_pos_fractional, wordlength);
    
    for i=1:size(x_pos_fractional,2)
        y_pos_fixed_point(i) = bitshift(x_pos_fractional(i), -x_pos_integer_temp(i));
        k = wordlength;
        
        % fill with ones from left side
        for j=1:x_pos_integer_temp(i)
            if(k ~= 0)
                y_pos_fixed_point(i) = bitset(y_pos_fixed_point(i), k);
                k = k - 1;
            end
        end
        
    end
    
    y_pos_fixed_point = bitshift(y_pos_fixed_point, -1);
    
    T = numerictype(1, wordlength, fractionlength);
    
    y_pos_fixed_point_reinterpret = reinterpretcast(y_pos_fixed_point, T);
    
    y_pos_fixed_point_reinterpret = double(y_pos_fixed_point_reinterpret) .* pos_logical;
    
    y_pos_fixed_point_reinterpret = fi(y_pos_fixed_point_reinterpret, true, wordlength, fractionlength);
    
end

%% bring everything together for fixed point part
y_fixed_point = double(y_neg_fixed_point_reinterpret) + double(y_pos_fixed_point_reinterpret);
y_fixed_point = fi(y_fixed_point, true, wordlength, fractionlength);

end

