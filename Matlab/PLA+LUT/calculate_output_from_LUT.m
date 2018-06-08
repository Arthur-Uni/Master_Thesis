function [ y ] = calculate_output_from_LUT( x, LUT )

    number_of_bits = log2(numel(LUT));
    
    values = x(:);
    
    sign_x = ones(size(values));
    sign_x(values < 0) = -1;
    
    values = abs(values);
    values = round(values ./ 2^-(number_of_bits - 2));
    values = values + 1;
    values(values > 2^number_of_bits) = 2^number_of_bits;
    
    y = sign_x .*LUT(values)';
    y = reshape(y, size(x));

end

