clear;
clc;

%% get extracted data from excel
load('extracted_data.mat');

%% transistor count model for one multiplier and one adder
t = (2.*WL+CL).*28 + WL.*CL.*6 + 12.*WL + (WL.*CL-WL-CL).*28;

%% polynomial regression
% sum of input wordlength and coefficient wordlength
% x = [2, 4, 8, 16, 20, 24, 32, 48, 48, 64];
x = combinedwordlength;
x_mean = mean(x);

% sum of ALMs and DSP for each value of x
% y = [7, 6, 10, 16, 22, 22, 29, 65, 63, 96];
y = ALMDSP;
y_mean = mean(y);

beta = regression_betas(x,y);

r = beta(1) + beta(2) .* x + beta(3) .* x.^2;

%% normalization
r = r ./ max(r);
t = t ./ max(t);

%% correlation
r_mean = mean(r);
t_mean = mean(t);

covar = sum((t-t_mean).*(r-r_mean))/(size(r,1));

rho = covar/(std(r).*std(t));
%% plot

width = 3;
fontSize = 16;

figure(1)
hold on;
grid on;
set(gca, 'FontSize', fontSize);
xlabel('normalized transistor count', 'FontSize', fontSize);
ylabel('normalized LUT+DSP count', 'FontSize', fontSize);
title('correlation');
txt = strcat({'correlation coefficient:'},{' '} ,{num2str(rho)});
text(0.8, 0.05, txt, 'FontSize', fontSize, 'Color','blue');
scatter(t,r, 75, 'x', 'LineWidth', width);

figure(2)
hold on;
grid on;
scatter(x,t, 75, 'x', 'LineWidth', width);
scatter(x,r, 75, 'x', 'LineWidth', width);
set(gca, 'FontSize', fontSize);
xlabel('combined wordlength', 'FontSize', fontSize);
ylabel('normalized values', 'FontSize', fontSize);
legend('normalized transistor count','normalized LUT+DSP count', 'location', 'southeast');