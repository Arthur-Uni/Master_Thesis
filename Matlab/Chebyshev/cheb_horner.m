function [ y ] = cheb_horner( a, b, n, q_en, mode, wordlength, var)
%  Parameters:
%
%    Input, real a, b, the domain of definition.
%
%    Input, integer n, the order of the polynomial
%
%    Input, boolean q_en, enable quantization
%
%    Input, integer mode, quantization mode: 1 = fixed point, 2 = floating point
%
%    Input, integer wordlength
%
%    Input, integer var
%
%    Output, vector y, final polynomial approximation

% F = fimath('OverflowAction','Saturate','RoundingMethod','Round');
% F.ProductMode = 'SpecifyPrecision';
% F.SumMode = 'SpecifyPrecision';
% F.ProductWordLength = 48 + ceil(log2(n+1));
% F.SumWordLength = 48 + ceil(log2(n+1));
% F.ProductFractionLength = 48 + ceil(log2(n+1)) - 1;
% F.SumFractionLength = 48 + ceil(log2(n+1)) - 1;

dots = linspace(0,1);
dots = fi(dots, true, 16,15);

c = cheb_poly_coeffs(a,b,n,q_en,mode,wordlength,var);
% c.bin
% c.int
% c.value

k = length(dots);
l = length(c);
temp = fi(ones(1,k), true, wordlength, var);
% temp.fimath = F;
% dots.fimath = F;
%c.fimath = F;
temp(:) = c(1);

for i=2:l
    temp = temp.*dots + c(i);
%      if(q_en)
%          temp = fi(temp, true, 2*wordlength, 2*wordlength-1);
%      end
end

% if(q_en)
%     temp = fi(temp, true, wordlength, var);
% end

y = temp;

end

