function [ beta ] = regression_betas( x, y )

%% polynomial regression

% calculate quadratic regression
X = [ones(size(x,1),1), x, x.^2];

% obtain coefficients for: y = ax^2 + bx + c; beta = (X'X)^-1*X'*y
beta = (X'*X)^-1 * X' *y;

end

