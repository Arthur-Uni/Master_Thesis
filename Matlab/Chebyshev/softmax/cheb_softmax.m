%% cleanup
clear;
clc;

%% parameters

% interval boundaries
a = 0;
b = 4;

% test values
x = a:0.01:b;

% degree of polynomial
n = 5;

% function to approximate as function handle
f = @cnnSoftmax;

%% Chebyshev coefficients
[c, ma, mi] = cheb_coeffs(a, b, n, f);

%% calculate function value via horner scheme
y = horner_scheme(x, a, b, c);