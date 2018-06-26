figure(1);
subplot(2,2,1);
y_ks1 = zeros(size(x_ks1));
scatter(x_ks1,y_ks1, 'filled', 'k');
legend('x_k^*');
draw_plot(x,y1,'x','f(x)', 'p(x); n = 1', '', '', set_my_plot_settings());
draw_plot(x,tanh(x),'x','f(x)', 'tanh(x)', '', '', set_my_plot_settings_2());
for i=1:size(x_ks1,2)
    line([0,x_ks1(i)],[tanh(x_ks1(i)),tanh(x_ks1(i))], 'Color', 'black', 'LineStyle', '--', 'LineWidth', 2);
    line([x_ks1(i),x_ks1(i)],[0,tanh(x_ks1(i))], 'Color', 'black', 'LineStyle', '--', 'LineWidth', 2);
end

subplot(2,2,2);
% hold on;
y_ks2 = zeros(size(x_ks2));
scatter(x_ks2,y_ks2, 'filled', 'k');
draw_plot(x,y2,'x','f(x)', 'p(x); n = 2', '', '', set_my_plot_settings());
draw_plot(x,tanh(x),'x','f(x)', 'tanh(x)', '', '', set_my_plot_settings_2());
for i=1:size(x_ks2,2)
    line([0,x_ks2(i)],[tanh(x_ks2(i)),tanh(x_ks2(i))], 'Color', 'black', 'LineStyle', '--', 'LineWidth', 2);
    line([x_ks2(i),x_ks2(i)],[0,tanh(x_ks2(i))], 'Color', 'black', 'LineStyle', '--', 'LineWidth', 2);
end

subplot(2,2,3);
% hold on;
y_ks3 = zeros(size(x_ks3));
scatter(x_ks3,y_ks3, 'filled', 'k');
draw_plot(x,y3,'x','f(x)', 'p(x); n = 3', '', '', set_my_plot_settings());
draw_plot(x,tanh(x),'x','f(x)', 'tanh(x)', '', '', set_my_plot_settings_2());
for i=1:size(x_ks3,2)
    line([0,x_ks3(i)],[tanh(x_ks3(i)),tanh(x_ks3(i))], 'Color', 'black', 'LineStyle', '--', 'LineWidth', 2);
    line([x_ks3(i),x_ks3(i)],[0,tanh(x_ks3(i))], 'Color', 'black', 'LineStyle', '--', 'LineWidth', 2);
end

subplot(2,2,4);
% hold on;
y_ks4 = zeros(size(x_ks4));
scatter(x_ks4,y_ks4, 'filled', 'k');
draw_plot(x,y4,'x','f(x)', 'p(x); n = 4', '', '', set_my_plot_settings());
draw_plot(x,tanh(x),'x','f(x)', 'tanh(x)', '', '', set_my_plot_settings_2());
for i=1:size(x_ks4,2)
    line([0,x_ks4(i)],[tanh(x_ks4(i)),tanh(x_ks4(i))], 'Color', 'black', 'LineStyle', '--', 'LineWidth', 2);
    line([x_ks4(i),x_ks4(i)],[0,tanh(x_ks4(i))], 'Color', 'black', 'LineStyle', '--', 'LineWidth', 2);
end
