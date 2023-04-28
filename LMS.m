function [av_e, av_w, w]=LMS(u,mu,n)%%u is the input signal & n is the number of iteriation
L=length(u);
w=zeros(1,L); 
e=zeros(1,L);
b=[1 -0.99];
a=[1];
figure
 for k = 1:3
    for i2=1:100
              w = zeros(10000,1);
              v = sqrt(0.02)*randn(12000,1);
              v = v(1001:end);
              u = filter(a,b,v);
              u = u(1001:end);
              d = u;
              u = [0;u(1:end-1)];
              for i=1:n-1
                        e(i)=u(i+1)-w(i).*u(i);
                        w(i+1)=w(i)+mu(k).*u(i).*e(i);
              end
              opt_wieght(k,:)= w;
              e_total(:,i2)=e.^2;
              W_total(:,i2)=w;
    end
    av_w(k,:) = mean(transpose(W_total));    
    av_e =mean(transpose(e_total));
    
    i=(1:3500);
    plot(i,av_e(1:3500),'LineWidth', 1.5);
    title("LMS Learning Curves")
    hold on
 end
 legend("Mu=0.001", "Mu=0.005" ,"Mu=0.01");
 hold off;
% %%
% for i2=1:n
%           d =u;
%           u = [0; u(1:end-1)];
%           for i=1:L-1
%                     e(i)=u(i+1)-w(i).*u(i);
%                     w(i+1)=w(i)+mu.*u(i).*e(i);
%           end
%           e_total(:,i2)=e.^2;
%           W_total(:,i2)=-w;  
% end 
%     av_w=-mean(transpose(W_total));
%     av_e=-mean(transpose(e_total));
%   