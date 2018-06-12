function [ y ] = calculateLUTPLA( x, LUT, LUT_StepSize, linEnable, linBorder, a, b, offset)

%% parameter
y_lin = zeros(size(x));

%% linear region
if(linEnable)
    x_lin = abs(x) < linBorder;
    y_lin = abs(x) .* x_lin;
end

%% LUT region
temp1 = abs(x) >= a;
% temp2 = x < (b - (LUT_StepSize * 0.5));
temp2 = abs(x) <= b;
x_LUT = temp1 .* temp2;
indices = abs(x) - offset;
indices = floor(indices ./ LUT_StepSize) .* x_LUT;
indices = indices + 1;
indices(indices > numel(LUT)) = numel(LUT);
y_LUT = LUT(indices) .* x_LUT;

% %% trans region
% temp1 = x >= (b - (LUT_StepSize * 0.5));
% temp2 = x <= b;
% x_trans = temp1 .* temp2;
% y_trans = tanh(b - (LUT_StepSize * 0.5)) .* x_trans;

%% saturation region
x_sat = abs(x) > b;
y_sat = ones(size(x)) .* x_sat;

%% bring everything together
% y = (y_lin + y_LUT + y_trans + y_sat) .* sign(x);
y = (y_lin + y_LUT + y_sat) .* sign(x);

end

