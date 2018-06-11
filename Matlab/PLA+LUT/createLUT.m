function [LUT, LUT_EvaluationPoints, LUT_StepSize] = createLUT(a, b, NoE, signed, wordlength, fractionlength)
%% parameters
%   Inputs
%       a: left interval boundary
%       b: right interval boundary
%       NoE: number of LUT entries
%       signed: signed fixed point or unsigned (1 or 0)
%       wordlength: total number of bits for LUT entries
%       fractionlength: number of fractional bits
%   Outputs
%       LUT: LUT entries
%%

LUT_StepSize = (b - a) / NoE;

LUT_EvaluationPoints = a + LUT_StepSize: LUT_StepSize : b;
EntriesAcc = tanh(LUT_EvaluationPoints);
EntriesFi = fi(EntriesAcc, signed, wordlength, fractionlength);

LUT = double(EntriesFi);

end