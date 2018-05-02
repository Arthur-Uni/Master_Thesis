%%
% quantize final result, quantize intermediate result of horner scheme
% multiplication and addition, obtained coefficients are quantized and 
% inputs are quantized

%%
%cleanup
clear;
% clc;
close all;

%%
%initialization parameters

% set global fimath settings
globalfimath('OverflowAction','Saturate','RoundingMethod','Round')

%degree of polynomial
%n = 3;

%number of segments
S = 2;      % needs to be a power of two such that interval [a,b] can be
            % divided into integer powers of two
S_POT = log2(S)+1;

%number of points for linspace function
pts = 100;

%interval [a,b]: length must be a power of two so that the interval can be
%divided into powers of two
a = 0;
b = 4;

if(mod(b-a, 2) ~= 0)
    error('interval size is not a power of two');
end
%interval_size = (b-a)/S;

%%
% quantize final result, quantize intermediate result of horner scheme
% multiplication and addition, obtained coefficients are quantized and 
% inputs are quantized

%%
%initialization parameters

interval_size = b-a;
max_step_size = interval_size / S;

if(mod(b-a, 2) ~= 0)
    error('interval size is not a power of two');
end

%combine a and b in matrix AB
AB_POT = zeros(S_POT,2);

width = 1.5;

%%
%create matrices for intervals to the power of two in [a,b] and save boundaries of
%each segment in matrix AB
for i=1:S_POT
    AB_POT(i,1) = floor(S/(2^i)) * max_step_size;
    AB_POT(i,2) = S/(2^(i-1)) * max_step_size;
end

%flip matrices upside down
AB_POT = flipud(AB_POT);
AB_POT
%%
%function to approximate(tanh in this case)

Y_POT = zeros(S_POT,pts);
for i=1:S_POT
    x = linspace(AB_POT(i,1), AB_POT(i,2),pts);
    Y_POT(i,1:pts) = tanh(x);
end

%%
% uncomment this section for 2 segments if you want to see all
% approximations

% Y1_POT = Y_POT(1,1:pts-1);
% Y2_POT = Y_POT(2,1:pts);
% Y_POT = [Y1_POT,Y2_POT];
% 
% 
% hold on;
% figure(3);
% plot(linspace(a,b,S_POT*pts-1), Y_POT, 'LineWidth', width);

%%
% uncomment this section for 3 segments if you want to see all
% approximations
% Y1_POT = Y_POT(1,1:pts-1);
% Y2_POT = Y_POT(2,1:pts-1);
% Y3_POT = Y_POT(3,1:pts);
% Y_POT = [Y1_POT, Y2_POT, Y3_POT];

% hold on;
% figure(3);
% plot(linspace(a,b,S_POT*pts-2), Y_POT, 'LineWidth', width);


%%
%parameters
max_degree = 10;
min_degree = 1;
degree_size = max_degree - min_degree +1;       %number of degree steps

min_word = 4;
max_word = 32;
word_size = ((max_word-min_word)/2) + 1;        %number of word steps
step_size = 2;

max_abs_error = zeros(degree_size,word_size);
mean_squ_error = zeros(degree_size,word_size);
Coeffs = zeros(degree_size,word_size);          %number of coefficients
N = zeros(degree_size,word_size);               %memory utilization
C = zeros(degree_size,word_size);               %computational effort
                                                
P_POT = zeros(S_POT,pts);                           %matrix storing polynomial 
                                                %approximation values
                                                %calculated for each
                                                %segment
                                                
coeff_wordlength = 32;
coeff_fractionlength = coeff_wordlength - 11;

input_wordlength = 32;
input_fractionlength = input_wordlength - 1;
                                                
if(min_degree ~= 1)
    temp = min_degree-1;
else
    temp = 0;
end

%%                                            
for n=min_degree:max_degree
    i = 1;
    for temp_wordlength = min_word:step_size:max_word
        temp_fractionlength = temp_wordlength - 1;
        for k=1:S_POT
            P_POT(k,1:pts) = cheb_horner_quantized(S, AB_POT(k,1), AB_POT(k,2),...
                n, temp_wordlength, temp_fractionlength, coeff_wordlength, coeff_fractionlength,...
                input_wordlength, input_fractionlength);
        end
%%
% uncomment this for 2 segments
%         P1_POT = P_POT(1,1:pts-1);
%         P2_POT = P_POT(2,1:pts);
%         P_POT = [P1_POT,P2_POT];
%         
%         hold on;
%         figure(3)
%         approx = plot(linspace(a,b,S_POT*pts-1), P_POT);

%%
% uncomment this section for 3 segments
%         P1_POT = P_POT(1,1:pts-1);
%         P2_POT = P_POT(2,1:pts-1);
%         P3_POT = P_POT(3,1:pts);
%         P_POT = [P1_POT,P2_POT, P3_POT];

%         hold on;
%         figure(3)
%         approx = plot(linspace(a,b,S_POT*pts-2), P_POT);
%%        
        abs_error = max(abs(Y_POT(:)-P_POT(:)));
        max_abs_error(n - temp, i) = abs_error;
        mean_squ_error(n - temp, i) = immse(double(Y_POT), double(P_POT));
        Coeffs(n - temp, i) = (n+1)*S_POT;
        N(n - temp, i) = Coeffs(n - temp)*coeff_wordlength;
        C(n - temp, i) = 2*n*(temp_wordlength + coeff_wordlength + input_wordlength);
        i = i+1;
    end
end

M = max_abs_error;
%%
%plots

%2D
figure(1)

subplot(2,1,1);
p1 = plot(N, max_abs_error, 'LineWidth', width);
xlabel('# of memory bits');
ylabel('max abs error');
hold on;
grid on;

Legend = cell(word_size,1);
for iter=1:word_size
    Legend{iter}=strcat('number of bits: ', num2str(min_word+(2*iter-2)));
end
legend(Legend);

subplot(2,1,2);
p2 = plot(N, mean_squ_error, 'LineWidth', width);
xlabel('# of memory bits');
ylabel('mean squared error');
hold on;
grid on;

Legend = cell(word_size,1);
for iter=1:word_size
    Legend{iter}=strcat('number of bits: ', num2str(min_word+(2*iter-2)));
end
legend(Legend);

figure(2);
subplot(2,1,1);
p3 = plot(C, max_abs_error, 'LineWidth', width);
xlabel('computational effort');
ylabel('max abs error');
hold on;
grid on;

Legend = cell(word_size,1);
for iter=1:word_size
    Legend{iter}=strcat('number of bits: ', num2str(min_word+(2*iter-2)));
end
legend(Legend);

subplot(2,1,2);
p4 = plot(C, mean_squ_error, 'LineWidth', width);
xlabel('computational effort');
ylabel('mean squared error');
hold on;
grid on;

Legend = cell(word_size,1);
for iter=1:word_size
    Legend{iter}=strcat('number of bits: ', num2str(min_word+(2*iter-2)));
end
legend(Legend);

%%
% best_abs_error = zeros(degree_size,1);
% best_mse = zeros(degree_size,1);
% for i=1:degree_size
%     best_abs_error(i,1) = min(max_abs_error(i,1:end));
%     best_mse (i,1) = min(mean_squ_error(i,1:end));
% end

% for i=1:degree_size
%     figure(2);
%     subplot(2,1,1);
%     plot(N(i,1:word_size), max_abs_error(i,1:word_size), 'linewidth', width);
%     xlabel('# of memory bits');
%     ylabel('max abs error');
%     hold on;
%     grid on;
%     grid minor;
% 
%     subplot(2,1,2);
%     plot(N(i,1:word_size), mean_squ_error(i,1:word_size), 'linewidth', width);
%     xlabel('# of memory bits');
%     ylabel('mean squared error');
%     hold on;
%     grid on
%     grid minor; 
% end

% 3D

% figure(1)
% s = surf(N,min_degree:max_degree, max_abs_error, log(max_abs_error));
% xlabel('memory utilization in number of bits');
% ylabel('computational effort in degree of polynomial');
% zlabel('max absolute error');

%%
% pareto optimization
% M = max_abs_error;
% 
% P = cheb_pareto(M, N, C);
% 
% Ones = P>0;
% 
% M_pareto = Ones .* M;
% N_pareto = Ones .* N;
% C_pareto = Ones .* C;
% 
% M_pareto(M_pareto==0) = [];
% N_pareto(N_pareto==0) = [];
% C_pareto(C_pareto==0) = [];
% 
% figure(2)
% s_pareto = scatter(C_pareto, N_pareto, 75, '*', 'LineWidth', 2.5);
% 
% figure(3)
% s = scatter(C(:), N(:), 75, '*', 'r', 'LineWidth', 2.5);