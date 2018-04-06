function out = Quantize(in,nbits,mode)
%QUANTIZE This function quantize the input
%   Detailed explanation goes here
MSB=11;

switch mode
    case 1
        %Fixed Point 
        out = round(in.*(2^nbits)) ./2^(nbits);
        out = min(2^MSB, out);
    case 2
        %Block Floating Point : Multiple variables share an exponent
        temp = in(:);
        if min(temp)<0
            nlm = ceil(log2(-min(temp))+1);
        else
            nlm=0;
        end
        nlp = ceil(log2( max(temp) /(1/2 - 2^(-nbits) ) ) );

        nl=max(nlm,nlp); %number of bits before the 2^0 including 2^0
        nr=nbits-nl; %number of bits after the 2^0
        
        %quantize with the calculated optimal exponent
        out =round(in.*(2^nr)) ./2^(nr);

    otherwise
        out=in;
end


end

