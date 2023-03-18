clear, clc, close all;
%Generating the input signal and the desired signal "u(n), d(n)"
v1_n = sqrt(5.0909e-5).*randn(11000, 1);
v1_n = v1_n(1001 : end); %throwing the frist 1000 samples
v1_n = v1_n - mean(v1_n);
v2_n = sqrt(5.0909e-5).*randn(11000, 1);
v2_n = v2_n(1001 : end); %throwing the frist 1000 samples
v2_n = v2_n - mean(v2_n);

n = [0 1 2 3 4 5 6 7 8 9 10];
h_n = zeros(length(n),1);
for i = 1 : length(n)
  h_n(i) = 1./ (1 + power(n(i)-5,2));
end

v1_channel = conv(v1_n,h_n);
v1_channel = v1_channel(1:length(v1_n));
u_n = v1_channel + v2_n;
d_n = delayseq(v1_n, 8);
[Jmin,w0]= weiner(u_n,d_n,7);