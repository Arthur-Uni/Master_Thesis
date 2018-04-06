function [ y ] = SELU( x, alpha, delta )

y = zeros(1, size(x,2));

    for i = 1 : size(x,2)
        if(sign(x(i))== -1)
            y(i) = delta * alpha * (exp(x(i))-1);
        else
            y(i) = delta * x(i);
        end
    end
end

