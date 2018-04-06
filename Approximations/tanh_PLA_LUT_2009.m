function [ y ] = tanh_PLA_LUT_2009( x, s, w)
 
sig = 1./(1+exp(-(x)));
y = zeros(1, size(x,2));
y = fi(y,s,w);
x = fi(x,s,w);

    for i = 1 : size(x,2)
        if(sign(x(i))== -1)
            if((x(i) < 0) && (x(i) >= -1))
                y(i) = x(i);
            else
                y(i) = -1;
            end
        else
            if((x(i) >=0) && (x(i) <= 1))
                y(i) = x(i);
            else
                y(i) = 1;
            end
        end
    end

error = y-sig;
 
error = fi(error, s, w);
 
y = y-error;

end

