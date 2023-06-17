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

% Determine each frame is voiced or not and get pitch period
[voiced] = VUnV(quantized_data);
PitchPeriod = getPitchPeriod(voiced, quantized_data);
[STP , LTP, Residual ] = GetLPC(voiced , quantized_data , params.num_frames);

% [lpc_coefficient_t, residual_frame_t] = lpc_param(framed_data, voiced, params);
% lar_STP = lar(STP, 'a');
% lar_LTP = lar(LTP, 'a');
quantized_STP = pcm(STP, 16, 'a');
quantized_LTP = pcm(LTP, 16, 'a');

power = calculatePower(framed_data, params.num_frames);

noise_codebook = codebook(params);

noise_index = compare(Residual, noise_codebook);

% lpc_STP= lar(quantized_STP, 's');
% lpc_LTP= lar(quantized_LTP, 's');

residual_frame_r = zeros(params.frame_length,params.num_frames);

for i = 1: params.num_frames
	residual_frame_r(:, i) = noise_codebook(noise_index(i), :);
end
output = reconstructFrame(voiced, power, residual_frame_r, quantized_STP, quantized_LTP, PitchPeriod, params.num_frames);
power_r = calculatePower(output, params.num_frames);
% frame_synthesis = synthesis(residual_frame_r, STP, LTP, params.num_frames);
        
% concatinating frames
unframed_data = framing(output, sample_rate, 's');

% play the reconstructed audio
sound(unframed_data, sample_rate);


