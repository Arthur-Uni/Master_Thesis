function [ y ] = second_order_approx( x )

y = zeros(1, size(x,2));

    for i = 1 : size(x,2)
        if(sign(x(i))== -1)
            y(i) = 0.5*(1-abs(0.25*x(i)))^2;
        else
            y(i) = 1-0.5*(1-abs(0.25*x(i)))^2;
        end
    end
end

