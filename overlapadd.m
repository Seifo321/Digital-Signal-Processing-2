function y = overlapadd(y_framed, window, hop_size)
% OVERLAPADD Overlap-add synthesis of framed signal
%
%   Y = OVERLAPADD(Y_FRAMED, WINDOW, HOP_SIZE) synthesizes a signal from
%   a framed signal Y_FRAMED using the overlap-add method with a window
%   of length WINDOW and a hop size of HOP_SIZE. The length of WINDOW must
%   be equal to the number of samples in each frame of Y_FRAMED, and HOP_SIZE
%   must be less than or equal to the length of WINDOW.
%
%   The output Y has the same length as the original non-framed signal.

    num_frames = size(y_framed, 2);
    frame_len = size(y_framed, 1);
    y_len = (num_frames-1)*hop_size + frame_len;
    y = zeros(y_len, 1);
    for i = 1:num_frames
        start_idx = (i-1)*hop_size + 1;
        end_idx = start_idx + frame_len - 1;
        y(start_idx:end_idx) = y(start_idx:end_idx) + y_framed(:,i);
    end
    y = y ./ repmat(window, 1, y_len)';
end
