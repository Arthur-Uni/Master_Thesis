function [ P ] = my_pareto( M, N )

k = length(M(:));

M_temp = M;

for i=1:k
    M_bigger = M(i) >= M;
    N_bigger = N(i) >= N;
    temp = M_bigger .* N_bigger;
    number_of_ones = nnz(temp);
    if(number_of_ones > 1)
        M_temp(i) = 0;
    end
end

P = M_temp;

end

