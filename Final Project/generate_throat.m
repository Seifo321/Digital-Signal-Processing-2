function reconstructedSignal = generate_throat(lpcCoefficients, residualFrames, params)


% Assuming 'residualFrames' is a matrix of residual frames
% 'lpcCoefficients' is a matrix of corresponding LPC coefficients

% Initialize an empty array for the reconstructed audio signal
reconstructedSignal = zeros(params.num_frames,params.frame_length);

% Iterate over each residual frame and LPC coefficients
for i = 1:size(residualFrames, 1)
    % Get the current residual frame and LPC coefficients
    residualFrame = residualFrames(i, :);
	if lpcCoefficients{i, 1}.voiced == 0
		lpcCoeff = lpcCoefficients{i, 1}.short;

	else
		lpcCoeff_short = lpcCoefficients{i, 1}.short;
		lpcCoeff_long = lpcCoefficients{i, 1}.long;
		lpcCoeff = [lpcCoeff_long, lpcCoeff_short];
	end
			% Apply inverse LPC synthesis filtering
    filteredFrame = filter(1, lpcCoeff, residualFrame);
    
    % Add the filtered frame to the reconstructed audio signal
    reconstructedSignal(i, :) = filteredFrame;
end

end
