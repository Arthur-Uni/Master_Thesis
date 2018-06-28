%% clean
clear;
close all;
clc;

input_wordlength = 8;
input_fractionlength = 5;

x = 0.5+2^-input_fractionlength:2^-input_fractionlength:2.5;
x = fi(x, false, input_wordlength, input_fractionlength);

%% parameter
a = 0.5;
b = 2.5;

NoE = 64;

signed = 0;
wordlength = 8;
fractionlength = 8;
x_start = 0.5;
y_start = 0.5;
offset = x_start;

[ LUT, LUT_EvaluationPoints, LUT_StepSize ] = createLUT_FI(a, b, x_start, y_start, NoE, signed, wordlength, fractionlength, 1, 0);

fileID = fopen('LUT_test.txt','w');

fprintf(fileID,'%s      %s      \r\n','input.bin', 'LUT.bin');

for i=1:size(x,2)
    temp = bin(x(i));
    fprintf(fileID, '7''b%s : abs_out[7:0] = 8''b%s;  \r\n', temp(2:end), bin(LUT(i)));
end

fclose(fileID);