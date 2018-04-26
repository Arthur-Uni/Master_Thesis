%%cleanup
clc;
clear;

%%
% parameters

% interval [a,b]: length must be a power of two so that the interval can be
% divided into powers of two
a = 0;
b = 8;

% number of points for linspace function
pts = 100;

%%
% do chebyshev approximations with a different number of segments
[M1, N1, C1] = cheb_segmentation(1,a,b,pts);
[M2, N2, C2] = cheb_segmentation(2,a,b,pts);
[M3, N3, C3] = cheb_segmentation(4,a,b,pts);
[M4, N4, C4] = cheb_segmentation(8,a,b,pts);

% combine all max absolute errors, memory utilization and computational
% values in one matrix for each metric
M = [M1; M2; M3; M4];
N = [N1; N2; N3; N4];
C = [C1; C2; C3; C4];

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
s_pareto = scatter(C_pareto, M_pareto, 75, 'x', 'LineWidth', 2.5);

% non pareto optimized points
figure(2)
s = scatter(C(:), M(:), 75, 'x', 'r', 'LineWidth', 2.5);