clear, clc, close all;

% Read the grayscale image
image = imread('q3.png');

if length(size(image)) == 3
    image = rgb2gray(image);
end



% Define the filter coefficients of 4-tap daubechies filter
H0 =[0.03489, -0.010983, -0.06286, 0.223907, 0.55686,...
    0.357976, -0.0239002, -0.0759409];
H1 = [-0.0759409, 0.0239002, 0.357976, -0.55686, -0.223907,...
    0.06286, 0.010983, -0.03489];



% padded_image = padarray(image, [length(H0)-1, length(H0)-1], 'symmetric');


low_filtered_image = image;
high_filtered_image = image;



num_stages = 4;
row_flag = 1;

for i = 1 : num_stages
     low_filtered_image = floor(conv2(low_filtered_image, H0, 'same'));
     high_filtered_image = floor(conv2(low_filtered_image, H1, 'same'));

     
%      low_filtered_image = round(filter(H0, 1, low_filtered_image));
%      high_filtered_image = round(filter(H1, 1, high_filtered_image));


    if row_flag == 1
        low_filtered_image =downsample(low_filtered_image.', 2).';
        high_filtered_image =downsample(high_filtered_image.', 2).';

        row_flag = 0;
    else
        low_filtered_image =downsample(low_filtered_image, 2);
        high_filtered_image =downsample(high_filtered_image, 2);

        row_flag = 1;
    end
%     padded_image = filtered_image;
    
end

% low_freq_image = uint8(low_filtered_image(length(H0):end-length(H0)+1, length(H0):end-length(H0)+1));
% high_freq_image = uint8(low_filtered_image(length(H0):end-length(H0)+1, length(H0):end-length(H0)+1));

low_freq_image = uint8(low_filtered_image);
high_freq_image = uint8(high_filtered_image);

% Display the original and filtered images
figure;
subplot(3, 1, 1);
imshow(image);
title('Original Image');
subplot(3, 1, 2);
imshow(low_freq_image);
title('compressed image low freq');

subplot(3, 1, 3);
imshow(high_freq_image);
title('compressed image high freq');