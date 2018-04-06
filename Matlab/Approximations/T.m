function [ y ] = T( x, n )

y = zeros(1, size(x,2));

    for i = 1 : size(x,2)
        if(sign(x(i))== -1)
            y(i) = (1-2^((-1)*x(i)*2^n))/2^((-1)*x(i)*2^n);
        else
            y(i) = (2^(2^n*x(i))-1)/2^(2^n*x(i));
        end
    end

end


