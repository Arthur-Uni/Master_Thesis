clc;
clear;

r = -4 + (4+4)*rand(1,100);

r_sat = abs(r) > 4;

% segment [0,1]
s_1_logical = abs(r) <= 1;
s_1_tanh = tanh(s_1_logical .* abs(r));

% segment [1,2]
s_2_logical_1 = abs(r) > 1;
s_2_logical_2 = abs(r) <= 2;
s_2_logical = s_2_logical_1 .* s_2_logical_2;
s_2_tanh = tanh(s_2_logical .* abs(r));

% segment [2,4]
s_3_logical_1 = abs(r) > 2;
s_3_logical_2 = abs(r) <= 4;
s_3_logical = s_3_logical_1 .* s_3_logical_2;
s_3_tanh = tanh(s_3_logical .* abs(r));

tanh_activation = (r_sat + s_1_tanh + s_2_tanh + s_3_tanh) .* sign(r);

% chebyshev polynomial coeffcients for each segment
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

if(mod(b-a, 2) ~= 0)
    error('interval size is not a power of two');
end

%%
%initialization parameters

% degree of polynomial
n = 5;

interval_size = b-a;
max_step_size = interval_size / S;

%combine a and b in matrix AB
AB_POT = zeros(S_POT,2);
%%

%%
%create matrices for intervals to the power of two in [a,b] and save boundaries of
%each segment in matrix AB
for i=1:S_POT
    AB_POT(i,1) = floor(S/(2^i)) * max_step_size;
    AB_POT(i,2) = S/(2^(i-1)) * max_step_size;
end

%flip matrices upside down
AB_POT = flipud(AB_POT);

%%
s_1_temp = s_1_logical .* abs(r);
s_1_cheb = cheb_horner_v2(s_1_temp, AB_POT(1,1), AB_POT(1,2), n) .* s_1_logical;

s_2_temp = s_2_logical .* abs(r);
s_2_cheb = cheb_horner_v2(s_2_temp, AB_POT(2,1), AB_POT(2,2), n) .* s_2_logical;

s_3_temp = s_3_logical .* abs(r);
s_3_cheb = cheb_horner_v2(s_3_temp, AB_POT(3,1), AB_POT(3,2), n) .* s_3_logical;

%%
cheb_activation = (r_sat + s_1_cheb + s_2_cheb + s_3_cheb) .* sign(r);