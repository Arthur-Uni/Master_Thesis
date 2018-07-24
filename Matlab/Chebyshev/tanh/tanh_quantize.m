clc;
clear;
close all;

% set global fimath settings
globalfimath('OverflowAction','Saturate','RoundingMethod','Round')

x1 = linspace(0,2);
x2 = linspace(0,2);

t1 = tanh(x1);
t2 = tanh(x2);

x = [x1, x2];

t = [t1, t2];

min_word = 4;
max_word = 32;

% size = max_word - min_word + 1;
size = ((max_word-min_word)/2) + 1;
step_size = 2;

max_abs_error_Y = zeros(size, 1);
max_abs_error_LSB = zeros(size, 1);
mse = zeros(size,1);

i= 1;

for w = min_word:step_size:max_word
    y = t;
    lsb = t;
    t = fi(t, true, 32, 32-1);
    y = fi(y, true, w, w-1);
    lsb = fi(lsb, true, w+1,w);
    abs_error = max((abs(t-y)));
    lsb_abs_error = max(abs(t-lsb));
    max_abs_error_Y(i, 1) = abs_error;
    max_abs_error_LSB(i,1) = lsb_abs_error;
    mse(i, 1) = immse(double(y), double(t));
    i = i+1;
end