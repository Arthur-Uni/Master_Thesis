%% cleanup
clear;
clc;
close all;

%% using Matlab LUT toolbox
problem1 = FunctionApproximation.Problem('tanh');

problem1.InputLowerBounds = 0.5;
problem1.InputUpperBounds = 2.5;

problem1.Options.WordLengths = [4 8 16];

problem1.Options.RelTol = 0.005;
problem1.Options.AbsTol = 0.02;
problem1.Options.BreakpointSpecification = 'EvenSpacing';

problem1.InputTypes = numerictype(0,8,6);
problem1.OutputType = numerictype(0,8,7);

%% solve optimization problem
solution = solve(problem1);
data = compare(solution);

%% get LUT entries
LUT = solution.TableData;
LUT_data = fi(LUT.TableValues, false, 8,8);