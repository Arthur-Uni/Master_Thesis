function [ integ, fract ] = Integ_Fract_Separation( x )
   integ = fix(x);
   fract = abs(x-integ);
end

