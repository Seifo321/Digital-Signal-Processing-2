clear,clc,close all;
% Autoregressive Model (AR)
% No past values of the input are used
% Generate and plot a realization of a 1000 samples of
% Autoregressive model (AR) with the filter
% Hz=1/1−0.5*𝑧^-1
% Define the filter coefficients
a = [1, -0.5];

% Generate the AR process
ar_process = filter(1, a, randn(1, 1000));

% Plot the AR process
plot(ar_process);
title('Realization of AR Model');
xlabel('Sample Index');
ylabel('Amplitude');
