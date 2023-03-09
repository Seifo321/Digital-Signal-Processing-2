clear all;
close ;
clc;
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
%lamda_max = eigs(R, 1);
%Mu = 2/(4*lamda_max) ;

%estimating the optimum weights by gradient descent algorithm

w = zeros(nTabs,1);
Mu = [0.1 0.2 0.30 0.4 0.5];
figure();
for j =1  : 5
  for i = 0 : 99
      err = P - R*w;
      w = w + err * Mu(j);
      jmin(i+1) = var(d_n) - dot((w.'),P)-dot((P.'),w) + dot((w.'),R*w);
  end
  w = zeros(nTabs,1);
plot(jmin)

hold on;
end
legend("Mu=0.1", "Mu=0.2" ,"Mu=0.3" ,"Mu=0.4","Mu=0.5")
hold off;

%w_opt = w;


% estimating the optimum weights by W0 = R^-1 * p

R = auto_corrs(u_n, nTabs);
P = cross_corre(u_n,d_n , nTabs);
w0 = inv(R) * P;


