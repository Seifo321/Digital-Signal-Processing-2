function LarCoefficients = lar(lpc_coefficients, mode)
% LAR analysis
if mode == 'a'
	
	LarCoefficients = cell(length(lpc_coefficients), 1);

	for i = 1 : length(lpc_coefficients)
		if lpc_coefficients{i, 1}.voiced == 0
			short =poly2rc(lpc_coefficients{i, 1}.short);
			LarCoefficients{i,1} = struct('voiced', false,'short',short);

		else
			short =poly2rc(lpc_coefficients{i, 1}.short);
			long = poly2rc(lpc_coefficients{i, 1}.long);
			LarCoefficients{i,1} = struct('voiced', true,'long',long,...
				'short',short);
		end


	end
	% Lar synthises
elseif mode == 's'
		LarCoefficients = cell(length(lpc_coefficients), 1);

	for i = 1 : length(lpc_coefficients)
		if lpc_coefficients{i, 1}.voiced == 0
			short = rc2poly(lpc_coefficients{i, 1}.short);
			
			% check stability
			is_stable = all(abs(roots(short)) < 1);
			if ~is_stable
				short = poly(polyroots(short, 'unit'));
			end
			
			LarCoefficients{i,1} = struct('voiced', false,'short',short);


		else
			short =rc2poly(lpc_coefficients{i, 1}.short);
			% check stability
			is_stable = all(abs(roots(short)) < 1);
			if ~is_stable
				short = poly(polyroots(short, 'unit'));
			end
			
			long = rc2poly(lpc_coefficients{i, 1}.long);
			% check stability
			is_stable = all(abs(roots(long)) < 1);
			if ~is_stable
				long = poly(polyroots(long, 'unit'));
			end
			LarCoefficients{i,1} = struct('voiced', true,'long',long,...
				'short',short);
		end
	end
end

end
