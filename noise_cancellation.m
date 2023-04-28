% [signal,Fs] = audioread('eric.wav');
% L=length(signal);
% m=100;
% Ts=1/Fs;
%  windowLength = round(0.01*Fs);
%  overlapLength = round(0.005*Fs);
%  S = stft(signal,"Window",hann(windowLength,"periodic"),"OverlapLength",overlapLength,"FrequencyRange","onesided");
%  S = abs(S);

 f0=1;
 f1=300;
 t1=2;
 t=0:2./9999:2
 S=2*chirp(t,f0,t1,f1);
 L=length(S);
% power_of_signal=var(signal);
power_of_signal=var(S);                                
power_of_noise=0.5*power_of_signal;
v=sqrt(power_of_noise)*randn(1,1000+L);
v=v(1001:1000+L);
b=[1];

a=[1 0.5];
V2=filter(b,a,v);
d=S+v;
F=100;
m=11;
% for i=0:Fs/F           %from 0 to 480 "480 window"


[j w]= winner_filter(V2,d,m);
% 
% y(i:100)=s(i:F*i)-transpose(j);
% end
%figure
%stem(w);