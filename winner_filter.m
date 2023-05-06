function [j w]= winner_filter(u,d,m,n)
%calculating the variance of the desired signal
sgma_d=var(d);

%CALCULATE R MATRIX
%THE CROSS CORRELATION VECTOR P

[P R]=correlation(u,d,m);
j=zeros(1,n);
 for i=1:n
 w=inv(R)*P;
 j(i)=sgma_d-transpose(P)*inv(R)*P;
 end 
 