function [jmin, w] = Gradient(u_n, d_n, nTabs,Mu,n_iter) 

R = auto_corrs(u_n, nTabs);
P = cross_corre(u_n , d_n , nTabs);

if nargin < 5
    % estimating appropriate step size u 
    lamda_max = eigs(R, 1);
    Mu = 2/(4*lamda_max) ;
    
    %estimating the optimum weights by gradient descent algorithm
    
    w = zeros(nTabs,1);
      for i = 0 : n_iter
          err = P - R*w;
          w = w + err * Mu; 

      end
    jmin = var(d_n) - dot((w.'),P)-dot((P.'),w) + dot((w.'),R*w);

else
    figure();
    for j = 1 : length(Mu)
        w= zeros(nTabs, 1);
        for i =  0 : n_iter-1
            err = P - R*w;
            w = w + err * Mu(j);
            jmin(i+1) = var(d_n) - dot((w.'),P)-dot((P.'),w) + dot((w.'),R*w);
        end
       plot(jmin, 'LineWidth', 1.5);
       hold on 
    end
    legend(sprintf('Mu = %s', num2str(Mu(1))), sprintf('Mu = %s', num2str(Mu(2))), sprintf('Mu = %s', num2str(Mu(3))))
    hold off

end