clc;
%clear;
close all;

x = linspace(0,4);

t = tanh(x);
temp = t;

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

interval_size = b-a;
max_step_size = interval_size / S;

if(mod(b-a, 2) ~= 0)
    error('interval size is not a power of two');
end

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

min_word = 2;
max_word = 32;

size = max_word - min_word + 1;

max_abs_error_5= zeros(size, 1);
% rel_error = zeros(size, 1);
mse_5 = zeros(size,1);
n = 5;

i= 1;

for w = min_word:max_word
    y = cheb_horner(a,b,n,1,w,w-1);
    t = fi(t, true, 32, 32-1);
    % error = t - temp;
    % y = fi(y, true, w, w-1);
    mean_abs_error = mean((abs(t-y)));
    max_abs_error_5(i, 1) = mean_abs_error;
    rel_error = (abs(double(y)-double(t)))./double(t);
    mse_5(i, 1) = immse(double(y), double(t));
    i = i+1;
end