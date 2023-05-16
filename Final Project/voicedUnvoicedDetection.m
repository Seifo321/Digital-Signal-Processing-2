function [voicedUnvoiced, pitchPeriods] = voicedUnvoicedDetection(audioFrames, params, thresholdPercentage)
    % audioFrames: Matrix containing the audio data frames (one frame per column)
    % frameSize: Size of each audio frame
    % overlap: Overlap between consecutive frames (percentage)
    % thresholdPercentage: Percentage of the maximum peak value as the threshold (e.g., 80)

    % Calculate the number of frames
    numFrames = params.num_frames;

    % Initialize an array to store the voiced/unvoiced decision for each frame
    voicedUnvoiced = zeros(1, numFrames);
	
	pitchPeriods = zeros(1, numFrames);

	for i = 1:numFrames
		% Extract the current frame
		frame = audioFrames(:, i);

		% Calculate the autocorrelation function
		autocorr = xcorr(frame);
		
		% Find peaks in the autocorrelation
		[~, locs] = findpeaks(autocorr);
		
		% Calculate pitch period as the average distance between peaks
		pitchPeriods(i) = mean(diff(locs));
		
		% Find the peak in the autocorrelation function (excluding the central peak)
		[maxPeak, ~] = max(abs(autocorr(floor(length(autocorr)/2)+1:end)));

		% Calculate the normalized autocorrelation peak
% 		peakValue = autocorr(maxIndex + floor(length(autocorr)/2)) / autocorr(floor(length(autocorr)/2));

		% Calculate the adaptive threshold based on the maximum peak value
		threshold = thresholdPercentage / 100 * maxPeak;
		
		harmonicPeaks = maxPeak * [1, 2, 3, 4]; % Check up to 4 harmonics
		otherPeaks = autocorr(autocorr > threshold * maxPeak & ~ismember(autocorr, harmonicPeaks));

		% Determine if the frame is voiced or unvoiced based on the
		% threshold and consecutive peaks
		if ~isempty(harmonicPeaks) && isempty(otherPeaks)
			voicedUnvoiced(i) = 1;  % voiced
		else
			voicedUnvoiced(i) = 0;  % UnVoiced
		end

		
	end
	% just to make sure that we classified the frames correctly and this
	% apply to eric.wav
% 	figure
% 	subplot(211)
% 	plot(xcorr(audioFrames(:, 103))) % unvoiced
% 	hold on
% 	subplot(212)
% 	plot(xcorr(audioFrames(:, 104))) % voiced

end
