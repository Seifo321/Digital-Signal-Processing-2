function [cross_sum] = cross_corre(u_n , d_n , nTabs)

cross_sum = zeros(nTabs , 1);
for j = 0 :  (length(u_n) - nTabs) 
    cross = u_n(j+1 : nTabs+j) * d_n(nTabs+j);
    cross_sum = cross_sum + cross;
end
cross_sum = cross_sum / (length(u_n) - nTabs ) ;
end