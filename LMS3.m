function [e, w]=LMS3(u,d,nTabs,mu,n_iter)%%u is the input signal & n is the number of iteriation

w=zeros(1,nTabs); 
e=zeros(1, nTabs);

for i=1:n_iter-1
    if ((i-1)*nTabs+1) < length(u) 
        e(i)=d(i)-w*u((i-1)*nTabs+1:i*nTabs)';
        w=w+u((i-1)*nTabs+1:i*nTabs)*mu*e(i);
    end
    break
end
    
end
   