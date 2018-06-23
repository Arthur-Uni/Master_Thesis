function [ y ] = ELU( x, alpha )
    
y = max(0,x) + min(0,alpha.*(exp(x)-1));

end

