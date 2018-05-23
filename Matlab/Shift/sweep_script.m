%% cleanup
clear;
clc;
close all;

%% parameter
% set global fimath settings
globalfimath('OverflowAction','Saturate','RoundingMethod','Round');

% interval
a = -4;
b = 4;
dots = linspace(a,b,101);

%% asymptotic boundary for the error

% function to approximate
t = tanh(dots);

% approximation
y = tanh_PLA(dots);

% error calculation
abs_error = max(abs(t-y));
msq_error = immse(t,y);

% word sizes
width = 1.5;
fontSize = 16;

min_input = 8;
max_input = 10;

input_size = max_input - min_input + 1;

min_output = 4;
max_output = 8;

output_size = max_output - min_output + 1;

% error matrices
max_abs_error = zeros(input_size, output_size);
mean_squ_error = zeros(input_size, output_size);

% for pareto plot
bits = zeros(input_size, output_size);

if(min_input ~= 1)
    temp = min_input - 1;
else
    temp = 0;
end

%% perform sweep over all variables

for wordlength = min_input : max_input
    fractionlength = setup_fractionlength(wordlength);
    x = fi(dots, true, wordlength, fractionlength);
    i = 1;
    for outputlength = min_output : max_output
        y_fixed = tanh_shift(x, outputlength);
        % error calculation
        max_abs_error(wordlength - temp, i) = max(abs(t-double(y_fixed)));
        mean_squ_error(wordlength - temp, i) = immse(t, double(y_fixed));
        bits(wordlength - temp, i) = wordlength + outputlength;
        i = i + 1;
    end
end

%% plot
figure(1);

x_tick = min_output:max_output;
one = ones(1,size(x_tick,2));
subplot(2,1,1);
grid on;
hold on;
plot(x_tick, one.*abs_error, '--', 'LineWidth', 2*width);
plot(x_tick, max_abs_error', 'LineWidth', width);
xlabel('output bits');
ylabel('absolute error');
axis([min_output max_output 0 0.5]);
set(gca, 'XTick', x_tick, 'FontSize', fontSize);

Legend = cell(input_size+1,1);
Legend{1} = 'asymptotic bound';
for iter=2:input_size+1
    Legend{iter}=strcat('input bits: ', num2str(min_input+iter-2));
end
legend(Legend);

subplot(2,1,2);
grid on;
hold on;
plot(x_tick, one.*msq_error, '--', 'LineWidth', 2*width);
plot(x_tick, mean_squ_error', 'LineWidth', width);
xlabel('output bits');
ylabel('relative error');
axis([min_output max_output 0 max(mean_squ_error(:))]);
x_tick = min_output:max_output;
set(gca, 'XTick', x_tick, 'FontSize', fontSize);

Legend = cell(input_size+1,1);
Legend{1} = 'asymptotic bound';
for iter=2:input_size+1
    Legend{iter}=strcat('input bits: ', num2str(min_input+iter-2));
end
legend(Legend);