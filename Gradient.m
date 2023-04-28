function [jmin, w] = Gradient(u_n, d_n, nTabs,Mu) 

R = auto_corrs(u_n, nTabs);
P = cross_corre(u_n , d_n , nTabs);

if nargin < 4 
    % estimating appropriate step size u 
    lamda_max = eigs(R, 1);
    Mu = 2/(4*lamda_max) ;
    
    %estimating the optimum weights by gradient descent algorithm
    
    w = zeros(nTabs,1);
      for i = 0 : 99
          err = P - R*w;
          w = w + err * Mu;      
      end
    jmin = var(d_n) - dot((w.'),P)-dot((P.'),w) + dot((w.'),R*w);

else
    for j = 1 : length(Mu)
        w= zeros(nTabs, 1);
        for i =  0 : 99 
            err = P - R*w;
            w = w + err * Mu(j);
        end
        jmin = var(d_n) - dot((w.'),P)-dot((P.'),w) + dot((w.'),R*w);
    end

end
