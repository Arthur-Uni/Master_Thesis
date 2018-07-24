x = linspace(0,4);

y = cheb_horner_v2(x, 0, 4, 10);

t = tanh(x);

abs_error = abs(t-y);

rel_error = abs_error./t;

width = 1.5;
fontSize = 14;

%plot
figure(1);
subplot(3,1,1);
set(gca, 'Fontsize', fontSize);
hold on;
plot(x,t, 'linewidth', 2*width);
legend('tanh');
plot(x,y, 'linewidth', width);
legend('cheb tanh');
grid on;
xlabel('x');
ylabel('y');
title('degree 10 chebyshev approximation for 1 segment');

subplot(3,1,2);
plot(x,abs_error,'linewidth', width);
xlabel('x');
ylabel('absolute error');
grid on;
title('absolute error');

subplot(3,1,3);
plot(x,rel_error,'linewidth', width);
xlabel('x');
ylabel('relative error');
grid on;
title('relative error');