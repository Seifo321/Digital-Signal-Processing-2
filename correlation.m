
function [P R]=correlation(u,d,m)
% if length(u)>=length(d)   
% L=length(d);
% else
L=length(u);
% end
%CALCULATE R MATRIX
r=zeros(1,m);

for n=1:m 
t=sum(u(1:L+1-n).*u(n:L))./length(u(1:L+1-n).*u(n:L));
r(n)=t;
end

R=toeplitz(r);
P=zeros(m,1);
for n=1:m     
q=sum(u(1:L+1-n).*d(n:L))./length(u(1:L+1-n).*d(n:L));
P(n)=q;
end