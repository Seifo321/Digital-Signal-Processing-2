clear , clc, close all;
% Load speech signal
[s,fs] = audioread('eric.wav');

% Set frame length and overlap
frame_length = 20; % in milliseconds
overlap = 0.5; % as a fraction of frame length

% Convert frame length and overlap to samples
frame_length_samples = round(frame_length * fs / 1000);
overlap_samples = round(overlap * frame_length_samples);

% Segment speech signal into frames
num_frames = floor((length(s) - frame_length_samples) / overlap_samples) + 1;
frames = zeros(frame_length_samples, num_frames);
for i = 1:num_frames
    start_index = (i-1)*overlap_samples + 1;
    end_index = start_index + frame_length_samples - 1;
    frames(:,i) = s(start_index:end_index);
end

% Apply windowing function to each frame
window = hann(frame_length_samples);
windowed_frames = bsxfun(@times, frames, window);

% Calculate autocorrelation function for each frame
acf = zeros(frame_length_samples*2-1, num_frames);
for i = 1:num_frames
    acf(:,i) = xcorr(windowed_frames(:,i));
end

% Initialize variables
pitch = zeros(1, num_frames);
a_k = zeros(13, num_frames);
noise = zeros(frame_length_samples, num_frames);
lsfs = zeros(12, num_frames);
lar_coeffs = zeros(12, num_frames);

% Process each frame
for i = 1:num_frames
    % Find the peak of the autocorrelation function and its location
    [pks, locs] = findpeaks(acf(frame_length_samples:end, i));
    peak_threshold = 0.3 * max(pks); % Adjust this value based on your data

    if ~isempty(pks) && max(pks) > peak_threshold
        % Voiced speech
        pitch_period = mode(diff(locs));
    else
        % Unvoiced speech
        pitch_period = 0;
    end
    pitch(i) = pitch_period;

    % Compute LPC coefficients for each frame "short term LPC"
    order = 12; % LPC order
    [lpc_coeffs, ~] = lpc(windowed_frames(:,i), order);
    a_k(:,i) = lpc_coeffs;

    % Filter signal using LPC coefficients to obtain predicted signal
    predicted_signal = filter(lpc_coeffs, 1, windowed_frames(:,i));

    % Compute noise component by subtracting predicted signal from original signal
    noise(:,i) = predicted_signal - windowed_frames(:,i);


    % Compute LSFs from LPC coefficients
    lsfs(:,i) = poly2lsf(a_k(:,i));

%%
% Calculate pitch period as distance between peaks
pitch_period = mode(diff(locs)); 
pitch(:,i)=pitch_period;

    % Compute LAR coefficients from LSFs
    lar_coeffs(:,i) = diff([0; log(lsfs(:,i))]);
end

% Define the number of bits for quantization
num_bits = 8;

% Define the quantization step size
step_size = 2 / (2^num_bits - 1);

% Quantize the LAR coefficients
quantized_lar_coeffs = round(lar_coeffs / step_size) * step_size;

% Perform LAR inverse process on quantized LAR coefficients
lsfs_quantized = exp(cumsum([zeros(1, size(quantized_lar_coeffs, 2)); quantized_lar_coeffs]));
a_k_quantized = lsf2poly(lsfs_quantized);

% Perform LPC inverse process on quantized signal
reconstructed_signal = zeros(size(windowed_frames));
for i = 1:size(a_k_quantized,2)
    predicted_signal = filter([1; -a_k_quantized(:,i)], 1, noise(:,i));
    reconstructed_signal(:,i) = predicted_signal;
end

% Combine reconstructed frames into a single signal
rec_signal = overlap_add(reconstructed_signal, overlap_samples);

figure;
subplot(211);
plot(s);
subplot(212);
plot(rec_signal);

% Define the overlap_add function
function result = overlap_add(frames, overlap_samples)
    num_frames = size(frames, 2);
    frame_length_samples = size(frames, 1);
    result_length = (num_frames - 1) * overlap_samples + frame_length_samples;
    result = zeros(result_length, 1);
    
    for i = 1:num_frames
        start_index = (i - 1) * overlap_samples + 1;
        end_index = start_index + frame_length_samples - 1;
        result(start_index:end_index) = result(start_index:end_index) + frames(:, i);
    end
end
