%% parameters
% scaled tanh
% A = 1.7159;
% S = 2/3;

A = 1;
S = 1;

%% interval

a = 0;
b = 4;

input_wordlength = 6;
input_integerbits = 2;
input_fractionbits = input_wordlength - input_integerbits;

step_size = 2^-input_fractionbits;

number_of_entries = (b-a) / step_size;

output_wordlength = 8;
output_fractionlength = output_wordlength;

%% calculate LUT entries
x_data = a:step_size:((2^input_integerbits-1)+(1-2^-input_fractionbits));

y_data = A.* tanh( S.*x_data );

LUT_entries = fi(y_data, false, output_wordlength, output_fractionlength);

%% calculate flloating point tanh
dots = linspace(a,b,number_of_entries);
t = tanh(dots);

%% calaculate error
abs_error = abs(t-double(LUT_entries));
rel_error = abs_error ./ t;
max_abs_error = max(abs_error);