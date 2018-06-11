function [ y ] = cheb_horner_quantized_v2(x, S, a, b, n, c_q, coeff_wordlength, input_wordlength, input_fractionlength)
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
x_transform = (x-a) .* (1/(b-a));
x_transform = fi(x_transform, true, input_wordlength, input_fractionlength);
x_transform = double(x_transform);

adder_widening = ceil(log2(n));
adder_out_wordlength = 2 * input_wordlength + coeff_wordlength + adder_widening;
adder_out_fractionlength = adder_out_wordlength - 3;
temp_wordlength = horner_setup(S,n, input_wordlength + coeff_wordlength);

% get Chebyshev polynomial approximation coefficients
% c_q = cheb_poly_coeffs_quantized(a,b,n,coeff_wordlength,coeff_fractionlength);
% c_q
% c = cheb_poly_coeffs(a,b,n);

%%
% Horner scheme
k = length(x);
l = length(c_q);
c_q = double(c_q);
temp = ones(1,k);
temp = temp .* c_q(1);
temp = fi(temp, true, adder_out_wordlength, adder_out_fractionlength);
temp = double(temp);

for i=2:l
    temp = temp.*x_transform + c_q(i);
    % debugging purposes
    % t_temp = abs(temp) > 255.99;
    % if(nnz(t_temp) ~= 0 )
    %    warning('bar');
    % end
    
    % quantize temporary result so that wordlength of multiply and add
    % operation does not grow indefinitely
    temp = fi(temp, true, input_wordlength + coeff_wordlength, temp_wordlength);
    temp = double(temp);
end

%%
% quantize the final result to have an output of wordlength bits
temp = fi(temp, 1, input_wordlength, input_fractionlength);

y = double(temp);

end
