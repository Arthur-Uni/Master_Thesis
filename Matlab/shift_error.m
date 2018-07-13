asymp  = 1-Results(1);

% wc = [64 32 26 20 17 16 15 14 13 12 11 10 9];
 wc = [26 20 17 16 15 14 13 12 11 10 9];
% wc = [4 8 14 16 26 32 34 50 66 130];
figure(1);
plot(wc, asymp .* ones(size(wc)));
hold on;
plot(wc, 1-Results(2:end));