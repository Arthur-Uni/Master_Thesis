x = 4:2:32;
width = 2;
%%
% load necessary data from workspace
load('minimum_error.mat');
load('max_abs_error_Y.mat');
load('degree_necessary.mat');

%%
% plot constant one
hold on;
grid on;
figure(1);
one = ones(size(x));
plot(x, one .* 1, 'LineWidth', width);
axis([4 32 0 1.2]);
xlabel('wordlength', 'FontSize', 16);
ylabel('error quotient', 'FontSize', 16);
set(gca, 'XTick', x, 'FontSize', 16);

%%
% plot quotient of error
q = max_abs_error_Y ./ minimum_error;

plot(x, q, 'LineWidth', width);
legend('asymptotic bound','minimum achievable error quotient', 'FontSize', 16);
title('quantized Chebyshev approximation maximum absolute error quotient', 'FontSize', 18);

min_word = 4;

txt = cell(size(q,1),1);
for iter=1:size(q,1)
    txt{iter}=strcat('n = ', {' '}, num2str(degree_necessary(iter,2)));
end
text(x,q-0.01,txt, 'FontSize', 14);