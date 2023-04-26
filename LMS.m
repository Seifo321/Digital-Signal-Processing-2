function [av_e av_w w]=LMS(u,m,mu,n)%%u is the input signal&n is the number of iteriation
L=length(u);
w=zeros(1,L); 
e=zeros(1,L);
% b=[1 -0.99];
% a=[1];
      
%%
    for i2=1:n
%         v=sqrt(0.02)*randn(1000+L,1); 
%         v=v(1001:end);
%         u=filter(a,b,v);
        d=u;
         u= [0 u(1:end-1)];
       
    for i=1:L-1
     e(i)=u(i+1)-w(i).*u(i);
     w(i+1)=w(i)+mu.*u(i).*e(i);

     end
     %%
       e_total(:,i2)=e.^2;
       W_total(:,i2)=-w;
     
    end
    
    av_w=-mean(transpose(W_total));
    av_e=-mean(transpose(e_total));
    
 

