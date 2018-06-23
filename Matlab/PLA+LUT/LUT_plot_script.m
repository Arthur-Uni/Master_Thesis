%% cleanup
clear;
close all;
clc;

%% inputs
a = 0;
b = 4;
x_start = 0;
y_start = 0;
NoE = 4;
signed = 0;
wordlength = 8;
fractionlength = 8;
hybrid_en = 0;
intermediate_en = 0;
offset = 0;
x = linspace(-4,4, 16001);

%% create LUT
[LUT, LUT_EvaluationPoints, LUT_StepSize] = createLUT(a, b, x_start, y_start, NoE, signed, wordlength, fractionlength, hybrid_en, intermediate_en);

%% calculate outputs
y = calculateLUT(x, LUT, LUT_EvaluationPoints, LUT_StepSize, offset);