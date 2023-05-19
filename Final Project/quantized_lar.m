function quantized = quantized_lar(lar_coefficients)
quantized = cell(length(lar_coefficients), 1);

for i = 1 : length(lar_coefficients)

    if lar_coefficients{i,1}.voiced == 0
        
        shortt = lar_coefficients{i,1}.short;
        quantized_short = pcm(shortt, 16, 'a');
        
        quantized{i,1} = struct('voiced', false,'short',quantized_short);
    else
        longg = lar_coefficients{i,1}.long;
        quantized_long = pcm(longg, 16, 'a');
        
        shortt = lar_coefficients{i,1}.short;
        quantized_short = pcm(shortt, 16, 'a');
        
        quantized{i,1} = struct('voiced', true, 'long', quantized_long, 'short',quantized_short);
    end
    


end





end
