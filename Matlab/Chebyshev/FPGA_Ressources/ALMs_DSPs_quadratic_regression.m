% obtained data from Quartus for different input and coefficient
% wordlengths

%load('extracted_data.mat');

% sum of input wordlength and coefficient wordlength
% x = [2, 4, 8, 16, 20, 24, 32, 48, 48, 64];
% x = combinedwordlength;
x = NumberofEntries;
x_mean = mean(x);

% sum of ALMs and DSP for each value of x
% y = [7, 6, 10, 16, 22, 22, 29, 65, 63, 96];
y = ALM;
y_mean = mean(y);

% plotting parameters
dots = linspace(min(x), max(x));
width = 2;
fontSize = 16;

% calculate quadratic regression
X = [ones(size(x,1),1), x, x.^2];

% obtain coefficients for: y = ax^2 + bx + c; beta = (X'X)^-1*X'*y
beta = (X'*X)^-1 * X' *y;

temp = 0;

for i = 1:length(beta)
    temp = temp + beta(i) .* dots.^(i-1);
end
%r = beta(1) + beta(2) .*dots + beta(3) .* dots.^2;
r = temp;

figure(1)
hold on;
grid on;
scatter(x,y, 25, 'filled', 'LineWidth', width);
axis([min(x) max(x) 0 max(y)+5]);
plot(dots,r, 'LineWidth', width);
set(gca, 'FontSize', fontSize);
xlabel('combined wordlength', 'FontSize', fontSize);
ylabel('ALM + DSP count', 'FontSize', fontSize);
%title('polynomial regression');
legend('synthesis points', 'polynomial regression line');
%x_tick = 4:4:max(x);
%set(gca, 'XTick', x_tick, 'FontSize', fontSize);
set(gca,'FontSize', fontSize);