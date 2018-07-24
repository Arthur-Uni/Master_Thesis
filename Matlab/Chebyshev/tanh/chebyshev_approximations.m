S = 4;

a = 0;
b = 4;

pts = 100;

% number of segments with a size of integer power of two
S_POT = log2(S)+1;

interval_size = b-a;
max_step_size = interval_size / S;

if(mod(b-a, 2) ~= 0 || a >= b)
    error('interval size is not a power of two or left border of interval is bigger than the right');
end

%combine a and b in matrix AB
AB_POT = zeros(S_POT,2);

%%
% create matrices for intervals to the power of two in [a,b] and save boundaries of
% each segment in matrix AB
for i=1:S_POT
    AB_POT(i,1) = floor(S/(2^i)) * max_step_size;
    AB_POT(i,2) = S/(2^(i-1)) * max_step_size;
end

%flip matrices upside down
AB_POT = flipud(AB_POT);

%%
% function to approximate(tanh in this case)
Y_POT = zeros(S_POT,pts);
for i=1:S_POT
    x = linspace(AB_POT(i,1), AB_POT(i,2),pts);
    Y_POT(i,1:pts) = tanh(x);
end

%%
% uncomment this section for 2 segments if you want to see all
% approximations

Y1_POT = Y_POT(1,1:pts-1);
Y2_POT = Y_POT(2,1:pts);
Y_POT = [Y1_POT,Y2_POT];

%%
% uncomment this section for 3 segments if you want to see all
% approximations
% Y1_POT = Y_POT(1,1:pts);
% Y2_POT = Y_POT(2,1:pts);
% Y3_POT = Y_POT(3,1:pts);
% Y_POT = [Y1_POT, Y2_POT, Y3_POT];

%%
% parameters
n0 = 0;
n1 = 1;
n2 = 2;
n3 = 3;

q_en = 0;

wordlength = 0;
var = 0;

%%
% chebyshev approximation


% % matrices storing polynomial approximation values calculated for each segment
P_POT_0 = zeros(S_POT,pts);
P_POT_1 = zeros(S_POT,pts); 
P_POT_2 = zeros(S_POT,pts); 
P_POT_3 = zeros(S_POT,pts);

for i = 1:S_POT
    P_POT_0(i,1:pts) = cheb_horner(AB_POT(i,1), AB_POT(i,2), n0, q_en, wordlength, var);
end

%%
% uncomment this for 2 segments
P1_POT_0 = P_POT_0(1,1:pts);
P2_POT_0 = P_POT_0(2,1:pts);
P_POT_0 = [P1_POT_0,P2_POT_0];
y0 = P_POT_0;

%%
% uncomment this section for 3 segments
% P1_POT_0 = P_POT_0(1,1:pts);
% P2_POT_0 = P_POT_0(2,1:pts);
% P3_POT_0 = P_POT_0(3,1:pts);
% P_POT_0 = [P1_POT_0,P2_POT_0, P3_POT_0];
% y0 = P_POT_0;

for i = 1:S_POT
    P_POT_1(i,1:pts) = cheb_horner(AB_POT(i,1), AB_POT(i,2), n1, q_en, wordlength, var);
end

%%
% uncomment this for 2 segments
P1_POT_1 = P_POT_1(1,1:pts);
P2_POT_1 = P_POT_1(2,1:pts);
P_POT_1 = [P1_POT_1,P2_POT_1];
y1 = P_POT_1;

%%
% uncomment this section for 3 segments
% P1_POT_1 = P_POT_1(1,1:pts);
% P2_POT_1 = P_POT_1(2,1:pts);
% P3_POT_1 = P_POT_1(3,1:pts);
% P_POT_1 = [P1_POT_1,P2_POT_1, P3_POT_1];
% y1 = P_POT_1;

for i = 1:S_POT
    P_POT_2(i,1:pts) = cheb_horner(AB_POT(i,1), AB_POT(i,2), n2, q_en, wordlength, var);
end

%%
% uncomment this for 2 segments
P1_POT_2 = P_POT_2(1,1:pts);
P2_POT_2 = P_POT_2(2,1:pts);
P_POT_2 = [P1_POT_2,P2_POT_2];
y2 = P_POT_2;

%%
% uncomment this section for 3 segments
% P1_POT_2 = P_POT_2(1,1:pts);
% P2_POT_2 = P_POT_2(2,1:pts);
% P3_POT_2 = P_POT_2(3,1:pts);
% P_POT_2 = [P1_POT_2,P2_POT_2, P3_POT_2];
% y2 = P_POT_2;

for i = 1:S_POT
    P_POT_3(i,1:pts) = cheb_horner(AB_POT(i,1), AB_POT(i,2), n3, q_en, wordlength, var);
end

%%
% uncomment this for 2 segments
P1_POT_3 = P_POT_3(1,1:pts);
P2_POT_3 = P_POT_3(2,1:pts);
P_POT_3 = [P1_POT_3,P2_POT_3];
y3 = P_POT_3;

%%
% uncomment this section for 3 segments
% P1_POT_3 = P_POT_3(1,1:pts);
% P2_POT_3 = P_POT_3(2,1:pts);
% P3_POT_3 = P_POT_3(3,1:pts);
% P_POT_3 = [P1_POT_3,P2_POT_3, P3_POT_3];
% y3 = P_POT_3;

%%
% for one segment
% y1 = cheb_horner(a, b, n0, q_en, wordlength, var);
% y2 = cheb_horner(a, b, n1, q_en, wordlength, var);
% y3 = cheb_horner(a, b, n2, q_en, wordlength, var);
% y4 = cheb_horner(a, b, n3, q_en, wordlength, var);
% X = linspace(a,b, pts);
% T = tanh(X);

%%
% uncomment this section for 2 segments
x1 = linspace(0,2,pts);
x2 = linspace(2,4,pts);

X = [x1, x2];

t1 = tanh(x1);
t2 = tanh(x2);

T = [t1,t2];

%%
% uncomment this section for 3 segments
% x1 = linspace(0,1,pts);
% x2 = linspace(1,2,pts);
% x3 = linspace(2,4,pts);
% 
% X = [x1, x2, x3];
% 
% t1 = tanh(x1);
% t2 = tanh(x2);
% t3 = tanh(x3);
% 
% T = [t1,t2,t3];

%%
% plotting
x_tks = [0 1 2 3 4];
y_tks = [0 0.5 1 1.5];

width1 = 3;
width2 = 1.5;
fontSize = 14;

figure(1);
subplot(2,2,1)
hold on;
grid on;
plot(X, T, 'LineWidth', width1);
plot(X, y0,'LineWidth', width2);
set(gca, 'XTick', x_tks, 'FontSize', fontSize);
title('degree of polynomial = 0')
legend('tanh(x)','approximation','Location','southeast');
xlabel('x', 'FontSize', fontSize);
ylabel('y', 'FontSize', fontSize);

subplot(2,2,2)       % add second plot in 2 x 2 grid
hold on;
grid on;
plot(X, T, 'LineWidth', width1);
plot(X, y1,'LineWidth', width2);
set(gca, 'XTick', x_tks, 'FontSize', fontSize);
title('degree of polynomial = 1');
legend('tanh(x)','approximation','Location','southeast');
xlabel('x', 'FontSize', fontSize);
ylabel('y', 'FontSize', fontSize);

subplot(2,2,3)       % add third plot in 2 x 2 grid
hold on;
grid on;
plot(X, T, 'LineWidth', width1);
plot(X, y2,'LineWidth', width2);
set(gca, 'XTick', x_tks, 'FontSize', fontSize);
title('degree of polynomial = 2');
legend('tanh(x)','approximation','Location','southeast');
xlabel('x', 'FontSize', fontSize);
ylabel('y', 'FontSize', fontSize);

subplot(2,2,4)       % add fourth plot in 2 x 2 grid
hold on;
grid on;
plot(X, T, 'LineWidth', width1);
plot(X, y3,'LineWidth', width2);
set(gca, 'XTick', x_tks, 'FontSize', fontSize);
title('degree of polynomial = 3');
legend('tanh(x)','approximation','Location','southeast');
xlabel('x', 'FontSize', fontSize);
ylabel('y', 'FontSize', fontSize);

suptitle('Chebyshev polynomial approximations of hyperbolic tangent for 2 segments');