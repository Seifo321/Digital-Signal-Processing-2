clear, clc, close all;

% Read and convert image to grayscale
image = imread('image.jpeg');
image = rgb2gray(image);

% Get the size of the original image
[height, width] = size(image);

% Define block size and pad image
block_size = 8;

% Calculate the remainder of the width and height when divided by 8
width_remainder = mod(width, block_size);
height_remainder = mod(height, block_size);

% Calculate the amount of padding needed
width_padding = block_size - width_remainder;
height_padding = block_size - height_remainder;

% Create a new image with the new dimensions
new_width = width + width_padding;
new_height = height + height_padding;
new_image = zeros(new_height, new_width, 'uint8');

% Copy the original image into the new image
new_image(1:height, 1:width) = image;

% Pad the new image with zeros
new_image(height+1:end, :) = 0;
new_image(:, width+1:end) = 0;

% Divide image into blocks
rows = floor(size(new_image, 1) / block_size);
cols = floor(size(new_image, 2) / block_size);

% Split image into 8x8 blocks
image_blocks = zeros(block_size, block_size, (rows * cols));
temp = 1;% counter
for i = 1:rows
    for j = 1:cols
        block = new_image((i-1)*block_size+1:i*block_size, (j-1)*block_size+1:j*block_size);
        image_blocks(:,:,temp) = block;
        temp = temp + 1;
    end
end

% Calculate mean of each block and sort
block_means = squeeze(mean(mean(image_blocks, 1), 2));
[~, sorted_indices] = sort(block_means);
image_blocks = image_blocks(:, :, sorted_indices);

% Initialize codebooks
codebook_sizes = [32 64 128 256];

% Create a single figure for all images
figure;

% Display original image
subplot(3, 2, 1);
imshow(new_image);
title('Original');

for idx = 1:length(codebook_sizes)
    % Compression
    codebook_size = codebook_sizes(idx);
    region_range = 256 / codebook_size;
    codebook = zeros(block_size, block_size, codebook_size);
    voronoi_regions = 0:region_range:256;
    
    iterations = 5;
    num_blocks = zeros(1, codebook_size);
    temp = 0;
    for iter = 1:iterations
        start = 1;
        for i = 1:codebook_size
            block_sum = 0;
            block_count = 0;
            for j = start:length(image_blocks)
                mean_val = mean2(image_blocks(:,:,j));
                temp = temp + 1;
                if (mean_val >= voronoi_regions(i) && mean_val < voronoi_regions(i+1))
                    block_sum = block_sum + image_blocks(:,:,j);
                    block_count = block_count + 1;
                else
                    break
                end
            end
            num_blocks(i) = block_count;
            start = start + block_count;
            if block_count == 0
                if i == 1
                    codebook(:,:,i) = zeros(8, 8);
                else
                    codebook(:,:,i) = codebook(:,:,i-1);
                end
            else
                codebook(:,:,i) = floor(block_sum / block_count);
            end
        end
        for i = 2:length(voronoi_regions) - 1
            voronoi_regions(i) = (mean2(codebook(:,:,i-1)) + mean2(codebook(:,:,i))) / 2;
        end
    end
    
    % Extraction
    reconstructed_image = zeros(rows * block_size, cols * block_size);
    num_codebooks = length(codebook);
    m = 1;
    y = num_blocks(1);
    for i = 1:num_codebooks
        for j = m:y
            x = sorted_indices(m);
            r = ceil(x / cols);
            c = x - cols * (r - 1);
            reconstructed_image((r-1)*block_size+1:r*block_size, ...
(c-1)*block_size+1:c*block_size) = codebook(:,:,i);
            m = m + 1;
        end
        if i ~= num_codebooks && i+1 <= length(num_blocks)
            y = y + num_blocks(i + 1);
        end
    end
    reconstructed_image = uint8(reconstructed_image);
    
    % Display quantized image
    subplot(3, 2, idx + 1);
    imshow(reconstructed_image);
    title(['Quantized Image (K=' num2str(codebook_size) ')']);
end