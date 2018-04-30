a = 0;
b = 4;

n0 = 0;
n1 = 1;
n2 = 2;
n3 = 3;

q_en = 0;

wordlength = 0;
var = 0;

width = 3;

x = linspace (a,b);
t = tanh(x);

y1 = cheb_horner(a, b, n0, q_en, wordlength, var);
y2 = cheb_horner(a, b, n1, q_en, wordlength, var);
y3 = cheb_horner(a, b, n2, q_en, wordlength, var);
y4 = cheb_horner(a, b, n3, q_en, wordlength, var);

abs_error = max(abs(t-y1));
mse = immse(y1, t);

figure
grid on;
subplot(2,2,1)       % add first plot in 2 x 2 grid
plot(x, t, x, y1, 'LineWidth', width);
title('degree of polynomial = 0')

subplot(2,2,2)       % add second plot in 2 x 2 grid
plot(x, t, x, y2, 'LineWidth', width);
title('degree of polynomial = 1')

subplot(2,2,3)       % add third plot in 2 x 2 grid
plot(x, t, x, y3, 'LineWidth', width);
title('degree of polynomial = 2')

subplot(2,2,4)       % add fourth plot in 2 x 2 grid 
plot(x, t, x, y4, 'LineWidth', width);
title('degree of polynomial = 3')

suptitle('Chebyshev polynomial approximations of hyperbolic tangent');