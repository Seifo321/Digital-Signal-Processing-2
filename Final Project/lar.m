function LarCoefficients = lar(lpc_coefficients)
    LarCoefficients = cell(length(lpc_coefficients), 1);

    for i = 1 : length(lpc_coefficients)
        if lpc_coefficients{i, 1}.voiced == 0
            shorttt =poly2rc(lpc_coefficients{i, 1}.short);
            LarCoefficients{i,1} = struct('short',shorttt);

        else
            shorttt =poly2rc(lpc_coefficients{i, 1}.short);
            longgg = poly2rc(lpc_coefficients{i, 1}.long);
            LarCoefficients{i,1} = struct('long',longgg,...
                'short',shorttt);
        end
            
            
    end

end
