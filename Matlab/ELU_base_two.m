function [ y ] = ELU_base_two( x, alpha )

y = zeros(1, size(x,2));

    for i = 1 : size(x,2)
        if(sign(x(i))== -1)
            y(i) = alpha * (2^(1.5*x(i))-1);
        else
            y(i) = x(i);
        end
    end

end

