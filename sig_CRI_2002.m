function [ y ] = sig_CRI_2002(g, h, q )

if (q == 1)
    delta = 0.30895;
elseif (q == 2)
    delta = 0.28094;
elseif (q == 3)
    delta = 0.26588;
elseif (q == 4)
    delta = 0.26380;
else
    delta = 0;
end

for i=1:q
    g_dash = min(g,h);
    h = 0.5*(g + h - delta);
    g = g_dash;
    delta = 0.25*delta;
end

y = min(g,h);

end

