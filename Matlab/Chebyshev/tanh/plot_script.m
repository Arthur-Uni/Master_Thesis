x_axis = 1:10;
width = 1.5;
%%
asymp2 = ones(1, length(x_axis)) * M(1,1);
asymp3 = ones(1, length(x_axis)) * M(2,1);
asymp4 = ones(1, length(x_axis)) * M(3,1);
asymp5 = ones(1, length(x_axis)) * M(4,1);
asymp6 = ones(1, length(x_axis)) * M(5,1);
asymp7 = ones(1, length(x_axis)) * M(6,1);
asymp8 = ones(1, length(x_axis)) * M(7,1);
asymp9 = ones(1, length(x_axis)) * M(8,1);
asymp10 = ones(1, length(x_axis)) * M(9,1);
asymp11 = ones(1, length(x_axis)) * M(10,1);
asymp12 = ones(1, length(x_axis)) * M(11,1);
asymp13 = ones(1, length(x_axis)) * M(12,1);
asymp14 = ones(1, length(x_axis)) * M(13,1);
asymp15 = ones(1, length(x_axis)) * M(14,1);
asymp16 = ones(1, length(x_axis)) * M(15,1);
asymp17 = ones(1, length(x_axis)) * M(16,1);
asymp18 = ones(1, length(x_axis)) * M(17,1);
asymp19 = ones(1, length(x_axis)) * M(18,1);
asymp20 = ones(1, length(x_axis)) * M(19,1);
asymp21 = ones(1, length(x_axis)) * M(20,1);
asymp22 = ones(1, length(x_axis)) * M(21,1);
asymp23 = ones(1, length(x_axis)) * M(22,1);
asymp24 = ones(1, length(x_axis)) * M(23,1);
asymp25 = ones(1, length(x_axis)) * M(24,1);
asymp26 = ones(1, length(x_axis)) * M(25,1);
asymp27 = ones(1, length(x_axis)) * M(26,1);
asymp28 = ones(1, length(x_axis)) * M(27,1);
asymp29 = ones(1, length(x_axis)) * M(28,1);
asymp30 = ones(1, length(x_axis)) * M(29,1);
asymp31 = ones(1, length(x_axis)) * M(30,1);
asymp32 = ones(1, length(x_axis)) * M(31,1);
%%
figure(1)
grid on;
subplot(4,4,1)
p1 = plot(x_axis, asymp2, x_axis, M(1,2:11), 'LineWidth', width);
title('wordlength = 2 bits')
axis([1 10 0 0.55]);
xlabel('degree of polynomial');
ylabel('maximum absolute error')
legend('matlab','chebyshev');

subplot(4,4,2)     
p2 = plot(x_axis, asymp3, x_axis, M(2,2:11), 'LineWidth', width);
title('wordlength = 3 bits')
axis([1 10 0 0.55]);
xlabel('degree of polynomial');
ylabel('maximum absolute error')

subplot(4,4,3)       
p3 = plot(x_axis, asymp4, x_axis, M(3,2:11), 'LineWidth', width);
title('wordlength = 4 bits')
axis([1 10 0 0.55]);
xlabel('degree of polynomial');
ylabel('maximum absolute error')

subplot(4,4,4)       
p4 = plot(x_axis, asymp5, x_axis, M(4,2:11), 'LineWidth', width);
title('wordlength = 5 bits')
axis([1 10 0 0.55]);
xlabel('degree of polynomial');
ylabel('maximum absolute error')

subplot(4,4,5)      
p5 = plot(x_axis, asymp6, x_axis, M(5,2:11), 'LineWidth', width);
title('wordlength = 6 bits')
axis([1 10 0 0.55]);
xlabel('degree of polynomial');
ylabel('maximum absolute error')

subplot(4,4,6)       
p6 = plot(x_axis, asymp7, x_axis, M(6,2:11), 'LineWidth', width);
title('wordlength = 7 bits')
axis([1 10 0 0.55]);
xlabel('degree of polynomial');
ylabel('maximum absolute error')

subplot(4,4,7)      
p7 = plot(x_axis, asymp8, x_axis, M(7,2:11), 'LineWidth', width);
title('wordlength = 8 bits')
axis([1 10 0 0.55]);
xlabel('degree of polynomial');
ylabel('maximum absolute error')

subplot(4,4,8) 
p8 = plot(x_axis, asymp9, x_axis, M(8,2:11), 'LineWidth', width);
title('wordlength = 9 bits')
axis([1 10 0 0.55]);
xlabel('degree of polynomial');
ylabel('maximum absolute error')

subplot(4,4,9)
p9 = plot(x_axis, asymp10, x_axis, M(9,2:11), 'LineWidth', width);
title('wordlength = 10 bits')
axis([1 10 0 0.55]);
xlabel('degree of polynomial');
ylabel('maximum absolute error')

subplot(4,4,10)     
p10 = plot(x_axis, asymp11, x_axis, M(10,2:11), 'LineWidth', width);
title('wordlength = 11 bits')
axis([1 10 0 0.55]);
xlabel('degree of polynomial');
ylabel('maximum absolute error')

subplot(4,4,11)       
p11 = plot(x_axis, asymp12, x_axis, M(11,2:11), 'LineWidth', width);
title('wordlength = 12 bits')
axis([1 10 0 0.55]);
xlabel('degree of polynomial');
ylabel('maximum absolute error')

subplot(4,4,12)       
p12 = plot(x_axis, asymp13, x_axis, M(12,2:11), 'LineWidth', width);
title('wordlength = 13 bits')
axis([1 10 0 0.55]);
xlabel('degree of polynomial');
ylabel('maximum absolute error')

subplot(4,4,13)      
p13 = plot(x_axis, asymp14, x_axis, M(13,2:11), 'LineWidth', width);
title('wordlength = 14 bits')
axis([1 10 0 0.55]);
xlabel('degree of polynomial');
ylabel('maximum absolute error')

subplot(4,4,14)       
p14 = plot(x_axis, asymp15, x_axis, M(14,2:11), 'LineWidth', width);
title('wordlength = 15 bits')
axis([1 10 0 0.55]);
xlabel('degree of polynomial');
ylabel('maximum absolute error')

subplot(4,4,15)      
p15 = plot(x_axis, asymp16, x_axis, M(15,2:11), 'LineWidth', width);
title('wordlength = 16 bits')
axis([1 10 0 0.55]);
xlabel('degree of polynomial');
ylabel('maximum absolute error')

subplot(4,4,16) 
p16 = plot(x_axis, asymp17, x_axis, M(16,2:11), 'LineWidth', width);
title('wordlength = 17 bits')
axis([1 10 0 0.55]);
xlabel('degree of polynomial');
ylabel('maximum absolute error')

suptitle('Chebyshev polynomial approximations with different wordlengths');
%%
figure(2)
grid on;
subplot(4,4,1)
p17 = plot(x_axis, asymp18, x_axis, M(17,2:11), 'LineWidth', width);
title('wordlength = 18 bits')
axis([1 10 0 0.55]);
xlabel('degree of polynomial');
ylabel('maximum absolute error');
legend('matlab','chebyshev');

subplot(4,4,2)     
p18 = plot(x_axis, asymp19, x_axis, M(18,2:11), 'LineWidth', width);
title('wordlength = 19 bits')
axis([1 10 0 0.55]);
xlabel('degree of polynomial');
ylabel('maximum absolute error');

subplot(4,4,3)       
p19 = plot(x_axis, asymp20, x_axis, M(19,2:11), 'LineWidth', width);
title('wordlength = 20 bits')
axis([1 10 0 0.55]);
xlabel('degree of polynomial');
ylabel('maximum absolute error')

subplot(4,4,4)       
p20 = plot(x_axis, asymp21, x_axis, M(20,2:11), 'LineWidth', width);
title('wordlength = 21 bits')
axis([1 10 0 0.55]);
xlabel('degree of polynomial');
ylabel('maximum absolute error')

subplot(4,4,5)      
p21 = plot(x_axis, asymp22, x_axis, M(21,2:11), 'LineWidth', width);
title('wordlength = 22 bits')
axis([1 10 0 0.55]);
xlabel('degree of polynomial');
ylabel('maximum absolute error')

subplot(4,4,6)       
p22 = plot(x_axis, asymp23, x_axis, M(22,2:11), 'LineWidth', width);
title('wordlength = 23 bits')
axis([1 10 0 0.55]);
xlabel('degree of polynomial');
ylabel('maximum absolute error')

subplot(4,4,7)      
p23 = plot(x_axis, asymp24, x_axis, M(23,2:11), 'LineWidth', width);
title('wordlength = 24 bits')
axis([1 10 0 0.55]);
xlabel('degree of polynomial');
ylabel('maximum absolute error')

subplot(4,4,8) 
p24 = plot(x_axis, asymp25, x_axis, M(24,2:11), 'LineWidth', width);
title('wordlength = 25 bits')
axis([1 10 0 0.55]);
xlabel('degree of polynomial');
ylabel('maximum absolute error')

subplot(4,4,9)
p25 = plot(x_axis, asymp26, x_axis, M(25,2:11), 'LineWidth', width);
title('wordlength = 26 bits')
axis([1 10 0 0.55]);
xlabel('degree of polynomial');
ylabel('maximum absolute error')

subplot(4,4,10)     
p26 = plot(x_axis, asymp27, x_axis, M(26,2:11), 'LineWidth', width);
title('wordlength = 27 bits')
axis([1 10 0 0.55]);
xlabel('degree of polynomial');
ylabel('maximum absolute error')

subplot(4,4,11)       
p27 = plot(x_axis, asymp28, x_axis, M(27,2:11), 'LineWidth', width);
title('wordlength = 28 bits')
axis([1 10 0 0.55]);
xlabel('degree of polynomial');
ylabel('maximum absolute error')

subplot(4,4,12)       
p28 = plot(x_axis, asymp29, x_axis, M(28,2:11), 'LineWidth', width);
title('wordlength = 29 bits')
axis([1 10 0 0.55]);
xlabel('degree of polynomial');
ylabel('maximum absolute error')

subplot(4,4,13)      
p29 = plot(x_axis, asymp30, x_axis, M(29,2:11), 'LineWidth', width);
title('wordlength = 30 bits')
axis([1 10 0 0.55]);
xlabel('degree of polynomial');
ylabel('maximum absolute error')

subplot(4,4,14)       
p30 = plot(x_axis, asymp31, x_axis, M(30,2:11), 'LineWidth', width);
title('wordlength = 31 bits')
axis([1 10 0 0.55]);
xlabel('degree of polynomial');
ylabel('maximum absolute error')

subplot(4,4,15)      
p31 = plot(x_axis, asymp32, x_axis, M(31,2:11), 'LineWidth', width);
title('wordlength = 32 bits')
axis([1 10 0 0.55]);
xlabel('degree of polynomial');
ylabel('maximum absolute error')

suptitle('Chebyshev polynomial approximations with different wordlengths');