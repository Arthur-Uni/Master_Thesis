%cleanup
%clear;
clc;
%close all;

%%
%initialization parameters

%degree of polynomial
%n = 3;

%number of segments
S = 4;      % needs to be a power of two such that interval [a,b] can be
            % divided into integer powers of two
S_POT = log2(S)+1;

%number of points for linspace function
pts = 100;

%interval [a,b]: length must be a power of two so that the interval can be
%divided into powers of two
a = 0;
b = 4;

if(mod(b-a, 2) ~= 0 || S > b)
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

%%
%create matrices for intervals to the power of two in [a,b] and save boundaries of
%each segment in matrix AB
for i=1:S_POT
    AB_POT(i,1) = floor(S/(2^i));
    AB_POT(i,2) = S/(2^(i-1));
    Dots_POT(i,1:100) = linspace(AB_POT(i,1), AB_POT(i,2), pts);
end

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
max_degree = 3;                                 %max polynomial degree
min_degree = 1;                                 %min polynomial degree
degree_size = max_degree - min_degree +1;       %number of degree steps

Max_abs_error = zeros(1,degree_size);           %max absolute error for every degree 
Mean_squ_error = zeros(1,degree_size);          %mean square error for every degree
C = zeros(1,degree_size);                       %number of coefficients
N = zeros(1,degree_size);                       %memory utilization

% P = zeros(S,pts);                             %matrix storing polynomial approximation values
%                                               %calculated for each
%                                               %segment
                                                
P_POT = zeros(S_POT,pts);                       %matrix storing polynomial 
                                                %approximation values
                                                %calculated for each
                                                %segment

if(min_degree ~= 1)                             %index offset, if min_degree != 1
    temp = min_degree-1;
else
    temp = 0;
end

wordlength = 32;

%%
%sweep over degree of polynomial approximation and calculate
%maximum absolute error, mean square error over interval [a,b] and number
%of coefficients needed for polynomial of certain degree

for n=min_degree:max_degree
    for i=1:S_POT
        P_POT(i,1:pts) = cheb_horner(AB_POT(i,1), AB_POT(i,2), n, 0, 0, 0);
    end
    abs_error = max(abs(Y_POT(:)-P_POT(:)));
    Max_abs_error(n - temp) = abs_error;
    Mean_squ_error(n - temp) = immse(double(Y_POT), double(P_POT));
    C(n - temp) = (n+1)*S_POT;
    N(n - temp) = C(n - temp)*wordlength;
end

%%
%plots
figure(1);
subplot(2,1,1);
p1 = plot(N, Max_abs_error, 'g', 'linewidth', width);
xlabel('number of coefficients');
ylabel('max abs error');
legend(['N=' num2str(S)]);
hold on;
grid on;

subplot(2,1,2);
p2 = plot(N, Mean_squ_error, 'g', 'linewidth', width);
xlabel('number of coefficients');
ylabel('mean squared error');
legend(['N=' num2str(S)]);
hold on;
grid on;