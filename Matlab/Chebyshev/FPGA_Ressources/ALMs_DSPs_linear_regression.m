% obtained data from Quartus for different input and coefficient
% wordlengths

% sum of input wordlength and coefficient wordlength
x = [2, 4, 8, 16, 20, 24, 32, 48, 48, 64];
x_mean = mean(x);

% sum of ALMs and DSP for each value of x
y = [7, 6, 10, 16, 22, 22, 29, 65, 63, 96];
y_mean = mean(y);

% plotting parameters
dots = linspace(min(x), max(x));
width = 3;
fontSize = 16;

% calculation of a and b for linear regression y(x) = a * x + b
x_temp = x - x_mean;
y_temp = y - y_mean;

numerator = sum(x_temp .* y_temp);
denominator = sum(x_temp.^2);

a = numerator / denominator;

b = mean(y - a .* x);

r = a .* dots + b;

figure(1)
hold on;
grid on;
plot(dots,r, 'LineWidth', width);
set(gca, 'FontSize', fontSize);
xlabel('combined wordlength', 'FontSize', fontSize);
ylabel('ALM + DSP count', 'FontSize', fontSize);
title('linear regression');
scatter(x,y, 75, 'x', 'LineWidth', width);
legend('linear regression line', 'synthesis points');
axis([2 64 0 100]);
x_tick = 4:4:64;
set(gca, 'XTick', x_tick, 'FontSize', fontSize);