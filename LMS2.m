function [av_e, av_w, w]=LMS2(L,mu,n)%%u is the input signal & n is the number of iteriation

w=zeros(1,L); 
e=zeros(1,L);
for mu=mu
    for i2=1:100
                 f0=1;
                 f1=300;
                 t1=2;
                 t=0:2./9999:2;
                 S= 0.9929*chirp(t,f0,t1,f1);
                 L=length(S);
                 power_of_signal=0.4965;                                
                power_of_noise=0.01*power_of_signal;
                v=sqrt(power_of_noise)*randn(1,1000+L);
                v=v(1001:1000+L);
                d=S+v;
                h = fir1(11, 0.25);
                % Apply the filter to the input sequence
                V2 = filter(h, 1, v);
                u=V2;

              for i=1:n-1
                        e(i)=d(i)-w(i).*u(i);
                        w(i+1)=w(i)+mu.*u(i).*e(i);
              end
              
              e_total(:,i2)=e.^2;
              W_total(:,i2)=w;
    end
    av_w = mean(transpose(W_total));    
    av_e =mean(transpose(e_total));
    
end
 end
   