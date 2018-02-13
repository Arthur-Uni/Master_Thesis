function [ y ] =d_LeakyReLU( x, alpha )


y = zeros(1, size(x,2));

    for i = 1 : size(x,2)
        if(sign(x(i))== -1)
            y(i) = alpha;
        else
            y(i) = 1;
        end
    end

end

