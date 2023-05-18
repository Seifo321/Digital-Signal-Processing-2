function lpc_coefficients = lpc_param(frames, voicedFlag, params)

    num_frames = params.num_frames; % Total number of frames
    lpc_coefficients = cell(num_frames, 1); % Cell array to store LPC coefficients
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
    
 
end
