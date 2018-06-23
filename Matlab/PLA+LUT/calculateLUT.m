function [ y ] = calculateLUT(x, LUT, LUT_EvaluationPoints, LUT_StepSize, offset)
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
temp = values - offset;
temp(temp < 0) = 0;
indices = round(temp ./ LUT_StepSize);
%indices(indices == 0) = 1;
indices = indices + 1;
indices(indices > numel(LUT)) = numel(LUT);
values = LUT(indices);
values(abs(x) < min(LUT_EvaluationPoints)) = LUT_lowerbound;
values(abs(x) > max(LUT_EvaluationPoints)) = LUT_upperbound;

y = values .* sign(x);

end

