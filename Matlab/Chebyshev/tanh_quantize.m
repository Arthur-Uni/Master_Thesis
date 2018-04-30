clc;
clear;
close all;

x = linspace(0,4);

t = tanh(x);
temp = t;

min_word = 2;
max_word = 32;

size = max_word - min_word + 1;

mean_abs_error_Y = zeros(size, 1);
mse = zeros(size,1);

i= 1;

for w = min_word:max_word
    y = t;
    t = fi(t, true, 32, 32-1);
    error = t - temp;
    y = fi(y, true, w, w-1);
    mean_abs_error = mean((abs(t-y)));
    mean_abs_error_Y(i, 1) = mean_abs_error;
    mse(i, 1) = immse(double(y), double(t));
    i = i+1;
end