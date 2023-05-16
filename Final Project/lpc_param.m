function lpc_coefficients = lpc_param(frames, voicedFlag, params, letter, lpcCoefficients, pitchPeriod)

    num_frames = params.num_frames; % Total number of frames
    lpc_coefficients = cell(num_frames, 1); % Cell array to store LPC coefficients
	if letter == 'a' % perform LPC Analysis
		for i = 1:num_frames
			currentFrame = frames(:,i);

			if voicedFlag(i) == 1 % Voiced Frame
				% Long-Term LPC Analysis
				lpc_order = 10; % Set the desired order for long-term LPC
				[A_long, ~] = lpc(currentFrame, lpc_order);

				% Short-Term LPC Analysis
				lpc_order = 6; % Set the desired order for short-term LPC
				[A_short, ~] = lpc(currentFrame, lpc_order);

				lpc_coefficients{i} = struct('voiced', true, 'long', A_long, 'short', A_short);

			else % Unvoiced Frame
				% Short-Term LPC Analysis
				lpc_order = 6; % Set the desired order for short-term LPC
				[A_short, ~] = lpc(currentFrame, lpc_order);

				lpc_coefficients{i} = struct('voiced', false, 'short', A_short);

			end
		
    
		end
	elseif letter == 's' % perform LPC inverse
	num_frames = params.num_frames;
    frame_length = params.frame_length;
    % Initialize synthesized signal
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
end
