%% cleanup
clear;
close all;
clc;

%% inputs
x_fractionlength = 7;
x = -6:2^-x_fractionlength:6;

%% accurate tanh
t = tanh(x);

%% scenario 1
NoE_1 = [4 8 16 32 64];
y_1 = zeros(numel(NoE_1), length(x));
abs_error_1 = zeros(numel(NoE_1), length(x));
rel_error_1 = zeros(numel(NoE_1), length(x));
mse_1 = zeros(numel(NoE_1),1);
NumberOfLUTEntries_1 =  zeros(numel(NoE_1),1);
max_abs_error_1 = zeros(numel(NoE_1),1);

for i=1:numel(NoE_1)
    y_temp = sc1(x, NoE_1(i), x_fractionlength);
    y_1(i, 1:end) = y_temp;
    error_temp = abs(t-y_temp);
    abs_error_1(i, 1:end) = error_temp;
    rel_temp = error_temp ./ t;
    rel_error_1(i, 1:end) = rel_temp;
    mse_1(i,1) = 1/numel(t) .* sum((t-y_temp).^2);
    NumberOfLUTEntries_1(i) = NoE_1(i);
    max_abs_error_1(i) = max(error_temp);
end

%% scenario 2
NoE_2_1 = [4 4 8 8 16];
NoE_2_2 = [4 8 16 32 64];
NoE_2_3 = [2 2 2 2 2];
y_2 = zeros(numel(NoE_2_1), length(x));
abs_error_2 = zeros(numel(NoE_2_1), length(x));
rel_error_2 = zeros(numel(NoE_2_1), length(x));
mse_2 = zeros(numel(NoE_2_1),1);
NumberOfLUTEntries_2 =  zeros(numel(NoE_2_1),1);
max_abs_error_2 = zeros(numel(NoE_2_1),1);

for i=1:numel(NoE_2_1)
    y_temp = sc2(x, NoE_2_1(i), NoE_2_2(i), NoE_2_3(i), x_fractionlength);
    y_2(i, 1:end) = y_temp;
    error_temp = abs(t-y_temp);
    abs_error_2(i, 1:end) = error_temp;
    rel_temp = error_temp ./ t;
    rel_error_2(i, 1:end) = rel_temp;
    mse_2(i,1) = 1/numel(t) .* sum((t-y_temp).^2);
    NumberOfLUTEntries_2(i) = NoE_2_1(i) + NoE_2_2(i) + NoE_2_3(i);
    max_abs_error_2(i) = max(error_temp);
end

%% scenario 3
NoE_3_1 = [4 4 8 8 16];
NoE_3_2 = [8 8 16 16 32];
NoE_3_3 = [8 16 16 32 64];
NoE_3_4 = [4 4 8 8 16];
NoE_3_5 = [2 2 2 2 2];
y_3 = zeros(numel(NoE_2_1), length(x));
abs_error_3 = zeros(numel(NoE_2_1), length(x));
rel_error_3 = zeros(numel(NoE_2_1), length(x));
mse_3 = zeros(numel(NoE_2_1),1);
NumberOfLUTEntries_3 =  zeros(numel(NoE_3_1),1);
max_abs_error_3 = zeros(numel(NoE_3_1),1);

for i=1:numel(NoE_3_1)
    y_temp = sc3(x, NoE_3_1(i), NoE_3_2(i), NoE_3_3(i), NoE_3_4(i), NoE_3_5(i), x_fractionlength);
    y_3(i, 1:end) = y_temp;
    error_temp = abs(t-y_temp);
    abs_error_3(i, 1:end) = error_temp;
    rel_temp = error_temp ./ t;
    rel_error_3(i, 1:end) = rel_temp;
    mse_3(i,1) = 1/numel(t) .* sum((t-y_temp).^2);
    NumberOfLUTEntries_3(i) = NoE_3_1(i) + NoE_3_2(i) + NoE_3_3(i) + NoE_3_4(i) + NoE_3_5(i);
    max_abs_error_3(i) = max(error_temp);
end

%% combine everything
N = [NumberOfLUTEntries_1 NumberOfLUTEntries_2 NumberOfLUTEntries_3];
MSE = [ mse_1 mse_2 mse_3];
M = [max_abs_error_1 max_abs_error_2 max_abs_error_3];

%% pareto plot

% parameters
width = 2.5;
fontSize = 14;

P_MSE = my_pareto(MSE, N);
Ones_MSE = P_MSE > 0;
Ones_X = P_MSE == 0;
N_pareto_MSE = Ones_MSE .* N;
MSE_pareto = Ones_MSE .* MSE;

N_X = Ones_X .* N;
M_X = Ones_X .* MSE;

N_X(N_X==0)=[];
M_X(M_X==0)=[];

N_pareto_MSE(N_pareto_MSE == 0) =[];
MSE_pareto(MSE_pareto == 0) = [];

% mean squared error
figure(1)
hold on;
grid on;
s_MSE = scatter(N(:), MSE(:), 50, 'o', 'filled', 'b', 'LineWidth', 1.5);
set(gca, 'FontSize', fontSize);
xlabel('number of table entries', 'FontSize', fontSize);
ylabel('$e_{mse}$', 'FontSize', fontSize);
%title('all possible points');

s_pareto_MSE = scatter(N_X(:), M_X(:), 75, 'x', 'r', 'LineWidth', 1.75);
%title('pareto points for LUT');
%legend('possible design points', 'pareto points');

% maximum absolute error

P_M = my_pareto(M, N);
Ones_M = P_M > 0;
Ones_X = P_M == 0;
N_pareto_M = Ones_M .* N;
M_pareto = Ones_M .* M;

N_X = Ones_X .* N;
M_X = Ones_X .* M;

N_X(N_X==0)=[];
M_X(M_X==0)=[];

N_pareto_M(N_pareto_M == 0) =[];
M_pareto(M_pareto == 0) = [];

figure(2)
hold on;
grid on;
s_M = scatter(N(:), M(:), 50, 'o', 'filled', 'b', 'LineWidth', 1.5);
set(gca, 'FontSize', fontSize);
xlabel('number of table entries', 'FontSize', fontSize);
ylabel('$e_{maxabs}$', 'FontSize', fontSize);
%title('all possible points');

s_pareto_M = scatter(N_X(:), M_X(:), 75, 'x', 'r', 'LineWidth', 1.75);
%title('pareto points for LUT');
%legend('possible design points', 'pareto points');