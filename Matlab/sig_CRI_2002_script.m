%clear
close all;
clc;
clear;

%parameters

x = -4:0.01:4;
xp = 0:0.01:4;
xn = -4:0.01:0;

%parameters for plot

width = 1;

%CRI interpolation starting functions
g = 0.5.*(1 + 0.5.* xp);
h = 1;

q1 = 1;
q2 = 2;
q3 = 3;
q4 = 4;

%function

sig = sig(x);

%positive x axis

%% 
y1_p = sig_CRI_2002(g, h, q1);
y2_p = sig_CRI_2002(g, h, q2);
y3_p = sig_CRI_2002(g, h, q3);
y4_p = sig_CRI_2002(g, h, q4);
%% 

%negative x axis

%% 
y1_n = fliplr(1-y1_p);
y2_n = fliplr(1-y2_p);
y3_n = fliplr(1-y3_p);
y4_n = fliplr(1-y4_p);
%% 

%y combined

%% 
y1_n(401) = [];
y2_n(401) = [];
y3_n(401) = [];
y4_n(401) = [];

y1 = [y1_n, y1_p];
y2 = [y2_n, y2_p];
y3 = [y3_n, y3_p];
y4 = [y4_n, y4_p];
%% 

%absolute error

%% 
error1 = abs(sig-y1);
error2 = abs(sig-y2);
error3 = abs(sig-y3);
error4 = abs(sig-y4);
max_error1 = max(error1);
mean_error1 = mean(error1);
max_error2 = max(error2);
mean_error2 = mean(error2);
max_error3 = max(error3);
mean_error3 = mean(error3);
max_error4 = max(error4);
mean_error4 = mean(error4);
%% 

%relative error

%% 
rel_error1 = error1./sig;
rel_error2 = error2./sig;
rel_error3 = error3./sig;
rel_error4 = error4./sig;
%% 

%plot approximations

% figure(1);
% plot(x, sig, x,y1, 'linewidth', width);
% xlabel('x');
% ylabel('q = 1');
% grid on;
% grid minor;
% 
% figure(2);
% plot(x, sig, x,y2, 'linewidth', width);
% xlabel('x');
% ylabel('q = 2');
% grid on;
% grid minor;
% 
% figure(3);
% plot(x, sig, x,y3, 'linewidth', width);
% xlabel('x');
% ylabel('q = 3');
% grid on;
% grid minor;
% 
% figure(4);
% plot(x, sig, x,y4, 'linewidth', width);
% xlabel('x');
% ylabel('q = 4');
% grid on;
% grid minor;
% 
% %plot absolute error
% 
% figure(5);
% plot(x,error1, 'linewidth', width);
% xlabel('x');
% ylabel('q = 1');
% grid on;
% grid minor;
% 
% figure(6);
% plot(x,error2, 'linewidth', width);
% xlabel('x');
% ylabel('q = 2');
% grid on;
% grid minor;
% 
% figure(7);
% plot(x,error3, 'linewidth', width);
% xlabel('x');
% ylabel('q = 3');
% grid on;
% grid minor;
% 
% figure(8);
% plot(x,error4, 'linewidth', width);
% xlabel('x');
% ylabel('q = 4');
% grid on;
% grid minor;

%% 
%interploation depth q = 1
figure(1);
subplot(3,1,1);
plot(x,sig, x,y1, 'linewidth', width);
legend('sigmoid','approx')
grid on;
grid minor;
title('approximation q = 1');

subplot(3,1,2);
plot(x,error1,'linewidth', width);
grid on;
grid minor;
title('absolute error');

subplot(3,1,3);
plot(x,rel_error1,'linewidth', width);
grid on;
grid minor;
title('relative error');
%% 

%% 
%interpolation depth q = 2
figure(2);
subplot(3,1,1);
plot(x,sig, x,y2, 'linewidth', width);
legend('sigmoid','approx')
grid on;
grid minor;
title('approximation q = 2');

subplot(3,1,2);
plot(x,error2,'linewidth', width);
grid on;
grid minor;
title('absolute error');

subplot(3,1,3);
plot(x,rel_error2,'linewidth', width);
grid on;
grid minor;
title('relative error');
%% 

%% 
%interpolation depth q = 3
figure(3);
subplot(3,1,1);
plot(x,sig, x,y3, 'linewidth', width);
legend('sigmoid','approx')
grid on;
grid minor;
title('approximation q = 3');

subplot(3,1,2);
plot(x,error3,'linewidth', width);
grid on;
grid minor;
title('absolute error');

subplot(3,1,3);
plot(x,rel_error3,'linewidth', width);
grid on;
grid minor;
title('relative error');
%% 

%% 
%interpolation depth q = 4
figure(4);
subplot(3,1,1);
plot(x,sig, x,y4, 'linewidth', width);
legend('sigmoid','approx')
grid on;
grid minor;
title('approximation q = 4');

subplot(3,1,2);
plot(x,error4,'linewidth', width);
grid on;
grid minor;
title('absolute error');

subplot(3,1,3);
plot(x,rel_error4,'linewidth', width);
grid on;
grid minor;
title('relative error');
%% 
