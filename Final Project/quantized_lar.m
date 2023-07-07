function quantized = quantized_lar(lpc_coefficients,lar_coefficients)
quantized = cell(length(lpc_coefficients), 1);
for i = 1 : length(lar_coefficients)
    if lpc_coefficients{i,1}.voiced == 1 
        
        longg = lar_coefficients{i,1}.long;
        quantized_long = pcm(longg, 16, 'a');
        shortt = lar_coefficients{i,1}.short;
        quantized_short= pcm(shortt, 16, 'a');
    
        quantized = struct('long',quantized_long, 'short',quantized_short);
    
    else
        
        shortt = lar_coefficients{i,1}.short;
        quantized_short= pcm(shortt, 16, 'a');
        
        quantized = struct('short',quantized_short);
    
    end
    

end



end