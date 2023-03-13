function [Jmin,w0] = weiner (u_n,d_n,nTabs)

if nargin <= 2
    nTabs =1;
end
    R = auto_corrs(u_n, nTabs);
    P = cross_corre(u_n,d_n , nTabs);
    sigma = var(d_n);
    w0 = inv(R) * P;
    Jmin = sigma - dot((P.'), w0);
end