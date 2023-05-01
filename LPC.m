clear, clc, close all;
[x,fs] = audioread('eric.wav');
a = lpc(x,3);
est_x = filter([0 -a(2:end)],1,x);  % Estimated signal
e = x - est_x;                      % Prediction error
[acs,lags] = xcorr(e,'coeff');      % ACS of prediction error
    
%   Compare the predicted signal to the original signal
plot(1:97,x(4001:4097),1:97,est_x(4001:4097),'--');
title('Original Signal vs. LPC Estimate');
xlabel('Sample Number'); ylabel('Amplitude'); grid;
legend('Original Signal','LPC Estimate')
 
%   Look at the autocorrelation of the prediction error.
figure; plot(lags,acs); 
title('Autocorrelation of the Prediction Error');
xlabel('Lags'); ylabel('Normalized Value');grid;