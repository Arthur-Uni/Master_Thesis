%% cleanup
clear;
clc;
close all;

% set global fimath settings
globalfimath('OverflowAction','Saturate','RoundingMethod','Round');

%% interval 1
a_1 = 0.5;
b_1 = 1;

interval_1 = b_1 - a_1;

NumberOfEntries_1 = 4;

stepsize_1 = (b_1 - a_1) / NumberOfEntries_1;

EvaluationPoints_1 = (a_1 + stepsize_1):stepsize_1:b_1;
EntriesAcc_1 = tanh(EvaluationPoints_1);
EntriesFi_1 = fi(EntriesAcc_1, false, 8,8);

%% error calculation
abs_error_1 = abs(EntriesAcc_1 - double(EntriesFi_1));
rel_error_1 = abs_error_1 ./ EntriesAcc_1;

%% interval 2
a_2 = 1;
b_2 = 3;

interval_2 = b_2 - a_2;

NumberOfEntries_2 = 64;

stepsize_2 = (b_2 - a_2) / NumberOfEntries_2;

EvaluationPoints_2 = (a_2 + stepsize_2):stepsize_2:b_2;
EntriesAcc_2 = tanh(EvaluationPoints_2);
EntriesFi_2 = fi(EntriesAcc_2, false, 8,8);

%% error calculation
abs_error_2 = abs(EntriesAcc_2 - double(EntriesFi_2));
rel_error_2 = abs_error_2 ./ EntriesAcc_2;

%% interval 3
a_3 = 3;
b_3 = 4;

interval_3 = b_3 - a_3;

NumberOfEntries_3 = 2;

stepsize_3 = (b_3 - a_3) / NumberOfEntries_3;

EvaluationPoints_3 = (a_3 + stepsize_3):stepsize_3:b_3;
EntriesAcc_3 = tanh(EvaluationPoints_3);
EntriesFi_3 = fi(EntriesAcc_3, false, 8,8);

%% error calculation
abs_error_3 = abs(EntriesAcc_3 - double(EntriesFi_3));
rel_error_3 = abs_error_3 ./ EntriesAcc_3;

%% complete LUT
LUT = [EntriesFi_1 EntriesFi_2 EntriesFi_3];

%% inputs
x_PLA = linspace(0,0.5,101);
x_LUT = 0.5 + 2^-5:2^-5:4;

%% outputs
y_PLA = zeros(size(x_PLA));
y_LUT = zeros(size(x_LUT));

%% output calculations
% 1st interval
NumberOfSteps_1 = interval_1 / 2^-5;
x_LUT_1 = a_1 + 2^-5:2^-5:b_1;

for i=1:numel(x_LUT_1)
    if(x_LUT(i) <= 0.625)
        y_LUT(i) = LUT(1);
    elseif (x_LUT(i) <= 0.75)
        y_LUT(i) = LUT(2);
    elseif (x_LUT(i) <= 0.875)
        y_LUT(i) = LUT(3);
    elseif (x_LUT(i) <= 1)
        y_LUT(i) = LUT(4);
    end
end

% 2nd interval
input_offset_1 = interval_1 / 2^-5;
LUT_offset_1 = NumberOfEntries_1;

x_frac = x_LUT(input_offset_1+1:input_offset_1+NumberOfEntries_2) - fix(x_LUT(input_offset_1+1:input_offset_1+NumberOfEntries_2));
indices = 1:NumberOfEntries_2;
y_LUT(input_offset_1+1:input_offset_1+NumberOfEntries_2) = LUT(LUT_offset_1+indices);

% 3rd interval
NumberOfSteps_3 = interval_3 / 2^-5;
x_LUT_3 = a_3 + 2^-5:2^-5:b_3;

input_offset_3 = input_offset_1 + interval_2 / 2^-5;
LUT_offset_3 = LUT_offset_1 + NumberOfEntries_2;

for i=1:numel(x_LUT_3)
    if(x_LUT(i+input_offset_3) <= 3.5)
        y_LUT(i+input_offset_3) = LUT(LUT_offset_3 + 1);
    elseif (x_LUT(i+input_offset_3) <= 4)
        y_LUT(i+input_offset_3) = LUT(LUT_offset_3 + 2);
    end
end

%% bring everything together
y_PLA = x_PLA;
x = [x_PLA x_LUT];
y = [y_PLA y_LUT];
