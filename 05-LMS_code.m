clear,clc,close all;
%%
b =[1 -0.99];
a =(1);
e=zeros(10000,1);
mu=[0.01 0.05 0.1];
figure
 for k = 1:3
    for i2=1:100
				w = zeros(1,1);
				v = sqrt(0.02)*randn(12000,1);
				v = v(1001:end);
				u = filter(a,b,v);
				u = u(1001:end);
				d = u;
				u = [0;u(1:end-1)];
				for i=1:9999
							e=u-w.*u;
							w=w+mu(k).*u.*e;
				end
				opt_wieght(k,:)= w;
				e_total(:,i2)=e.^2;
				W_total(:,i2)=w;
    end
    av(k,:) = mean(transpose(W_total));    
    av2 =mean(transpose(e_total));
    
    i=(1:600);
    plot(i,av2(1:600),'LineWidth', 1.5);
    hold on
 end
 legend("Mu=0.01", "Mu=0.05" ,"Mu=0.1");
 hold off;
 figure(2)
 plot(-1.*av(1,1:1000),'k','LineWidth', 1.5)
 hold on
 plot(-1.*opt_wieght(1,1:1000),'b--','LineWidth', 1.5)
 legend("ensample-averaged over 100 runs", "single realization" );