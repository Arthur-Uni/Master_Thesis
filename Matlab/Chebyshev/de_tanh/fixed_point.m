function out = fixed_point(in,integer_bits, fractional_bits)

%Fixed Point 
out = round(in.*(2^fractional_bits)) ./2^(fractional_bits);
out = min(2^integer_bits, out);
out = max(-2^integer_bits, out);

end