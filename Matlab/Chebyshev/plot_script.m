clear;
clc;
close all;

% set default interpreter
set(0,'defaulttextInterpreter','latex');

fontSize = 16;

% [M1, MSE1, Coeffs1] = cheb_de_tanh_function(1);
% [M2, MSE2, Coeffs2] = cheb_de_tanh_function(2);
% [M3, MSE3, Coeffs3] = cheb_de_tanh_function(4);
% 
% figure(1);
% hold on;
% 
% plot(M1);
% plot(M2);
% plot(M3);
% xlabel('degree of polynomial $n$', 'FontSize', fontSize);
% ylabel('$e_{maxabs}$', 'FontSize', fontSize);
% set(gca, 'FontSize', fontSize);
% axis([1 10 0 0.35]);
% 
% figure(2);
% hold on;
% 
% plot(MSE1);
% plot(MSE2);
% plot(MSE3);
% xlabel('degree of polynomial $n$', 'FontSize', fontSize);
% ylabel('$e_{mse}$', 'FontSize', fontSize);
% set(gca, 'FontSize', fontSize);
% axis([1 10 0 0.04]);

[M1, MSE1, Coeffs1, C1, N1] = cheb_de_tanh_function_quantized(1);
[M2, MSE2, Coeffs2, C2, N2] = cheb_de_tanh_function_quantized(2);
[M3, MSE3, Coeffs3, C3, N3] = cheb_de_tanh_function_quantized(4);

figure(1);
hold on;

plot(M1);
plot(M2);
plot(M3);
xlabel('degree of polynomial $n$', 'FontSize', fontSize);
ylabel('$e_{maxabs}$', 'FontSize', fontSize);
set(gca, 'FontSize', fontSize);
axis([1 10 0 0.35]);

figure(2);
hold on;

plot(MSE1);
plot(MSE2);
plot(MSE3);
xlabel('degree of polynomial $n$', 'FontSize', fontSize);
ylabel('$e_{mse}$', 'FontSize', fontSize);
set(gca, 'FontSize', fontSize);
axis([1 10 0 0.04]);

M = [M1 M2 M3];
MSE = [MSE1 MSE2 MSE3];
C = [C1 C2 C3];
N = [N1 N2 N3];
% M = M1;
% MSE = MSE1;
% C = C1;
% N = N1;
%% pareto
P_C = cheb_pareto_v2(M, C);
P_N = cheb_pareto_v2(M, N);

Ones_XC = P_C == 0;
Ones_XN = P_N == 0;

N_X = Ones_XN .* N;
MN_X = Ones_XN .* M;

N_X(N_X==0)=[];
MN_X(MN_X==0)=[];

C_X = Ones_XC .* C;
MC_X = Ones_XC .* M;

C_X(C_X==0)=[];
MC_X(MC_X==0)=[];

Ones_C = P_C>0;
Ones_N = P_N>0;

M_pareto_C = Ones_C .* M;
M_pareto_N = Ones_N .* M;
N_pareto = Ones_N .* N;
C_pareto = Ones_C .* C;

M_pareto_C(M_pareto_C==0) = [];
M_pareto_N(M_pareto_N==0) = [];
N_pareto(N_pareto==0) = [];
C_pareto(C_pareto==0) = [];

figure(5)
hold on;
grid on;
s_C = scatter(C(:), M(:), 50, 'filled', 'LineWidth', 1.5);
set(gca, 'FontSize', fontSize);
xlabel('$C$', 'FontSize', fontSize);
ylabel('$e_{maxabs}$', 'FontSize', fontSize);
%title('all points for computational effort');

s_pareto_C = scatter(C_X, MC_X, 75, 'x', 'LineWidth', 1);
%title('pareto front for transistor count');
%legend('possible design points', 'pareto points');

figure(6)
hold on;
grid on;
s_N = scatter(N(:), M(:), 50, 'filled', 'LineWidth', 1.5);
set(gca, 'FontSize', fontSize);
xlabel('$M$', 'FontSize', fontSize);
ylabel('$e_{maxabs}$', 'FontSize', fontSize);
%title('all points for memory utilization');

s_pareto_N = scatter(N_X, MN_X, 75, 'x', 'LineWidth', 1);

%% MSE
P_C = cheb_pareto_v2(MSE, C);
P_N = cheb_pareto_v2(MSE, N);

Ones_XC = P_C == 0;
Ones_XN = P_N == 0;

N_X = Ones_XN .* N;
MN_X = Ones_XN .* MSE;

N_X(N_X==0)=[];
MN_X(MN_X==0)=[];

C_X = Ones_XC .* C;
MC_X = Ones_XC .* MSE;

C_X(C_X==0)=[];
MC_X(MC_X==0)=[];

Ones_C = P_C>0;
Ones_N = P_N>0;

M_pareto_C = Ones_C .* MSE;
M_pareto_N = Ones_N .* MSE;
N_pareto = Ones_N .* N;
C_pareto = Ones_C .* C;

M_pareto_C(M_pareto_C==0) = [];
M_pareto_N(M_pareto_N==0) = [];
N_pareto(N_pareto==0) = [];
C_pareto(C_pareto==0) = [];

figure(8)
hold on;
grid on;
s_C = scatter(C(:), MSE(:), 50, 'filled', 'LineWidth', 1.5);
set(gca, 'FontSize', fontSize);
xlabel('$C$', 'FontSize', fontSize);
ylabel('$e_{mse}$', 'FontSize', fontSize);
%title('all points for computational effort');

s_pareto_C = scatter(C_X, MC_X, 75, 'x', 'LineWidth', 1);
%title('pareto front for transistor count');
%legend('possible design points', 'pareto points');

figure(9)
hold on;
grid on;
s_N = scatter(N(:), MSE(:), 50, 'filled', 'LineWidth', 1.5);
set(gca, 'FontSize', fontSize);
xlabel('$M$', 'FontSize', fontSize);
ylabel('$e_{mse}$', 'FontSize', fontSize);
%title('all points for memory utilization');

s_pareto_N = scatter(N_X, MN_X, 75, 'x', 'LineWidth', 1);