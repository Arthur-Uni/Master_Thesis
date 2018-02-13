function [ y ] = ELU( x, alpha )

y = zeros(1, size(x,2));

%     for i = 1 : size(x,2)
%         if(sign(x(i))== -1)
%             y(i) = alpha * (exp(x(i))-1);
%         else
%             y(i) = x(i);
%         end
%     end
    
y = max(0,x) + min(0,alpha.*(exp(x)-1));

end

