function [STP , LTP, Residual ] = GetLPC(voiced , frame , frame_length)
Long_order = 6;
short_order = 9;
STP = zeros(short_order + 1,frame_length);
LTP = zeros(Long_order + 1, frame_length);
Residual_short = zeros(size(frame,1), frame_length);
Residual = zeros(size(frame,1), frame_length);


for i = 1 : frame_length
    STP(:, i) = (lpc(frame(:, i), short_order))';
    Residual_short(:, i) = filter(STP(:,i), 1, frame(:, i));
end
for i = 1 : frame_length
    if voiced(i) == 1
        LTP(:, i) = (lpc(frame(:, i), Long_order))';
    else
        LTP(:,i) = ones(1, Long_order+1);
    end
%         Residual(:, i) = filter(LTP(:, i), 1, Residual_short(:, i));
    
end
end
