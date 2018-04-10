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

y = zeros(S,pts);
for i=1:S
    x = linspace(AB(i,1), AB(i,2),pts);
    y(i,1:pts) = tanh(x);
end

%%
%parameters
max_degree = 10;                                %max polynomial degree
min_degree = 1;                                 %min polynomial degree
degree_size = max_degree - min_degree +1;       %number of degree steps

Max_abs_error = zeros(1,degree_size);           %max absolute error for every degree 
Mean_squ_error = zeros(1,degree_size);          %mean square error for every degree
C = zeros(1,degree_size);                       %number of coefficients

P = zeros(S,pts);                               %matrix storing polynomial approximation values
                                                %calculated for each
                                                %segment

%%
%sweep over degree of polynomial approximation and calculate
%maximum absolute error, mean square error over interval [a,b] and number
%of coefficients needed for polynomial of certain degree

for n=min_degree:max_degree
    for i=1:S
        P(i,1:pts) = cheb_horner(AB(i,1), AB(i,2), n, 0, 0, 0, 0);
    end
    abs_error = max(abs(y(:)-P(:)));
    Max_abs_error(n) = abs_error;
    Mean_squ_error(n) = immse(double(y), double(P));
    C(n) = (n+1)*S;
end

%%
%plots
figure(1);
subplot(2,1,1);
plot(C, Max_abs_error, 'linewidth', width);
xlabel('number of coefficients');
ylabel('max abs error');
legend('N = 8');
hold on;
grid on;

subplot(2,1,2);
plot(C, Mean_squ_error, 'linewidth', width);
xlabel('number of coefficients');
ylabel('mean squared error');
legend(['N=' num2str(S)]);
hold on;
grid on;