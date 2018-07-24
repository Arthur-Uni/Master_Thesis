clear;
clc;

n = 5;
S = 4;

x = linspace(0,4,303);
t = tanh(x);
x1 = linspace(0,1,101);
x2 = linspace(1,2,101);
x3 = linspace(2,4,101);

c1 = cheb_poly_coeffs(0,1,n);
c2 = cheb_poly_coeffs(1,2,n);
c3 = cheb_poly_coeffs(2,4,n);

cq1 = cheb_poly_coeffs_quantized(0,1,n,16,15);
cq2 = cheb_poly_coeffs_quantized(1,2,n,16,15);
cq3 = cheb_poly_coeffs_quantized(2,4,n,16,15);

%% segment 1
t1 = abs(x) <= 1;
t1_x = t1 .* abs(x);

yt1 = cheb_horner_v3(t1_x, 0,1,c1) .* t1;
yt1_q = cheb_horner_v3(t1_x, 0,1,cq1) .* t1;
k1 = cheb_horner_quantized_v2(t1_x, S, 0, 1, n, cq1, 16, 10, 9).*t1;
%% segment 2
t1 = abs(x) > 1;
t2 = abs(x) <= 2;
t1 = t1.*t2;
t1_x = t1 .* abs(x);

yt2 = cheb_horner_v3(t1_x, 1,2,c2) .* t1;
yt2_q = cheb_horner_v3(t1_x, 1,2,cq2) .* t1;
k2 = cheb_horner_quantized_v2(t1_x, S, 1, 2, n, cq2, 16, 10, 9).*t1;
%% segment 3
t1 = abs(x) > 2;
t2 = abs(x) <= 4;
t1 = t1.*t2;
t1_x = t1 .* abs(x);

yt3 = cheb_horner_v3(t1_x, 2,4,c3) .* t1;
yt3_q = cheb_horner_v3(t1_x, 2,4,cq3) .* t1;
k3 = cheb_horner_quantized_v2(t1_x, S, 2, 4, n, cq3, 16, 10, 9).*t1;

%% saturation
t1 = abs(x) > 4;
y_sat = ones(size(x)).*t1;

%% put everything together
temp = (yt1 + yt2 + yt3 + y_sat) .* sign(x);
tempq = (yt1_q + yt2_q + yt3_q + y_sat) .* sign(x);
tempk = (k1 + k2 + k3 + y_sat) .*sign(x);
%% reshape
x_size = size(x);
y = reshape(temp, x_size);
yq = reshape(tempq, x_size);
k = reshape(tempk, x_size);
%% error
abs_error = abs(t-y);
max_abs_error = max(abs_error);
mse = immse(t,y);
rel_error = abs_error./t;

abs_errorq = abs(t-yq);
max_abs_errorq = max(abs_errorq);
mseq = immse(t,yq);
rel_errorq = abs_errorq./t;

abs_errork = abs(t-k);
max_abs_errork = max(abs_errork);
msek = immse(t,k);
rel_errork = abs_errork./t;