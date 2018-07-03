%% LaTeX font
set(0,'defaulttextinterpreter','latex')

lineWidth = 3;

figure(1);
%% first plot
subplot(1,3,1);

draw_plot(x_1,y_1,'x','f(x)', 'hybrid_{sc1}(x)', '', '', set_my_plot_settings_2());
draw_plot(x_1,tanh(x_1),'x','f(x)', 'tanh(x)', '', '', set_my_plot_settings_2());

p1 = [0.5 0.5];
p2 = [0 1];

p3 = [2.5 2.5];

line(p1, p2, 'LineWidth', lineWidth/2, 'Color', 'k', 'LineStyle', '--');
line(p3, p2, 'LineWidth', lineWidth/2, 'Color', 'k', 'LineStyle', '--');

%% second plot
subplot(1,3,2);
draw_plot(x_2,y_2,'x','f(x)', 'hybrid_{sc2}(x)', '', '', set_my_plot_settings_2());
draw_plot(x_2,tanh(x_2),'x','f(x)', 'tanh(x)', '', '', set_my_plot_settings_2());

p4 = [1 1];
p5 = [3 3];
p6 = [4 4];

line(p1, p2, 'LineWidth', lineWidth/2, 'Color', 'k', 'LineStyle', '--');
line(p4, p2, 'LineWidth', lineWidth/2, 'Color', 'k', 'LineStyle', '--');
line(p5, p2, 'LineWidth', lineWidth/2, 'Color', 'k', 'LineStyle', '--');
line(p6, p2, 'LineWidth', lineWidth/2, 'Color', 'k', 'LineStyle', '--');

%% third plot
subplot(1,3,3);
draw_plot(x_3,y_3,'x','f(x)', 'hybrid_{sc3}(x)', '', '', set_my_plot_settings_2());
draw_plot(x_3,tanh(x_3),'x','f(x)', 'tanh(x)', '', '', set_my_plot_settings_2());

p7 = [0.25 0.25];
p8 = [2 2];

line(p7, p2, 'LineWidth', lineWidth/2, 'Color', 'k', 'LineStyle', '--');
line(p1, p2, 'LineWidth', lineWidth/2, 'Color', 'k', 'LineStyle', '--');
line(p4, p2, 'LineWidth', lineWidth/2, 'Color', 'k', 'LineStyle', '--');
line(p5, p2, 'LineWidth', lineWidth/2, 'Color', 'k', 'LineStyle', '--');
line(p6, p2, 'LineWidth', lineWidth/2, 'Color', 'k', 'LineStyle', '--');
line(p8, p2, 'LineWidth', lineWidth/2, 'Color', 'k', 'LineStyle', '--');