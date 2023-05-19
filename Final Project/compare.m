function idx = compare(residual_frame)

% Assuming 'codebook' is your codebook of stored noise vectors
% 'voiceSignal' is the voice signal with noise

% Initialize an array to store the indices of the closest noise vectors
closestIndices = zeros(size(residual_frame, 1), 1);

% Iterate over each frame of the voice signal
for i = 1:size(residual_frame, 1)
    % Extract the current frame from the voice signal
    currentFrame = residual_frame(i, :);
    
    % Initialize the maximum similarity and index
    maxSimilarity = -inf;
    maxIndex = -1;
    
    % Compare the characteristics of the current frame to each noise vector in the codebook
    for j = 1:size(codebook, 1)
        % Measure the similarity between the current frame and the codebook vector
        similarity = dot(currentFrame, codebook(j, :)) / (norm(currentFrame) * norm(codebook(j, :)));
        
        % Check if the current similarity is larger than the maximum similarity
        if similarity > maxSimilarity
            maxSimilarity = similarity;
            maxIndex = j;
        end
    end
    
    % Store the index of the closest noise vector
    closestIndices(i) = maxIndex;
end










end
