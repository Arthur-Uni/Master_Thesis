function [ y ] = ep2( x, enable )

if(enable)
    y = 2.^(1.5.*x);
else
    y = 2.^(1.44.*x);
end

end

