function [ y ] = de_cheb_horner_quantized_v2(x, S, a, b, n, c, coeff_wordlength, input_wordlength, input_fractionlength)
%% evaluate polynomial approximation at [0,1]
x_transform = (x-a) .* (1/(b-a));
% x_transform = fi(x_transform, true, input_wordlength, input_fractionlength);
% x_transform = double(x_transform);
x_transform = fixed_point(x_transform, input_wordlength-input_fractionlength, input_fractionlength);

adder_widening = ceil(log2(n));
adder_out_wordlength = 2 * input_wordlength + coeff_wordlength + adder_widening;
adder_out_fractionlength = de_coeffs_setup_fract(S, n, adder_out_wordlength);
temp_wordlength = de_horner_setup(S,n, input_wordlength + coeff_wordlength);

%%
% Horner scheme
k = length(x);
l = length(c);
c = double(c);
temp = ones(1,k);
temp = temp .* c(1);
temp = fixed_point(temp, adder_out_wordlength-adder_out_fractionlength, adder_out_fractionlength);

% MA = zeros(l, 100);

for i=2:l
    temp = temp.*x_transform + c(i);
%     MA(i-1, 1:end) = temp;
    % debugging purposes
    % t_temp = abs(temp) > 255.99;
    % if(nnz(t_temp) ~= 0 )
    %    warning('bar');
    % end
    
    % quantize temporary result so that wordlength of multiply and add
    % operation does not grow indefinitely
    temp = fixed_point(temp, (input_wordlength+coeff_wordlength)-temp_wordlength, temp_wordlength);
end
%%
% max(max(MA))
% min(min(MA))
temp = fixed_point(temp, input_wordlength-input_fractionlength, input_fractionlength);

y = temp;

end

