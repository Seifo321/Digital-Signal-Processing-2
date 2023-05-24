clear, clc, close all;

% Generate Laplacian-distributed input signal with specified variance
mu = 0;               % Mean of the Laplacian distribution
desired_variance = 2; % Desired variance for the Laplacian distribution
b = sqrt(desired_variance / 2); % Scale parameter of the Laplacian distribution
n = 2000;             % Number of samples

% Generate Laplacian-distributed random numbers
u = rand(1, n) - 0.5; % Uniform random numbers between -0.5 and 0.5
x_laplacian = mu - b * sign(u) .* log(1 - 2 * abs(u));

% Normalize input signal to have the desired variance
x_laplacian = x_laplacian / std(x_laplacian) * sqrt(desired_variance);

M = 4;

% Perform quantization on the Laplacian-distributed data
[y, b, mse, q] = lloyd_max_quantizer(x_laplacian, M);

diff_y = diff(y);

% Plot the input signal x
subplot(2,1,1)
plot(x_laplacian)
hold on;
plot(q)
legend('Input signal','Quantized signal');
title('Input signal & quantized signal')

% Plot the quantization levels y
subplot(2,1,2)
stairs(y)
hold on;
xlim([1 M])
i = linspace(1, M-1, M-1);
i_shifted = i + 0.5;
plot(i_shifted, b, 'ro');
title('Quantization levels & Decision boundaries')
legend('Quantization levels','Decision boundaries');

fprintf('The MSE is equal to %f\n', mse);
fprintf('The difference between each level\n');
disp(diff_y)
