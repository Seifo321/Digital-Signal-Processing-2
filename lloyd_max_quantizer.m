function [y, b, mse, q] = lloyd_max_quantizer(x, M)

% Set the decision boundaries
b = linspace(0, max(x), M-1);

% Initialize variables
y = zeros(1,M);
mse = inf;

% Main loop
while true
    % Update reconstruction levels
    for i = 1:M
        if i == 1
            y(i) = abs ((b(i) + min(x)) / 2);
        elseif i == M
            y(i) = abs ((b(i-1) + max(x)) / 2);
        else
            y(i) = abs( mean(x(x > b(i-1) & x <= b(i))));
        end
    end
    
    % Quantize input signal
		q = zeros(size(x));
    for j = 2:M-1
        q(x > b(j-1) & x <= b(j)) = y(j);
    end
    q(x > b(M-1)) = y(M);
    q(x < b(1)) = y(1);
    % Compute mean squared quantization error
    mse_old = mse;
    mse = mean((q - x).^2);
    
    % Stop if error does not improve
    if mse >= mse_old
        break;
    end
    
    % Update decision boundaries
    for i = 1:M-1
        b(i) = (y(i) + y(i+1)) / 2;
    end
end
