function [ y ] = cheb_quantize( x, mode, wordlength, var)
%PARAMETERS:
%   x, vector, input
%   mode, String, quantization mode ('float', 'fixed' ...)
%   roundmode, String, round mode ('floor', 'ceil', ...)
%   wordlength, int, input
%   var, int, input
%   y, vector, output, quantized output of input x

    switch mode
        case 1  %fixed point: var is # of fractional bits in this case
     	  q_fi = quantizer('mode', 'fixed', 'roundmode', 'Round', 'overflowmode', 'saturate', 'format', [wordlength var]);
        y = quantize(q_fi, x);
     case 2  %floating point: var is length of exponent in this case
           q_fl = quantizer('mode', 'float', 'roundmode', 'ceil', 'format', [wordlength var]);
            y = quantize(q_fl, x);
        otherwise
            y = x;
    end

end

