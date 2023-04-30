clear,clc,close all;
% Moving Average Model (MA)
% No past values of the output are used
% Generate and plot a realization of a 1000 samples of
% Autoregressive model (AR) with the filter
% Hz=1−0.5*𝑧^-1
% Define the filter coefficients
b = [1, -0.5];

% Generate the MA process
ma_process = filter(b, 1, randn(1, 1000));

% Plot the MA process
plot(ma_process);
title('Realization of MA Model');
xlabel('Sample Index');
ylabel('Amplitude');
