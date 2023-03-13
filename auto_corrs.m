function [R] = auto_corrs(u_n, nTabs) 
  summation = 0;
  R_v = zeros(nTabs , 1);
  for j = 0: nTabs - 1
    for i = 1 : length(u_n)
      x = i+j;
      if x <= length(u_n)
        Correlation = u_n(i) * u_n(x);
        summation = summation + Correlation;
      else
        break
      end
    end
    R_v(j+1) = summation / length(u_n);
    summation = 0;
  end
  R = toeplitz(R_v);
end
