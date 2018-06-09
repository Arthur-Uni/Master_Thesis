function [ y ] = calculateLUT(x, LUT, LUT_EvaluationPoints, LUT_stepsize, offset)
%% parameter
%   Inputs:
%       x: inputs
%       LUT: Lookup table entries
%       LUT_EvaluationPoints: function evaluation points for LUT
%       LUT_stepsize: LUT resolution
%       offset: offset of input values to zero
%   Outputs:
%       y: output values given by Lookup table for inputs x
%%

LUT_lowerbound = min(LUT);
LUT_upperbound = max(LUT);

values = abs(x);
indices = round((values - offset) ./ LUT_stepsize);
indices(indices == 0) = 1;

values = LUT(indices);
values(values < min(LUT_EvaluationPoints)) = LUT_lowerbound;
values(values > max(LUT_EvaluationPoints)) = LUT_upperbound;

y = values .* sign(x);

end

