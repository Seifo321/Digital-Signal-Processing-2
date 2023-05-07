clear, clc, close all;
% generate Poisson-distributed input signal
lambda = 50;
x = poissrnd(lambda, 1, 2000);
x = x(1001:end);
M = 16;
[y, b, mse, q] = lloyd_max_quantizer(x, M);
diff_y = diff(y);
% plot the input signal x
subplot(2,1,1)
plot(x)
hold on;
plot(q)
legend('Input signal','quantized signal');
title('Input signal & quantized signal')

% plot the quantization levels y
subplot(2,1,2)
stairs(y)
hold on;
xlim([1 M])
i = linspace(1 ,M-1, M-1 );
i_shifted = i+0.5;
plot(i_shifted,b, 'ro');
title('Quantization levels & Decision boundaries')
legend('Quantization levels','Decision boundaries');

fprintf('The MSE is equal to %f\n',mse);
fprintf('The difference between each level\n');
disp(diff_y)
