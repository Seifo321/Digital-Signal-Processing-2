clear; clc; close all;

[x_o, fs] = audioread("eric.wav");
x_n = 3 * x_o(90001 : 100000);
b = [1 0.85];
nTabs = 10;
% x = filter(b, 1, x_n);
x = x_n;
R = auto_corrs(x, nTabs);
[V, D] = eig(R);

% Extract the eigenvalues from the diagonal of D
lambda = diag(D);

% Set eigenvalues less than 1e-4 to zero
lambda(lambda < 1e-4) = 0;

% Sort the eigenvalues in descending order
[lambda_sorted, idx] = sort(lambda, 'descend');

% Extract the eigenvectors corresponding to the sorted eigenvalues
V_sorted = V(:, idx);

% Normalize the eigenvectors to be orthonormal
A = orth(V_sorted);

Block_size = 10;
Block_No = round(length(x) / Block_size);
x_block = reshape(x, Block_size, Block_No);
y_KLT_block = A * x_block;
Y_KLT = reshape(y_KLT_block, [Block_size * Block_No, 1]);

%% verification process

x_KLT_re = reshape(A \ y_KLT_block, [Block_size * Block_No, 1]);
mse_KLT = sqrt(mean((x - x_KLT_re).^2));

figure;
subplot(221)
plot(x_n(1000:1050));
ylim([-0.35 0.25])
title("original signal");

subplot(222)
plot(x_KLT_re(1000:1050));
ylim([-0.35 0.25])
title("Reconstructed signal using KLT");



%% DCT
N = 10;
% Create empty DCT matrix of order N
C = zeros(10,10);

% Compute DCT basis functions for each row and column
for i = 0:N-1
    for j = 0:N-1
        if i == 0
            C(i+1, j+1) = sqrt(1/N)*cos(((2*j+1)*i*pi)/(2*N));
        else
            C(i+1, j+1) = sqrt(2/N)*cos(((2*j+1)*i*pi)/(2*N));
        end
    end
end
% verification process OF DCT matrix 
% % Create DCT matrix of order N
% C = dctmtx(N);
% mse = sqrt(mean(C - D).^2);

Y_DCT_block = C * x_block; 
Y_DCT = reshape(Y_DCT_block , [10000, 1]);
% VERIFICATION
x_DCT_re = reshape(C \ Y_DCT_block , [10000 , 1]);
mse_DCT = sqrt(mean(x - x_DCT_re).^2);

subplot(223)
plot(x_n(1000:1050));
ylim([-0.35 0.25])

title("original signal");
subplot(224)
plot(x_DCT_re(1000:1050));
ylim([-0.35 0.25])

title("Reconstructed signal using DCT");

    
