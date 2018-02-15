%Third Order Chebyshev Approximation of tanh

%clear
close all;
clc;
clear;

%inputs
x = -1:0.01:1;

%plot parameters
width = 1;

%Chebyshev polynomials
syms x_cheb;
T_cheb = chebyshevT([0, 1, 2, 3], x_cheb);

%Chebyshev coeefficients
c0 = 0;
c1 = 0.8119;
c2 = 0;
c3 = -0.0591;

%Chebyshev approximation (c0 and c2 approximately 0) after simplification
y_approx = -0.2364.*x.^3 + 0.9892.*x;

y = tanh(x);

%absolute error
error = abs(y - y_approx);
max_error = max(error);

%relative error
rel_error = error./y;

%%
%plots
%interploation depth n = 4
figure(1);
subplot(3,1,1);
plot(x,y, x,y_approx, 'linewidth', width);
legend('tanh','approx')
grid on;
grid minor;
title('3rd order chebyshev interpolation');

subplot(3,1,2);
plot(x,error,'linewidth', width);
grid on;
grid minor;
title('absolute error');

subplot(3,1,3);
plot(x,rel_error,'linewidth', width);
grid on;
grid minor;
title('relative error');
%% 