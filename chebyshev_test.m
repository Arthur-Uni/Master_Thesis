x0 = 0.2378;
x1 = 0.2378;
x2 = 0.1470;
x3 = 0;

c0 = 0.25 * (tanh(x0) + tanh(x1) + tanh(x2));
c1 = 0.5 * (tanh(x0)*cos(acos(x0)) + tanh(x1)*cos(acos(x1)) + tanh(x2)*cos(acos(x2)));
c2 = 0.5 * (tanh(x0)*cos(2*acos(x0)) + tanh(x1)*cos(2*acos(x1)) + tanh(x2)*cos(2*acos(x2)));
c3 = 0.5 * (tanh(x0)*cos(3*acos(x0)) + tanh(x1)*cos(3*acos(x1)) + tanh(x2)*cos(3*acos(x2)));

% p(x) = -0.7408 * x^3 -0.5536*x^2 + 0.6178*x + 0.3534 

x = -4:0.01:4;
y = ch_3rd(x, -0.7408, -0.5536, 0.6178, 0.3534);

plot(x,y)