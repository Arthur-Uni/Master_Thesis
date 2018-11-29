function [ horner_fractionlength ] = de_horner_setup( S, n, horner_wordlength )

switch S
    case 1
        switch n
            case 1
                horner_fractionlength = horner_wordlength;
            case 2
                horner_fractionlength = horner_wordlength - 2;
            case 3
                horner_fractionlength = horner_wordlength - 3;
            case 4
                horner_fractionlength = horner_wordlength - 3;
            case 5
                horner_fractionlength = horner_wordlength - 6;
            case 6
                horner_fractionlength = horner_wordlength - 8;
            case 7
                horner_fractionlength = horner_wordlength - 8;
            case 8
                horner_fractionlength = horner_wordlength - 9;
            case 9
                horner_fractionlength = horner_wordlength - 11;
            case 10
                horner_fractionlength = horner_wordlength - 13;
        end
    case 2
        switch n
            case 1
                horner_fractionlength = horner_wordlength - 1;
            case 2
                horner_fractionlength = horner_wordlength - 1;
            case 3
                horner_fractionlength = horner_wordlength - 1;
            case 4
                horner_fractionlength = horner_wordlength - 3;
            case 5
                horner_fractionlength = horner_wordlength - 4;
            case 6
                horner_fractionlength = horner_wordlength - 3;
            case 7
                horner_fractionlength = horner_wordlength - 6;
            case 8
                horner_fractionlength = horner_wordlength - 6;
            case 9
                horner_fractionlength = horner_wordlength - 5;
            case 10
                horner_fractionlength = horner_wordlength - 8;
        end
    case 4
        horner_fractionlength = horner_wordlength - 1;
end

end



