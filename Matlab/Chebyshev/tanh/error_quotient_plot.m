% cleanup
clc;
clear;
close all;

%%
% plotting parameters
x = 4:2:32;
width = 2;
fontSize = 16;

%%
% load necessary data from workspace
load('minimum_error.mat');
load('max_abs_error_Y.mat');
load('degree_necessary.mat');
load('max_abs_error_LSB.mat')

%%
% plot constant one
hold on;
grid on;
figure(1);
one = ones(size(x));
plot(x, one .* 1, 'LineWidth', width);
axis([4 30 0 3]);
xlabel('wordlength', 'FontSize', fontSize);
ylabel('error quotient', 'FontSize', fontSize);
set(gca, 'XTick', x, 'FontSize', fontSize);

%%
% plot quotient of error
% q = max_abs_error_Y ./ minimum_error;
% q_lsb = max_abs_error_Y ./ max_abs_error_LSB;

q = minimum_error ./ max_abs_error_Y;
q_lsb = max_abs_error_LSB ./ max_abs_error_Y;

plot(x, q, '-o', 'LineWidth', width);
plot(x, q_lsb, '--', 'LineWidth', 3); 
legend('asymptotic bound','minimum achievable error quotient', '0.5 LSB');
title('quantized Chebyshev approximation maximum absolute error quotient', 'FontSize', fontSize);

min_word = 4;

txt = cell(size(q,1),1);
for iter=1:size(q,1)
    txt{iter}=strcat('n = ', {' '}, num2str(degree_necessary(iter,2)));
end
text(x,q-0.01,txt, 'FontSize', fontSize);