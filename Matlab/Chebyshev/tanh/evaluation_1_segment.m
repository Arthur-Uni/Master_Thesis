%% 1 segment
clear;
clc;
%close all;

S = 1;
a = 0;
b = 4;
n = 10;

x = linspace(0,4,101);

c8 = cheb_poly_coeffs_quantized(a,b,n,8, coeffs_setup( S, n, 8 ));
c12 = cheb_poly_coeffs_quantized(a,b,n,12, coeffs_setup( S, n, 12 ));
c16 = cheb_poly_coeffs_quantized(a,b,n,16, coeffs_setup( S, n, 16 ));
c24 = cheb_poly_coeffs_quantized(a,b,n,24, coeffs_setup( S, n, 24 ));
c32 = cheb_poly_coeffs_quantized(a,b,n,32, coeffs_setup( S, n, 32 ));

c = cheb_poly_coeffs(a,b,n);

y8 = cheb_horner_v3(x, a, b, c8);
y12 = cheb_horner_v3(x, a, b, c12);
y16 = cheb_horner_v3(x, a, b, c16);
y24 = cheb_horner_v3(x, a, b, c24);
y32 = cheb_horner_v3(x, a, b, c32);

y = cheb_horner_v3(x,a,b,c);

%% error
mse8 = immse(y,y8);
mse12 = immse(y,y12);
mse16 = immse(y,y16);
mse24 = immse(y,y24);
mse32 = immse(y,y32);

abs8 = max(abs(y-y8));
abs12 = max(abs(y-y12));
abs16 = max(abs(y-y16));
abs24 = max(abs(y-y24));
abs32 = max(abs(y-y32));


abs = [abs8 abs12 abs16 abs24 abs32];
mse = [mse8 mse12 mse16 mse24 mse32];
C = [8 12 16 24 32];