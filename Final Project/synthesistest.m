    synthesizedSignal = zeros(1, (num_frames-1)*params.overlap + frame_length);
    startIndex = 1;   
% LPC Synthesis
	for i = 1:num_frames
		frameCoeffs = lpcCoefficients{i};
		% Generate excitation signal
		if frameCoeffs.voiced
			excitationSignal = generateVoicedExcitation(frame_length, pitchPeriod(i));
		else
			% Unvoiced Frame: Generate random excitation signal
			excitationSignal = randn(1, frame_length);
		end

		% Perform inverse LPC filtering
		frameSignal = filter(1, frameCoeffs.short, excitationSignal);

		% Overlap and add frames
		endIndex = startIndex + frame_length - 1;
		synthesizedSignal(startIndex:endIndex) = synthesizedSignal(startIndex:endIndex) + frameSignal;

		% Update the start index for the next frame
		startIndex = endIndex - params.overlap + 1;

		% Apply windowing if specified
% 		if windowing
% 			window = hann(frame_length)';
% 			synthesizedSignal(startIndex:endIndex) = synthesizedSignal(startIndex:endIndex) .* window;
% 		end
	end
        
    else % handle invalid input
		error('Invalid letter input. Please enter ''a'' to quantize or ''s'' to dequantize.');
	end