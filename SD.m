function [Js Ws]=SD(u,d,m,mu)

sgma_d=var(d);
 
[Ps Rs]=correlation(u,d,m);

Ws=zeros(m,1);
 
L_max=max(eig(Rs));
mu_max=2./L_max;

for mu=mu
Ws=zeros(m,1);
for i=1:10000
    
 Ws=Ws+mu.*(Ps-(Rs*Ws));
 Js(i)=sgma_d-transpose(Ws)*Ps-transpose(Ps)*Ws+transpose(Ws)*Rs*Ws;
 
end
%j=min(Js);
figure
plot(Js);
title('Steepest descent ')
hold on
end
