clear,clc,close all;

%Generating the input signal and the desired signal "u(n), d(n)"
v1_n = sqrt(0.27).*randn(11000, 1);
v1_n = v1_n(1001 : end); %throwing the frist 1000 samples

d_n  = filter(1, [1 0.8458],v1_n);
v2_n = sqrt(0.1).*randn(11000, 1);
v2_n = v2_n(1001:end);   %throwing the frist 1000 samples
x_n  = filter(1, [1 -0.9458], d_n);
u_n= v2_n - x_n;

%estimating R and P f or 4 tap inputs
nTabs = 4;

R = auto_corrs(u_n, nTabs);
P = cross_corre(u_n, d_n, nTabs);
sigma_u = var(u_n);

% estimating appropriate step size u 
lamda_max = eigs(R, 1);
Mu = 2/(4*lamda_max) ;
fprintf('The appropriate step size 𝜇 is %f where 𝜆𝑚𝑎𝑥 = %f so 2/𝜆𝑚𝑎𝑥 = %f.\n', Mu, lamda_max,2/lamda_max);

%estimating the optimum weights by gradient descent algorithm
w = zeros(nTabs,1);
Mu = [0.1 0.2 0.30 0.4 0.5];
jmin = zeros(1,100);
lncolor = {'k-.','r-.','k','r','b'};
for j =1  : 5
	w = zeros(nTabs,1);
  for i = 1 : 100
      err = P - R*w;
      w = w + err * Mu(j);
      jmin(i) = var(d_n) - dot((w.'),P)-dot((P.'),w) + dot((w.'),R*w);
	end
	k = 1:100;
  plot(k,jmin(k),lncolor{j},'LineWidth',1.4);title("Learning Curves of Steepest Descent, filter order 4");
	xlabel("Time,n");ylabel("J(n)");hold on
	set(gca,'FontWeight','bold')
	set(gca,'TitleFontSizeMultiplier',1.2)
end
legend(sprintf('𝜇 = %s', num2str(mu(1))), sprintf('𝜇 = %s', num2str(mu(2))), sprintf('𝜇 = %s', num2str(mu(3))), sprintf('𝜇 = %s', num2str(mu(4))), sprintf('𝜇 = %s', num2str(mu(5))))

%w_opt = w;
% estimating the optimum weights by W0 = R^-1 * p

R = auto_corrs(u_n, nTabs);
P = cross_corre(u_n,d_n , nTabs);
w0 = R\P;

