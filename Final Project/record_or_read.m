function [audio_data, sample_rate] = record_or_read(option)
% option: 'record' or 'read'
	
	if strcmp(option, 'record')
			% Display text indicating the start of recording
			disp('Recording started. Please speak into the microphone.');
			% Record audio for 4 seconds
			recorder = audiorecorder(48000, 24, 1); % Set the sampling rate 
			% to 48000 Hz and the bit depth to 24 bits 
			record(recorder);
			pause(4);
			stop(recorder);
			audio_data = getaudiodata(recorder);
			sample_rate = recorder.SampleRate;
			% Display text indicating the end of recording
			disp('Recording ended.');
			% Resample audio_data to a new length of 192000 samples
			target_length = 192000;
			if length(audio_data)~=target_length
			audio_data = resample(audio_data, target_length, length(audio_data));
			% Display text indicating the end of recording and resampling
			% disp('Recording and resampling ended.');
			end
			% Save the recorded audio to a file called "Recorded Audio.wav"
			audiowrite('Recorded Audio.wav', audio_data, sample_rate);
	elseif strcmp(option, 'read')
			% Ask for the audio file name
			file_name = input('Enter the audio file name: ', 's');
			% Read the audio file
			[audio_data, sample_rate] = audioread(file_name);
			% If the audio file is longer than 4 seconds, truncate it to the first 4 seconds
			if size(audio_data, 1) > sample_rate * 4
					audio_data = audio_data(1:sample_rate * 4, :);
			end
			target_length = 192000;
			if length(audio_data)~=target_length
			% Resample audio_data to a new length of 192000 samples
			audio_data = resample(audio_data, target_length, length(audio_data));
			% Display text indicating the end of reading and resampling
			% disp('Reading and resampling ended.');
			end
			% Save the recorded audio to a file called "Readed Audio.wav"
			audiowrite('Readed Audio.wav', audio_data, sample_rate);
	else
			error('Invalid option. Please choose "record" or "read".');
	end

end
