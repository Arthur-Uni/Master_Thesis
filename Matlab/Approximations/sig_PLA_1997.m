function [ y ] = sig_PLA_1997( x )

y = zeros(1, size(x,2));

    for i=1:size(x,2)
    
        if((x(i)) >= 5)
            y(i) = 1;
        elseif ((x(i)) < 5 && (x(i)) >= 2.375)
            y(i) = 0.03125*(x(i)) + 0.84375;
        elseif ((x(i)) < 2.375 && (x(i)) >= 1)
            y(i) = 0.125 * (x(i)) + 0.625;
        elseif ((x(i))<1 && (x(i))>= 0)
            y(i) = 0.25*(x(i))+0.5;
        elseif (x(i) < 0 && x(i) >-1)
            y(i) = 0.25*(x(i))+0.5;
        elseif (x(i) <= -1 && x(i) > -2.375)
            y(i) = 1 - (0.125 * abs(x(i)) + 0.625);
        elseif (x(i) <= -2.375 && x(i) > -5)
            y(i) = 1 - (0.03125*abs(x(i)) + 0.84375);
        elseif((x(i)) <= -5)
            y(i) = 0;
        end
   
    end

end

