%%
% do chebyshev approximations with a different number of segments
[M1, N1, C1] = cheb_quantized_segmentation(1);
[M2, N2, C2] = cheb_quantized_segmentation(2);
[M3, N3, C3] = cheb_quantized_segmentation(4);

% combine all max absolute errors, memory utilization and computational
% values in one matrix for each metric
M = [M1;M2;M3];
N = [N1;N2;N3];
C = [C1;C2;C3];

%%
% find pareto optimal points over all values
P = cheb_pareto(M, N, C);

% remove values from M, N and C which are zero
Ones = P>0;

M_pareto = Ones .* M;
N_pareto = Ones .* N;
C_pareto = Ones .* C;

M_pareto(M_pareto==0) = [];
N_pareto(N_pareto==0) = [];
C_pareto(C_pareto==0) = [];

%%
%plot

% pareto optimized points
figure(1)
s_pareto = scatter(C_pareto, M_pareto, 75, '*', 'LineWidth', 2.5);

% non pareto optimized points
figure(2)
s = scatter(C(:), M(:), 75, '*', 'r', 'LineWidth', 2.5);