function power = calculatePower(signal, numFrames)

% Calculate the power of each frame.
power = zeros(numFrames, 1);
for i = 1:numFrames
    power(i) = var(signal(:,i) );
end

end
