
%-----------------------------------------------------------------------------------------
 f0=1;
 f1=300;
 t1=2;
 t=0:2./9999:2;
 S= 0.9929*chirp(t,f0,t1,f1);
 L=length(S);
 figure
 plot(S);
 
% power_of_signal=var(signal);
power_of_signal=var(S);                                
power_of_noise=0.01*power_of_signal;
v=sqrt(power_of_noise)*randn(1,5000+L);
v=v(5001:5000+L);
%% Generate input sequence u(n)
% Design the half-band LPF
order = 11;
f_cutoff = 0.25; % normalized cutoff frequency (0.5 = Nyquist frequency)
h = fir1(order, f_cutoff);
% Apply the filter to the input sequence
V2 = filter(h, 1, v);
% n=length(v);
% Plot the results
% subplot(2,1,1);
% plot( v);
% title('Input sequence u(n)');
% xlabel('n');
% ylabel('v(n)');
% 
% subplot(2,1,2);
% plot(V2);
% title('Output sequence v(n)');
% xlabel('n');
% ylabel('v(n)');

%%
n=4000;
d=S+v;
F=100;
m=100;
mu=0.1;
[j w]= winner_filter(V2,d,m,n);
figure
 plot(j);
 title('winner filter');
 MMSE_w=min(j)
%%
[Js Ws]=SD(V2,d,m,mu);
%figure
% plot(Js);
% title('Steepest descent filter');
MMSE_SD=min(Js)
p=var(d)

%%
 
 [av_e, av_w, w]=LMS2(L,mu,10000);
 figure
 plot(av_e);
 title("LMS Learning Curves")
