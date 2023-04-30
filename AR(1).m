clear , close all ;
N = 10000; % number of samples
sigma_epsilon = 1; % noise variance
K = 20; % maximum lag
Rxx = zeros(1, K); % preallocate memory for autocorrelation function
figure();
for k = 0:K-1
    Rxx(k+1) = (1/(1-0.6^2))*0.6^k*sigma_epsilon; % calculate autocorrelation for lag k
end
Amp = max(Rxx);
Rxx = Rxx / Amp;
lags = 0:K-1; % lags for plotting
plot(lags, Rxx); % plot autocorrelation function
xlabel('k');
ylabel('R(k)');
legend('a1 = 0.6');

figure();
for k = 0:K-1
    Rxx(k+1) = (1/(1-0.99^2))*0.99^k*sigma_epsilon; % calculate autocorrelation for lag k
end
plot(lags, Rxx); % plot autocorrelation function
xlabel('k');
ylabel('R(k)');
legend('a1 = 0.99');

% generate AR(1) signal
x = zeros(1, N); % pre-allocate memory for signal
x=x(1001:end);
x(1) = randn; % set initial value of signal
for n = 2:100
    x(n) = .6 * x(n-1) + sigma_epsilon * randn;
end
figure()
% plot signal
plot(x(1:100));
xlabel('n');
ylabel('Xn');
title('AR Signal');
legend('a1 = 0.6');

figure();
for n = 2:100
    x(n) = 0.99 * x(n-1) + sigma_epsilon * randn;
end

% plot signal
plot(x(1:100));
xlabel('n');
ylabel('Xn');
title('AR Signal');
legend('a1 = 0.99');

