clear, clc, close all;

% Ask the user if they want to record or read an audio file
user_input = input('Do you want to record or read an audio file? Type "record" or "read": ', 's');

% Call the appropriate function based on the user's choice
if strcmp(user_input, 'record')
    [audio_data, sample_rate] = record_or_read('record');
elseif strcmp(user_input, 'read')
    [audio_data, sample_rate] = record_or_read('read');
else
    error('Invalid input. Please type "record" or "read".');
end

% Play the original audio 
% sound(audio_data, sample_rate);
% pause(4);

% framing data and each frame is 18ms
[framed_data, params] = framing(audio_data, sample_rate, 'a');

% Quantize the data to 8 bits
quantized_data = pcm(framed_data, 16, 'a');

% Dequantize the data
% dequantized_data = pcm(quantized_data, 16, 's');

% Determine each frame is voiced or not and get pitch period
[voicedUnvoiced, pitchPeriods] = voicedUnvoicedDetection(quantized_data, params, 90);

[lpc_coefficient_t, residual_frame_t] = lpc_param(quantized_data, voicedUnvoiced, params);

lar_coefficients = lar(lpc_coefficient_t, 'a');
quantized_lar_coeff = quantized_lar(lar_coefficients);

noise_codebook = codebook(params);

noise_index = compare(residual_frame_t, noise_codebook);

lpc_coefficient_r = lar(quantized_lar_coeff, 's');

residual_frame_r = zeros(params.num_frames,params.frame_length);

for i = 1: params.num_frames
	residual_frame_r(i, :) = noise_codebook(noise_index(i), :);
end

reconstructedSignal = generate_throat(lpc_coefficient_r, residual_frame_r, params);

% concatinating frames
unframed_data = framing(reconstructedSignal', sample_rate, 's');

% play the reconstructed audio
sound(unframed_data, sample_rate);
