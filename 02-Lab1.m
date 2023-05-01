clear, clc, close all;
v1_n = sqrt(0.27).*randn(11000, 1);
v1_n = v1_n(1001 : end);
d_n  = filter(1, [1 0.8458],v1_n);
v2_n = sqrt(0.1).*randn(11000, 1);
v2_n = v2_n(1001:end);
x_n  = filter(1, [1 -0.9458], d_n);
u_n= v2_n - x_n;
jmin = zeros(1,10);
sigma = zeros(1,10);
for i = 1:10 
    nTabs = i;
    R = auto_corrs(u_n, nTabs);
    P = cross_corre(u_n,d_n , nTabs);
    sigma(i) = var(d_n);
    w0 = R\P;
    jmin(i) = sigma(i) - dot((P.'), w0);
		stem(i,jmin(i),'b','LineWidth',1.5);title("J_{min} Vs filter order");
		xlabel("filter order");ylabel("J_{min}");hold on
		set(gca,'FontWeight','bold')
		set(gca,'TitleFontSizeMultiplier',1.5)
end
%sigma_u = var(u_n);
[min_j, min_idx] = min(jmin);
fprintf('The best Wiener order that gives the least J_{min} is %f at order %d.\n', min_j, min_idx);

