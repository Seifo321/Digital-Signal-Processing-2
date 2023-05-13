close all;
clear all;
clc;

%% generation of u(n) with 1 variance of white noise
u_n = 1 * randn(1,11000);
u_n = u_n(1001 : end);
u_n = u_n - mean(u_n);
u_n = u_n';
nTabs = 10;

%% generation of h_n and d_n
n = [0 1 2 3 4 5 6 7 8 9];
h_n = zeros(length(n),1);
for i = 1 : length(n)
  h_n(i) = power(-0.9,n(i)) + power(0.8,n(i));
end
d_n =conv(u_n,h_n);
d_n = d_n(1: length(u_n));

%% Results : MMSE and wiener optimum weights
[jmin , w0] = wiener(u_n,d_n,10);
w0 = flip(w0);


%% Channel estimation with gradient algorithm 
Mu = [0.01 0.005 0.0015];
[j_sd , w_sd] = Gradient(u_n, d_n,nTabs, Mu, 2000);

w_sd=flip(w_sd);

%% Channel estimation with gradient algorithm 
for j = 1:length(Mu)
    for k = 1 :100
        u_n = 1 * randn(1,11000);
        u_n = u_n(1001 : end);
        u_n = u_n - mean(u_n);
        
        d_n =conv(u_n,h_n);
        d_n = d_n(1: length(u_n));
        
        [e_lms, w_lms] = LMS3 (u_n,d_n,11, Mu(j), 2500 );

           e_total(:,k)=e_lms.^2;
           W_total(:,k)=w_lms;

        
    end
    
    av_w(j,:) = mean(transpose(W_total))';    
    av_e(j,:) =transpose(mean(e_total)');

end