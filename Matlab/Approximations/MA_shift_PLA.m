clear;
close all;
clc;

%% LaTeX font
set(0,'defaulttextinterpreter','latex')

x = linspace(-4,4,801);
y = sig(x);

draw_plot(x,y,'x','f(x)', '\sigma(x)', '', '', set_my_plot_settings());

% plotting parameter
lineWidth = 3;
grid on;
%% PLA segment positive side
p1 = [1 2];
p2 = [0.75 0.875];
line(p1, p2, 'LineWidth', lineWidth, 'Color', 'r')

% horizontal lines
p3 = [1 1];
p4 = [0 0.75];
line(p3, p4, 'LineWidth', lineWidth/2, 'Color', 'r', 'LineStyle', '--');

p5 = [2 2];
p6 = [0 0.875];
line(p5, p6, 'LineWidth', lineWidth/2, 'Color', 'r', 'LineStyle', '--');

%% PLA segment negative side
p7 = [-2 -1];
p8 = [0.125 0.25];
line(p7, p8, 'LineWidth', lineWidth, 'Color', 'r')

% horizontal lines
p9 = [-2 -2];
p10 = [0 0.125];
line(p9, p10, 'LineWidth', lineWidth/2, 'Color', 'r', 'LineStyle', '--');

p11 = [-1 -1];
p12 = [0 0.25];
line(p11, p12, 'LineWidth', lineWidth/2, 'Color', 'r', 'LineStyle', '--');

%% add text to certain data points
t1 = '$$P_{n}$$';
t2 = '$$P_{n-1}$$';
t3 = '$$Q_{n-1}$$';
t4 = '$$Q_{n}$$';

text(-2.3, 0.13, t1, 'FontSize', 16);
text(-1.2, 0.255, t2, 'FontSize', 16);
text(0.7, 0.755, t3, 'FontSize', 16);
text(2.2, 0.88, t4, 'FontSize', 16);