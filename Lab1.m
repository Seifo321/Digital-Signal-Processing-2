clear all
v1_n = sqrt(0.27).*randn(11000, 1);
v1_n = v1_n(1001 : end);
d_n  = filter(1, [1 0.8458],v1_n);
v2_n = sqrt(0.1).*randn(11000, 1);
v2_n = v2_n(1001:end);
x_n  = filter(1, [1 -0.9458], d_n);
u_n= v2_n - x_n;
for i = 1:10 
    nTabs = i;
    R = auto_corrs(u_n, nTabs);
    P = cross_corre(u_n,d_n , nTabs)
    sigma = var(d_n);
    w0 = inv(R) * P;
    jmin(i) = sigma - dot((P.'), w0);
end
sigma_u = var(u_n);
plot(jmin)