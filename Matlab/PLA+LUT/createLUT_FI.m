function [LUT, LUT_EvaluationPoints, LUT_StepSize] = createLUT_FI(a, b, x_start, y_start, NoE, signed, wordlength, fractionlength, hybrid_en, intermediate_en)
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
if(intermediate_en)
    LUTy(1) = tanh(LUTx(1) + 0.5 *LUT_StepSize);
else
    LUTy(1) = y_start;
end
for i=2:NoE
    LUTx(i) = x_start + (i-1) * LUT_StepSize;
    if(hybrid_en)
        LUTy(i) = tanh(LUTx(i) + 0.5 * LUT_StepSize);
    else
        LUTy(i) = tanh(LUTx(i));
    end
end

EntriesFi = fi(LUTy, signed, wordlength, fractionlength);
LUT_EvaluationPoints = LUTx;
LUT = EntriesFi;

end

