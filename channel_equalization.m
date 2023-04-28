
v1=randi([0 1],1,11000);
v1=v1(1001:end);
for i=1:10
    if v1(i)==0
        v1(i)=-1;
    end 
end

v2=sqrt(5.0909*10^(-5))*randn(1,11010);
v2=v2(1001:end);
delay=8;
n=0:10;

h=1./(1+(n-5).^2);
x=conv(v1,h);
x_g=20*log(x);
% figure
% plot(10*log(h));

d=[zeros(1,delay) v1];
u=x+v2;
u=u(1:length(d));
m=7;
mu_i=[0.001 0.005 0.01];

[j1 w1]= wiener(u,d,m);
%figure
%stem(h)
figure
stem(w1)
[P R]=correlation(u,d,m);
[R1] = auto_corrs(u,m);
[p1] = cross_corre(u,d,m);
for mu=mu_i
    
[j2 w2]=SD(u,d,m,mu);
 
figure
 stem(w2)
 mms=min(j2)
end
n=100;
%%
for mu=mu_i
[av_e av_w w]=LMS(u,m,mu,n);

 i=[1:1000];

  figure
   plot(av_w(1:1000))
    hold on
 plot(w(1:1000))

end
