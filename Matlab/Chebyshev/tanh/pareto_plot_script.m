load('pareto_data.mat');

M = [M1 M2 M3];
C = [C1 C2 C3];
N = [N1 N2 N3];

P_C = my_pareto(M,C);
P_N = my_pareto(M,N);

Ones_C = P_C ~= 0;
Ones_X = P_C == 0;
Ones_N = P_N ~= 0;

C_pareto = Ones_C.*C;
M_C = Ones_C.*M;
N_pareto = Ones_N.*N;
M_N = Ones_N.*M;

M_X = Ones_X.*M;
N_X = Ones_X.*N;

M_X(M_X == 0) = [];
N_X(N_X == 0) = [];

N(N == N_pareto) = [];
C(C==C_pareto) = [];

C_pareto(C_pareto == 0) = [];
N_pareto(N_pareto == 0) = [];
M_C(M_C == 0) = [];
M_N(M_N == 0) = [];

set(0,'defaulttextInterpreter','latex');

figure(1);
hold on;
s_M = scatter(N(:), M(:), 50, 'o', 'filled', 'b', 'LineWidth', 1.5);
set(gca, 'FontSize', 16);
xlabel('M');
ylabel('$e_{maxabs}$');
s_pareto_M = scatter(N_pareto(:), M_N(:), 75, 'x', 'r', 'LineWidth', 1.75);