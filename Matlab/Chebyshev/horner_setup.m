function [ horner_intermediate ] = horner_setup( S, n, horner_wordlength )

switch S
    case 1
        switch n
            case 1
                horner_intermediate = horner_wordlength - 2;
            case 2
                horner_intermediate = horner_wordlength - 3;
            case 3
                horner_intermediate = horner_wordlength - 4;
            case 4
                horner_intermediate = horner_wordlength - 5;
            case 5
                horner_intermediate = horner_wordlength - 5;
            case 6
                horner_intermediate = horner_wordlength - 7;
            case 7
                horner_intermediate = horner_wordlength - 8;
            case 8
                horner_intermediate = horner_wordlength - 9;
            case 9
                horner_intermediate = horner_wordlength - 9;
            case 10
                horner_intermediate = horner_wordlength - 11;
        end
    case 2
        switch n
            case 1
                horner_intermediate = horner_wordlength - 2;
            case 2
                horner_intermediate = horner_wordlength - 3;
            case 3
                horner_intermediate = horner_wordlength - 3;
            case 4
                horner_intermediate = horner_wordlength - 3;
            case 5
                horner_intermediate = horner_wordlength - 3;
            case 6
                horner_intermediate = horner_wordlength - 4;
            case 7
                horner_intermediate = horner_wordlength - 4;
            case 8
                horner_intermediate = horner_wordlength - 5;
            case 9
                horner_intermediate = horner_wordlength - 5;
            case 10
                horner_intermediate = horner_wordlength - 5;
        end
    case 3
        if(n == 1)
          horner_intermediate = horner_wordlength - 2;
        else
          horner_intermediate = horner_wordlength - 2;
        end
end

end



