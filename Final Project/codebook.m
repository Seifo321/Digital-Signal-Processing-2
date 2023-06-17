 function noise_vectors = codebook(params)
   % Number of noise vectors in the codebook
    numVectors = 1024;

    % Length of each noise vector
    vectorLength = params.frame_length;

    % Generate random noise vectors and normalize them
    noise_vectors = randn(numVectors, vectorLength);
end
