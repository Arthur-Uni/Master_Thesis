%cleanup
clear;
clc;
close all;

%parameter

width1 = 4.5;
width2 = 1.5;
x = -8:0.01:8;
t = tanh(x);

%% 
%sigmoid 1991 approximation
xp = 0:0.01:8;
xn = -8:0.01:0;

%negative x
yn = 2.*sig_PLA_1991(2.*xn)-1;

%positive x
yp = -fliplr(yn);

%combined
yn(801) =[];
y_sig = [yn, yp];
%% 

%% 
%chebyshev approximation
a1 = -8;
b1 = -4;
a2 = -4;
b2 = -2;
a3 = -2;
b3 =  2;
a4 =  2;
b4 =  4;
a5 =  4;
b5 =  8;

n1 = 8;
n2 = 8;
n3 = 8;
n4 = 8;
n5 = 8;

y1 = cheb_poly_approx(a1,b1,n1,0,0,0,0);
y2 = cheb_poly_approx(a2,b2,n2,0,0,0,0);
y3 = cheb_poly_approx(a3,b3,n3,0,0,0,0);
y4 = cheb_poly_approx(a4,b4,n4,0,0,0,0);
y5 = cheb_poly_approx(a5,b5,n5,0,0,0,0);

y1(401) = [];
y2(201) = [];
y3(401) = [];
y4(201) = [];

y_temp = [y1, y2, y3, y4, y5];
y_cheb = eval(y_temp);
%% 
hold on;
%plot
figure(1);

%all in one
plot(x,t, 'linewidth', width1);
plot(x,y_sig, x,y_cheb, 'linewidth', width2);
legend('tanh(x)','S(x)', 'C(x)');

%tanh and shift
%plot(x,t, x,y_sig, 'linewidth', width);
%legend('tanh','shift approximation');

%tanh and cheb
% plot(x,t, x,y_cheb, 'linewidth', width);
% legend('tanh','chebyshev approximation');

grid on;
xlabel('x');
ylabel('y');
set(gca,'fontsize', 14);