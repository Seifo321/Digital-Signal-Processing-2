function pitchPeriod = getPitchPeriod(voiced, frame)
pitchPeriod = zeros(1,size(frame,2));
for i = 1 : size(frame,2)
    % Compute the ACF of the frame.
    if voiced(i) == 1
        % voiced_frame: voiced speech frame

        % Calculate the autocorrelation of the voiced frame
        autocorrelation = xcorr(frame(:, i));

        % Find the peak that corresponds to the fundamental frequency
        peak_index = find(autocorrelation == max(autocorrelation));

        % Calculate the pitch period
        pitchPeriod(i) = 1000 / (peak_index * 48000);

    else
         pitchPeriod(i) = 0;
    end
end
end
