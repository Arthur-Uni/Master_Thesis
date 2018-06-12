function [LUT, LUT_EvaluationPoints, LUT_StepSize] = createLUT(a, b, x_start, y_start, NoE, signed, wordlength, fractionlength)
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

% LUT_EvaluationPoints = a: LUT_StepSize : b - LUT_StepSize;
LUTx(1) = x_start;
LUTy(1) = y_start;

for i=2:NoE
    LUTx(i) = x_start + (i-1) * LUT_StepSize;
    LUTy(i) = tanh(LUTx(i));
end

EntriesFi = fi(LUTy, signed, wordlength, fractionlength);
LUT_EvaluationPoints = LUTx;
LUT = double(EntriesFi);

end