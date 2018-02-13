function [ y ] = tanh_isosceles_2008( x )

y = zeros(1, size(x,2));

    for i = 1:size(x,2)
        if(x(i)>=-2 && x(i) <=2)
            y(i) = x(i) -0.25*sign(x(i))*x(i)^2;
        else
            y(i) = sign(x(i));
        end
    end

end

