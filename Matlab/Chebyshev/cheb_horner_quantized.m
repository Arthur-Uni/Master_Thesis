function [ y ] = cheb_horner_quantized( a, b, n, temp_wordlength, temp_fract, coeff_wordlength, coeff_fractionlength, input_wordlength, input_fractionlength)
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
%    Output, vector y, Chebyshev polynomial approximation points

%%
% other parameters


%%
% evaluate polynomial approximation at [0,1]
dots = linspace(0,1);
dots = fi(dots, true, input_wordlength,input_fractionlength);
% get Chebyshev polynomial approximation coefficients
c = cheb_poly_coeffs_quantized(a,b,n,coeff_wordlength,coeff_fractionlength);
%c = cheb_poly_coeffs_quantized(a,b,n,wordlength,fract);

% debuggin purposes
% c_temp = c>1;
% if(nnz(c_temp) ~= 0)
%     warning('foo');
% end

%%
% Horner scheme
k = length(dots);
l = length(c);
temp = fi(ones(1,k), true, temp_wordlength, temp_fract, 'RoundingMethod', 'Round');
%temp = ones(1,k);
temp(:) = c(1);

for i=2:l
    temp = temp.*dots + c(i);
    % debugging purposes
%     t_temp = temp > 1;
%     if(nnz(t_temp) ~= 0 )
%         warning('bar');
%     end
    
    % quantize temporary result so that wordlength of multiply and add
    % operation does not grow indefinitely
    temp = fi(temp, true, temp_wordlength + coeff_wordlength, (temp_wordlength + coeff_wordlength)-2);
    %temp = fi(temp, true, 32, 31);
end

%%
% quantize the final result to have an output of wordlength bits
temp = fi(temp, true, temp_wordlength, temp_fract);

y = temp;

end
