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

% calculate quadratic regression
X = [ones(size(x,2),1), x', x.^2'];

% obtain coefficients for: y = ax^2 + bx + c; beta = (X'X)^-1*X'*y
beta = (X'*X)^-1 * X' *y';

r = beta(1) + beta(2) .*dots + beta(3) .* dots.^2;

figure(1)
hold on;
grid on;
plot(dots,r, 'LineWidth', width);
set(gca, 'FontSize', fontSize);
xlabel('combined wordlength', 'FontSize', fontSize);
ylabel('ALM + DSP count', 'FontSize', fontSize);
title('polynomial regression');
scatter(x,y, 75, 'x', 'LineWidth', width);
legend('linear regression line', 'synthesis points');
axis([2 64 0 100]);
x_tick = 4:4:64;
set(gca, 'XTick', x_tick, 'FontSize', fontSize);