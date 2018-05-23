function [ fractionlength ] = setup_fractionlength( wordlength )

switch(wordlength)
    case 1
        fractionlength = 0;
    case 2
        fractionlength = 0;
    case 3
        fractionlength = 0;
    otherwise
        fractionlength = wordlength - 3;
end

end

