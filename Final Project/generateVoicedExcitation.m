function excitationSignal = generateVoicedExcitation(frameLength, pitchPeriod)
    % Generate voiced excitation signal
    t = 0:(frameLength - 1);
    
    % Generate a pulse train with the specified pitch period
    pulseTrain = pulstran(t, 0:2*pitchPeriod:(frameLength - 1), @rectpuls, pitchPeriod);
    
    % Generate a white noise signal as the innovation component
    innovationNoise = randn(1, frameLength);
    
    % Combine the pulse train and innovation noise
    excitationSignal = pulseTrain + innovationNoise;
end
