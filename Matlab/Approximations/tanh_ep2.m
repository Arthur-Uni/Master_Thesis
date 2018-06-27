function [ y ] = tanh_ep2( x, enable )

y = (ep2(x,enable)-ep2(-x, enable))./(ep2(x,enable)+ep2(-x, enable));

end

