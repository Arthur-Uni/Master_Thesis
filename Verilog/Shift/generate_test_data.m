wordlength = 10;
fractionlength = 6;

input_testvector = -5:0.25:5;
input_testvector = fi(input_testvector, true, wordlength, fractionlength);

output = tanh_shift(input_testvector, wordlength);

fileID = fopen('testvector.txt','w');

fprintf(fileID,'%s   %s      %s      %s      \r\n','input.bin','input', 'output.bin','output');

for i=1:size(input_testvector,2)
    fprintf(fileID, '%s    %f    %s    %f    \r\n', bin(input_testvector(i)), input_testvector(i) , bin(output(i)), output(i));
end

fclose(fileID);
    