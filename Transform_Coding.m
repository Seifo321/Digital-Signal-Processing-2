%% KLT
clear;
x_n = randi([0 1], 11000, 1);
x_n = x_n(1001 : end);
b = [1 0.85] ;
nTabs = 10;
x = filter(b, 1, x_n);
R = auto_corrs(x , nTabs);
[V, D] = eig(R);


% Extract the eigenvalues from the diagonal of D
lambda = diag(D);

% Sort the eigenvalues in descending order
[lambda_sorted, idx] = sort(lambda, 'descend');

% Extract the eigenvectors corresponding to the sorted eigenvalues
V_sorted = V(:,idx);

% Normalize the eigenvectors to be orthonormal
A = orth(V_sorted);

Block_size = 10;
Block_No = length(x) / Block_size;
x_block = reshape(x, [Block_size,  Block_No]);
y_KLT_block = A * x_block; 
Y_KLT = reshape(y_KLT_block , [10000, 1]);

%% verification process

% x_KLT_re = reshape(inv(A) * y_KLT_block , [10000 , 1]);
% mse_KLT = sqrt(mean(x - x_KLT_re).^2);




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
% D = dctmtx(N);
% mse = sqrt(mean(C - D).^2);

Y_DCT_block = C * x_block; 
Y_DCT = reshape(Y_DCT_block , [10000, 1]);
% VERIFICATION
% x_DCT_re = reshape(inv(C) * y_DCT_block , [10000 , 1]);
% mse_DCT = sqrt(mean(x - x_DCT_re).^2);

    
figure ;
subplot(311);
stem(x(1:50));
title("original signal");
subplot(312);
stem(Y_KLT(1:50));
title("KLT signal");
subplot(313);
stem(Y_DCT(1:50));
title("DCT signal");