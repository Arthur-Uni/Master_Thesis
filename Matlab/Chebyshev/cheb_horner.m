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

dots = linspace(0,1);
dots = fi(dots, true, 16,15);

c = cheb_poly_coeffs(a,b,n,q_en,mode,wordlength,var);
% c.bin
% c.int
% c.value

k = length(dots);
l = length(c);
temp = c(1)*ones(1,k);
if(q_en)
    temp = fi(temp,true,2*wordlength,2*wordlength-1);
end
for i=2:l
    temp = temp.*dots + c(i);
    temp1 = temp.bin
     if(q_en)
         temp = fi(temp, true, 2*wordlength, 2*wordlength-1)
         temp2 = temp.bin
     end
end

% if(q_en)
%     temp = fi(temp, true, wordlength, var);
% end

y = temp;

end

