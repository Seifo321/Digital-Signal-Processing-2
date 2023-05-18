function LarCoefficients = lar(lpc_coefficients)
    LarCoefficients = cell(length(lpc_coefficients), 1);

    for i = 1 : length(lpc_coefficients)
        if lpc_coefficients{i, 1}.voiced == 0
			lar_short = poly2rc(lpc_coefficients{i, 1}.short);
            LarCoefficients{i} = struct('voiced', false,'short',lar_short);

		else
			lar_short = poly2rc(lpc_coefficients{i, 1}.short);
			lar_long = poly2rc(lpc_coefficients{i, 1}.long);
            LarCoefficients{i} = struct('voiced', true,'long',lar_long ,...
                'short',lar_short);
        end
            
            
    end

end
