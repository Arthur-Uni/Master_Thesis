%cleanup
%clear;
clc;
%close all;

%%
%initialization parameters

%degree of polynomial
%n = 3;

%number of segments
S = 4;      %needs to be a power of two
S_POT = log2(4)+1;

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

%combine a and b in matrix AB
%AB = zeros(S,2);
AB_POT = zeros(S_POT,2);

%plotting points in interval [a,b]
%Dots = zeros(S,pts);
Dots_POT = zeros(S_POT,pts);

%plotting parameters
width = 1;

%%
%create matrices for equidistant intervals in [a,b] and save boundaries of
%each segment in matrix AB
% for i=1:S
%     Dots(i,1:pts) = linspace((i-abs(a)-1) * interval_size, (i-abs(a)) * interval_size, pts);
%     AB(i,1) = (i-abs(a)-1) * interval_size;
%     AB(i,2) = (i-abs(a)) * interval_size;
% end

%create matrices for intervals to the power of two in [a,b] and save boundaries of
%each segment in matrix AB
for i=1:S_POT
    AB_POT(i,1) = floor(S/(2^i));
    AB_POT(i,2) = S/(2^(i-1));
    Dots_POT(i,1:100) = linspace(AB_POT(i,1), AB_POT(i,2), pts);
end

%flip matrices upside down
AB_POT = flipud(AB_POT);
Dots_POT = flipud(Dots_POT);

%%
%function to approximate(tanh in this case)

% Y = zeros(S,pts);
% for i=1:S
%     x = linspace(AB(i,1), AB(i,2),pts);
%     Y(i,1:pts) = tanh(x);
% end

Y_POT = zeros(S_POT,pts);
for i=1:S_POT
    x = linspace(AB_POT(i,1), AB_POT(i,2),pts);
    Y_POT(i,1:pts) = tanh(x);
end

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
C = zeros(degree_size,word_size);                                    %number of coefficients
N = zeros(degree_size,word_size);                                    %memory utilization

mode = 1;

% P = zeros(S,pts);                             %matrix storing polynomial 
                                                %approximation values
                                                %calculated for each
                                                %segment
                                                
P_POT = zeros(S_POT,pts);                       %matrix storing polynomial 
                                                %approximation values
                                                %calculated for each
                                                %segment
                                                
q_en = 1;

if(min_degree ~= 1)
    temp = min_degree-1;
else
    temp = 0;
end
%%                                            
for n=min_degree:max_degree
    i = 1;
    for wordlength = min_word:step_size:max_word
        var = wordlength-2;
        for k=1:S_POT
            %P(k,1:pts) = cheb_horner(AB(k,1), AB(k,2), n, q_en, mode, wordlength, var);
            P_POT(k,1:pts) = cheb_horner(AB_POT(k,1), AB_POT(k,2), n, q_en, mode, wordlength, var);
        end
        abs_error = max(abs(Y_POT(:)-P_POT(:)));
        max_abs_error(n - temp, i) = abs_error;
        mean_squ_error(n - temp, i) = immse(double(Y_POT), double(P_POT));
        C(n - temp, i) = (n+1)*S_POT;
        N(n - temp, i) = C(n - temp)*wordlength;
        i = i+1;
    end
end

figure(1)

subplot(2,1,1);
plot(N, max_abs_error, 'linewidth', width);
xlabel('# of memory bits');
ylabel('max abs error');
hold on;
grid on;

Legend = cell(word_size,1);
for iter=1:word_size
    Legend{iter}=strcat('number of bits: ', num2str(min_word+(2*iter-2)));
end
legend(Legend)

subplot(2,1,2);
plot(N, mean_squ_error, 'linewidth', width);
xlabel('# of memory bits');
ylabel('mean squared error');
hold on;
grid on

Legend = cell(word_size,1);
for iter=1:word_size
    Legend{iter}=strcat('number of bits: ', num2str(min_word+(2*iter-2)));
end
legend(Legend)

best_abs_error = zeros(degree_size,1);
best_mse = zeros(degree_size,1);
for i=1:degree_size
    best_abs_error(i,1) = min(max_abs_error(i,1:end));
    best_mse (i,1) = min(mean_squ_error(i,1:end));
end

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

%plot
% figure(1)
% s = surf(N,min_degree:max_degree, max_abs_error, log(max_abs_error));
% xlabel('memory utilization in number of bits');
% ylabel('computational effort in degree of polynomial');
% zlabel('max absolute error');