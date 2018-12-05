function [ y ] = horner_scheme( x, a, b, c )
% transform x from interval [a,b] to [0,1]
x_transform = (x-a) .* (1/(b-a));

k = length(x);
l = length(c);

temp = ones(1,k);

temp = temp .* c(1);

for i=2:l
    temp = temp.*x_transform + c(i);
end

y = temp;

end

