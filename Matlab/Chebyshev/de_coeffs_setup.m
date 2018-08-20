function [ coeffs_wordlength ] = de_coeffs_setup( S, n )

switch S
    case 1
        switch n
            case 1
                coeffs_wordlength = 16;
            case 2
                coeffs_wordlength = 16;
            case 3
                coeffs_wordlength = 16;
            case 4
                coeffs_wordlength = 16;
            case 5
                coeffs_wordlength = 16;
            case 6
                coeffs_wordlength = 16;
            case 7
                coeffs_wordlength = 16;
            case 8
                coeffs_wordlength = 17;
            case 9
                coeffs_wordlength = 20;
            case 10
                coeffs_wordlength = 22;
        end
    case 2
        switch n
            case 1
                coeffs_wordlength = 16;
            case 2
                coeffs_wordlength = 16;
            case 3
                coeffs_wordlength = 16;
            case 4
                coeffs_wordlength = 16;
            case 5
                coeffs_wordlength = 16;
            case 6
                coeffs_wordlength = 16;
            case 7
                coeffs_wordlength = 16;
            case 8
                coeffs_wordlength = 18;
            case 9
                coeffs_wordlength = 18;
            case 10
                coeffs_wordlength = 20;
        end
    case 4
        switch n
            case 1
                coeffs_wordlength = 16;
            case 2
                coeffs_wordlength = 16;
            case 3
                coeffs_wordlength = 16;
            case 4
                coeffs_wordlength = 16;
            case 5
                coeffs_wordlength = 16;
            case 6
                coeffs_wordlength = 16;
            case 7
                coeffs_wordlength = 17;
            case 8
                coeffs_wordlength = 18;
            case 9
                coeffs_wordlength = 17;
            case 10
                coeffs_wordlength = 17;
        end
end

end

