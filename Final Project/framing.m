function [data_out, params] = framing(audio_data, sample_rate, mode)
%FRAMING   Frame and deframe audio data.
%   [data_out, params] = FRAMING(audio_data, sample_rate, mode) takes an
%   audio signal audio_data sampled at sample_rate and frames it into
%   non-overlapping or overlapping frames of length 18 milliseconds. The
%   frames are windowed with a Hamming filter and the overlap between
%   consecutive frames is 40%. If mode is set to 'a', the function returns
%   the framed data and any parameters used for framing. If mode is set to
%   's', the function deframes the data by removing the overlapping parts
%   and concatenating the frames, and returns the deframed data and any
%   parameters used for deframing.
%
%   Example usage:
%       % Frame audio data
%       [framed_data, params] = framing(audio_data, sample_rate, 'a');
%
%       % Deframe audio data
%       unframed_data = framing(framed_data, sample_rate, 's');

% Calculate frame length in samples
frame_length_ms = 18; % milliseconds
frame_length = round(frame_length_ms / 1000 * sample_rate);

if mode == 'a'
    % Frame audio data
    num_frames = floor(length(audio_data) / frame_length);
    framed_data = zeros(frame_length, num_frames);
    for i = 1:num_frames
        framed_data(:, i) = audio_data((i-1)*frame_length+1 : i*frame_length) .* hamming(frame_length);
    end
    params.frame_length = frame_length;
    params.num_frames = num_frames;
    params.overlap = round(frame_length * 0.4);
    data_out = framed_data;
elseif mode == 's'
    % Deframe audio data
    num_frames = size(audio_data, 2);
    deframed_data = zeros(frame_length*num_frames-round(frame_length*0.4*(num_frames-1)), 1);
    for i = 1:num_frames
        start_idx = (i-1)*frame_length - round(frame_length*0.4*(i-1)) + 1;
        end_idx = start_idx + frame_length - 1;
        deframed_data(start_idx:end_idx) = deframed_data(start_idx:end_idx) + audio_data(:,i).*hamming(frame_length);
    end
    data_out = deframed_data;
else
    error('Invalid mode parameter. Valid values are "a" for analysis and "s" for synthesis.');
end
