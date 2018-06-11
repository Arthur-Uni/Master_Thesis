function [ y ] = cheb_horner_quantized(S, a, b, n, pts, coeff_wordlength, coeff_fractionlength, input_wordlength, input_fractionlength)
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
dots = linspace(0,1, pts);
dots = fi(dots, true, input_wordlength,input_fractionlength);

horner_wordlength = 2 * input_wordlength + coeff_wordlength + ceil(log2(n));
horner_fractionlength = horner_setup(S,n, horner_wordlength);

% get Chebyshev polynomial approximation coefficients
c_q = cheb_poly_coeffs_quantized(a,b,n,coeff_wordlength,coeff_fractionlength);
% c_q
% c = cheb_poly_coeffs(a,b,n);

%%
% Horner scheme
k = length(dots);
l = length(c_q);
temp = ones(1,k);
temp = temp .* c_q(1);
temp = fi(temp, true, horner_wordlength, horner_fractionlength);

for i=2:l
    temp = temp.*dots + c_q(i);
    % debugging purposes
%     t_temp = abs(temp) > 255.99;
%     if(nnz(t_temp) ~= 0 )
%         warning('bar');
%     end
    
    % quantize temporary result so that wordlength of multiply and add
    % operation does not grow indefinitely
    temp = fi(temp, true, horner_wordlength, horner_fractionlength);
    %temp = fi(temp, true, 32, 31);
end

%%
% quantize the final result to have an output of wordlength bits
temp = fi(temp, 1, input_wordlength, input_fractionlength);

y = temp;

end
