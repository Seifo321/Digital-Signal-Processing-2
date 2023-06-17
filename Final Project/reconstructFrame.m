function output_ST = reconstructFrame(voiced, power, residual, lpcShortCoefficients, lpcLongCoefficients, pitchPeriod, number_frames)
output_ST = zeros(size(residual));
% excitation_pitch = zeros(size(residual,1), 1);
for frame = 1 : number_frames
    % Generate the excitation signal.
    excitationSignal = residual(:,frame)*0.08*power(frame);

	if voiced(frame)== 1
		% Generate a train of pulses for the excitation signal
		pulseTrain = ones(size(residual,1), 1);
% 		pulseTrain(1:1/round(pitchPeriod(frame):end)) = 1;

		% Interpolate the pulse train to match the frame length
		excitation_pitch = interp1(1:length(pulseTrain), pulseTrain, linspace(1, length(pulseTrain), size(residual,1)), 'previous');

		% Normalize the excitation signal
		excitation_pitch = excitation_pitch / max(abs(excitation_pitch));
		excitationSignal = excitationSignal .* excitation_pitch';
		% Filter the excitation signal to produce the output signal. 
		
		output_LT = filter(1, lpcLongCoefficients(:,frame), excitationSignal);
		output_ST(:,frame) = filter(1, lpcShortCoefficients(:,frame), output_LT);
	else
		output_ST(:,frame) = filter(1, lpcShortCoefficients(:,frame), excitationSignal);
	end
	
end
end
