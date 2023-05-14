%%
% Load speech signal
[s,fs] = audioread('eric.wav');
n=0;
m=0;
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
%%
% Apply windowing function to each frame
% window = hann(frame_length_samples);
% windowed_frames = bsxfun(@times, frames, window);
%%
% Calculate autocorrelation function for each frame
acf = zeros(frame_length_samples*2-1, num_frames);
for i = 1:num_frames
    acf(:,i) = xcorr(frames(:,i));
end
%%
% Find the peak of the autocorrelation function and its location
for i=1:1:855
[pks,locs] = findpeaks(acf(frame_length_samples:end, i));
thershold = 5.6278./2;


%%
% Calculate pitch period as distance between peaks
pitch_period = mode(diff(locs)); 
pitch(:,i)=pitch_period

% Determine voiced or unvoiced speech based on pitch period
if pitch_period <= 20   
    disp('Voiced speech');
    m=m+1;
    
else
    disp('Unvoiced speech');
           % Compute LPC coefficients for each frame "short term LPC"
            order = 12; % LPC order
            lpc_coeffs = zeros(order+1, num_frames);
            n=n+1;
            lpc_coeffs = lpc(frames(:,i), order);
            a_k(:,i)=lpc_coeffs;
            % Filter signal using LPC coefficients to obtain predicted signal
            predicted_signal = filter(lpc_coeffs, 1,frames(:,i) );

            % Compute noise component by subtracting predicted signal from original signal
            noise(:,i) = frames(:,i) - predicted_signal;
            
            % Compute LSFs from LPC coefficients
            lsfs(:,i) = poly2lsf(a_k(:,i));

            % Compute LAR coefficients from LSFs
            lar_coeffs(:,i)= diff([0; log(lsfs(:,i))]);
           
        
end
            %quantization
            
            

end 