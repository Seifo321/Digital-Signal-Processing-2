close all;
clear all;
clc;

%% generation of u(n) with 1 variance of white noise
u_n = 1 * randn(1,11000);
u_n = u_n(1001 : end);
u_n = u_n - mean(u_n);
nTabs = 10;

%generation of h_n and d_n
n = [0 1 2 3 4 5 6 7 8 9];
h_n = zeros(length(n),1);
for i = 1 : length(n)
  h_n(i) = power(-0.9,n(i)) + power(0.8,n(i));
end
d_n = zeros(1, 10000);
for i = 1 : length(n)
  d_n += h_n(i) * u_n 
end
d_n = d_n/10;

[jmin , w0] = weiner(u_n,d_n,10);

%d_n = h_n * u_n;
%
%R = auto_corrs(u_n,nTabs);
%%sigma = var(u_n);
%P = cross_corre(u_n, d_n, nTabs);
%P = P(1, :)';
%
%sigma_d = var(d_n);
%
%W0 = inv(R)* P;
