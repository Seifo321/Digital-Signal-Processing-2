clear, clc, close all;

% Wiener solution
nTabs = 7; % Wiener filter order
%Generating the input signal 
x_n = randi([-1 1], 1, 11000);
x_n = x_n(1001 : end)'; %throwing the frist 1000 samples

%% the channel impulse response
n = 0:10;
h_n = zeros(length(n),1);
for i = 1 : length(n)
  h_n(i) = 1./ (1 + power(n(i)-5,2));
end

%% output of the channel 
v1_channel = conv(x_n,h_n);
v1_channel = v1_channel(1:length(x_n));

%% random signal added to the channel output and then fed to the adaptive filter as an input "u(n)"

v2_n = sqrt(5.0909e-5).*randn(11000, 1);
v2_n = v2_n(1001 : end); %throwing the frist 1000 samples
% v2_n = v2_n - mean(v2_n); % zero mean noise
u_n = v1_channel + v2_n;

%% the desired signal d(n) is a delayed version from the input signal x(n)
d_n = delayseq(x_n, 8);

%% MMSE and optimum weights of the adaptive filter
[Jmin,w0]= wiener(u_n,d_n,nTabs);
%% Steepest Descent solution
Mu = [0.001, 0.005, 0.01];
[j_sd , w_sd] = Gradient(u_n, d_n,nTabs,Mu);

%% LMS solution
[av_e, av_w, w]= LMS(u_n,Mu,10000);