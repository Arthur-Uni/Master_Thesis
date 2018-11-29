function [ M, MSE, Coeffs ] = cheb_de_tanh_function( S )
%% parameters
%   input S, power of two, number of segments for Chebyshev interpolation
%   output M, vector, maximum absolute approximation error
%   output MSE, vector, mean squared approximation error
%   output C, number of coefficients
%%

%%
%initialization parameters

% set default interpreter
set(0,'defaulttextInterpreter','latex');

S_POT = log2(S)+1;

%number of points for linspace function
pts = 101;

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

%combine a and b in matrix AB
AB_POT = zeros(S_POT,2);

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
X = zeros(S_POT,pts);
for i=1:S_POT
    x = linspace(AB_POT(i,1), AB_POT(i,2),pts);
    Y_POT(i,1:pts) = 1-tanh(x).^2;
    X(i,1:pts) = x;
end

%%
%parameters
max_degree = 10;
min_degree = 1;
degree_size = max_degree - min_degree +1;       %number of degree steps

M = zeros(degree_size, 1);
MSE = zeros(degree_size, 1);
Coeffs = zeros(degree_size, 1);                 %number of coefficients
                                                
P_POT = zeros(S_POT,pts);                       %matrix storing polynomial 
                                                %approximation values
                                                %calculated for each
                                                %segment
                                                
if(min_degree ~= 1)
    temp = min_degree-1;
else
    temp = 0;
end

%%                                            
for n=min_degree:max_degree
   for k=1:S_POT
            P_POT(k,1:pts) = cheb_horner_v3(X(k,1:end), AB_POT(k,1), AB_POT(k,2), n);
   end
%%
   abs_error = max(abs(Y_POT(:)-P_POT(:)));
   M(n - temp) = abs_error;
   MSE(n - temp) = immse(double(Y_POT), double(P_POT));
   Coeffs(n - temp) = (n+1)*S_POT;
end

end

