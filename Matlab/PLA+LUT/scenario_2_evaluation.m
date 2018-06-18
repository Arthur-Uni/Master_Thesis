%% inputs
x_fractionlength = 16;
x = -4:2^-x_fractionlength:4;

NoE_1 = 4;
NoE_2 = 8;
NoE_3 = 2;

[ y, LUT_Entries ] = sc2(x, NoE_1, NoE_2, NoE_3, x_fractionlength);

%% error calculations
t = tanh(x);
abs_error = abs(t-y);
rel_error = abs_error ./ t;
mse = 1/numel(t) .* sum((t-y).^2);

%% plot

% parameters
width = 2;
fontSize = 14;

figure(1)

% subplot(3,1,1);
hold on;
plot(x, t, 'LineWidth', width);
plot(x, y, 'LineWidth', width);
xlabel('x', 'FontSize', fontSize);
ylabel('f(x)', 'FontSize', fontSize);
set(gca, 'FontSize', fontSize);

% subplot(3,1,2);
% plot(x, abs_error, 'LineWidth', width);
% xlabel('x', 'FontSize', fontSize);
% ylabel('absolute error', 'FontSize', fontSize);
% set(gca, 'FontSize', fontSize);
% 
% subplot(3,1,3);
% plot(x, rel_error, 'LineWidth', width);
% xlabel('x', 'FontSize', fontSize);
% ylabel('relative error', 'FontSize', fontSize);
% set(gca, 'FontSize', fontSize);