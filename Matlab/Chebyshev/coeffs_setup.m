function [ coeffs_fract ] = coeffs_setup( S, n, coeffs_wordlength )

switch S
    case 1
        switch n
            case 1
                coeffs_fract = coeffs_wordlength - 1;
            case 2
                coeffs_fract = coeffs_wordlength - 3;
            case 3
                coeffs_fract = coeffs_wordlength - 4;
            case 4
                coeffs_fract = coeffs_wordlength - 5;
            case 5
                coeffs_fract = coeffs_wordlength - 5;
            case 6
                coeffs_fract = coeffs_wordlength - 7;
            case 7
                coeffs_fract = coeffs_wordlength - 8;
            case 8
                coeffs_fract = coeffs_wordlength - 9;
            case 9
                coeffs_fract = coeffs_wordlength - 9;
            case 10
                coeffs_fract = coeffs_wordlength - 11;
        end
    case 2
        switch n
            case 1
                coeffs_fract = coeffs_wordlength - 1;
            case 2
                coeffs_fract = coeffs_wordlength - 3;
            case 3
                coeffs_fract = coeffs_wordlength - 3;
            case 4
                coeffs_fract = coeffs_wordlength - 3;
            case 5
                coeffs_fract = coeffs_wordlength - 3;
            case 6
                coeffs_fract = coeffs_wordlength - 4;
            case 7
                coeffs_fract = coeffs_wordlength - 4;
            case 8
                coeffs_fract = coeffs_wordlength - 5;
            case 9
                coeffs_fract = coeffs_wordlength - 5;
            case 10
                coeffs_fract = coeffs_wordlength - 5;
        end
    case 4
        if(n == 1)
          coeffs_fract = coeffs_wordlength - 1;
        else
          coeffs_fract = coeffs_wordlength - 2;
        end
end

end

