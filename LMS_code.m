clear
v=sqrt(0.02)*randn(11000,1);
v=v(1001:end);
mu=[0.01 0.05 0.1];
b=[1 -0.99];
a=[1];
%v=sqrt(0.02)*randn(10000,1); 
u=filter(a,b,v);
m=1
d=u;
u= [0;u(1:end-1)];
w=zeros(10000,1); 
%av=zeros(1,500);
e=zeros(10000,1);
%e_total=zeros(10000,500);
[j1 w1]= winner_filter(u,d,m);

 %%
 for mu=[0.01 0.05 0.1]
      
%  for m=1:100
%      
%  
    
%%
    for i2=1:100
        v=sqrt(0.02)*randn(11000,1); 
        v=v(1001:end);
        u=filter(a,b,v);
        d=u;
        u= [0;u(1:end-1)];
       % mu=0.05;
%         [j1 w1]= winner_filter(u,d,m);
%         j(i2)=j1;
%         w(i2)=w1;
%         
    for i=1:9999
     e(i)=u(i+1)-w(i).*u(i);
     w(i+1)=w(i)+mu.*u(i).*e(i);

     end
     %%
       e_total(:,i2)=e.^2;
       W_total(:,i2)=w;
    % av(i2)=sum(e)/10000;
    % av_e(i2)=sum(e)/10000;

     
    end
    
   % r=mean(e);
 % av=mean(e_total);
%     av2=mean(W_total);
    %e_new=transpose(e_total);
    
    av=mean(transpose(W_total));
    av2=mean(transpose(e_total));
    
%    figure
%    plot(e_total);

  i=[1:1000];
 figure
   plot(i,av2(1:1000))
%    hold on
%    legend('mu=0.01','mu=0.05','mu=0.1')
   figure
  plot(-1.*av(1:1000))
   hold on
   plot(-1.*w(1:1000))
%    hold on
%    legend('mu=0.1','mu=0.2','mu=0.3')
 end
% end
