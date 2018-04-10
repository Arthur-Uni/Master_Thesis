%cleanup
%clear;
%clc;
%close all;

%%
%initialization parameters

%degree of polynomial
%n = 3;

%number of segments
S = 4;

%number of points for linspace function
pts = 100;

%interval [a,b]
a = 0;
b = 8;
interval_size = (b-a)/S;

%combine a and b in matrix AB
AB = zeros(S,2);

%plotting points in interval [a,b]
Dots = zeros(S,pts);

%plotting parameters
width = 1;

%%
%create matrices for equidistant intervals in [a,b] and save boundaries of
%each segment in matrix AB
for i=1:S
    Dots(i,1:pts) = linspace((i-abs(a)-1) * interval_size, (i-abs(a)) * interval_size, pts);
    AB(i,1) = (i-abs(a)-1) * interval_size;
    AB(i,2) = (i-abs(a)) * interval_size;
end

%%
%function to approximate(tanh in this case)

Y = zeros(S,pts);
for i=1:S
    x = linspace(AB(i,1), AB(i,2),pts);
    Y(i,1:pts) = tanh(x);
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

P = zeros(S,pts);                               %matrix storing polynomial approximation values
                                                %calculated for each
                                                %segment

for n=min_degree:max_degree
    for wordlength = min_word:step_size:max_word
        i = 0.5*wordlength - 1;
        var = wordlength - 2;
        for k=1:S
            P(k,1:pts) = cheb_horner(AB(k,1), AB(k,2), n, 1, mode, wordlength, var);
        end
        abs_error = max(abs(Y(:)-P(:)));
        max_abs_error(n, i) = abs_error;
        mean_squ_error(n, i) = immse(double(Y), double(P));
        C(n, i) = (n+1)*S;
        N(n, i) = C(n)*wordlength;
        i = i+1;
    end
end

% best_abs_error = zeros(degree_size,1);
% best_mse = zeros(degree_size,1);
% for i=1:degree_size
%     best_abs_error(i,1) = min(max_abs_error(i,1:end));
%     best_mse (i,1) = min(mean_squ_error(i,1:end));
% end
% 
% for i=1:max_degree
%     figure(1);
%     subplot(2,1,1);
%     plot(N(i,1:degree_size), max_abs_error(i,1:degree_size), 'linewidth', width);
%     xlabel('# of memory bits');
%     ylabel('max abs error');
%     hold on;
%     grid on;
%     grid minor;
% 
%     subplot(2,1,2);
%     plot(N(i,1:degree_size), mean_squ_error(i,1:degree_size), 'linewidth', width);
%     xlabel('# of memory bits');
%     ylabel('mean squared error');
%     hold on;
%     grid on
%     grid minor; 
% end
% 
% figure(2)
% 
% subplot(2,1,1);
% plot(N, max_abs_error, 'linewidth', width);
% xlabel('# of memory bits');
% ylabel('max abs error');
% hold on;
% grid on;
% grid minor;
% 
% subplot(2,1,2);
% plot(N, mean_squ_error, 'linewidth', width);
% xlabel('# of memory bits');
% ylabel('mean squared error');
% hold on;
% grid on
% grid minor;

%plot
figure(1)
s = surf(N,min_degree:max_degree, max_abs_error, log(max_abs_error));
xlabel('memory utilization in number of bits');
ylabel('computational effort in degree of polynomial');
zlabel('max absolute error');