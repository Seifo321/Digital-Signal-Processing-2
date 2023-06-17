function voicedLabels = VUnV(framedData)

% Get the number of frames.
numFrames = size(framedData, 2);

% Create a vector to store the voiced/unvoiced labels.
voicedLabels = zeros(numFrames, 1);

% Label each frame as voiced or unvoiced.
for i = 1:numFrames
  % Compute the energy of the frame.
  energy = sum(framedData(:, i).^2);

  % Compute the fundamental frequency of the frame.
  [~,index] = max(abs(fft(framedData(:, i))));
  fundamentalFrequency = index * (48000 / (2 * size(framedData, 1)));

  % Threshold the energy and fundamental frequency to determine if the frame is voiced.
  voicedLabels(i) = energy > 0.01 && fundamentalFrequency > 100;
end

end
