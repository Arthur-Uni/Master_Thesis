function [ a, b ] = line_coeffs( x1, x2, y1, y2 )

syms a_sym;
syms b_sym;

eqns = [y1 == a_sym*x1+b_sym, y2 == a_sym*x2+b_sym];
vars = [a_sym,b_sym];
[a, b] = solve(eqns, vars);

end

