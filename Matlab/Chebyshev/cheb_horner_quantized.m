function [ y ] = cheb_horner_quantized( a, b, n, wordlength, fract)
%  Parameters:
%
%    Input, real a, b, the domain of definition.
%
%    Input, integer n, the order of the polynomial
%
%    Input, boolean q_en, enable quantization
%
%    Input, integer wordlength, total wordlength
%
%    Input, integer fract, fractional bits of total wordlength
%
%    Output, vector c_poly, final polynomial coefficients quantized

dots = linspace(0,1);
dots = fi(dots, true, 16,15);

c = cheb_poly_coeffs_quantized(a,b,n,16,14);
%c = cheb_poly_coeffs_quantized(a,b,n,wordlength,fract);

k = length(dots);
l = length(c);
temp = fi(ones(1,k), true, wordlength, fract, 'RoundingMethod', 'Round');
%temp = ones(1,k);
temp(:) = c(1);

for i=2:l
    temp = temp.*dots + c(i);
    
    %quantize temporary result so that wordlength of multiply and add
    %operation does not grow indefinitely
    temp = fi(temp, true, 2*wordlength, 2*wordlength-1);
    %temp = fi(temp, true, 32, 31);
end

% quantize the final result to have an output of wordlength bits
temp = fi(temp, true, wordlength, fract);

y = temp;

end
