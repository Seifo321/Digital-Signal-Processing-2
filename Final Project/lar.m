function LarCoefficients = lar(lpc_coefficients)
    LarCoefficients = cell(length(lpc_coefficients), 1);

    for i = 1 : length(lpc_coefficients)
        if lpc_coefficients{i, 1}.voiced == 0
            LarCoefficients{i,1} = struct('short',poly2rc(lpc_coefficients{i, 1}.short));

        else
            LarCoefficients{i,1} = struct('long', ploy2rc(lpc_coefficients{i, 1}.long),...
                'short',poly2rc(lpc_coefficients{i, 1}.short));
        end
            
            
    end

end