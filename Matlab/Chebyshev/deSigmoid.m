function out  = deSigmoid(z, a, c, coeffs_wordlength, n, segments)
%ACT is the activation function
% %tanh
% out = 1-a.^2;

% %Scaled tanh
A=1.7159;
S=2/3;
% 

wordlength = 16;
fractionlength = wordlength - 1;

z_scaled = S .* z;

z_sat = abs(z_scaled) > 4;

z_de_tanh = z_sat ~= 1;

z_abs = abs(z_scaled);

a_de_tanh = z_de_tanh(:) .* de_cheb_horner_quantized_v2(z_abs(:), segments, 0, 4, n, c, coeffs_wordlength, wordlength, fractionlength);

a_sat = z_sat .* 0.0001;

a_de_tanh = A.*S.*a_de_tanh;

out = (a_sat + a_de_tanh);
%A = 1;
%S = 1;
% out = S*(A - (a.^2)/A);
%out = S*A*(1 - tanh(S*z).^2);

% %Sigmoid
% a =1./(1+exp(-z));
end



