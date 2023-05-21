clear, clc, close all ;

image = imread('q3.png');

if size(image, 3) == 3 
    image = rgb2gray(image);
end

[r, c] = size(image);

H0 = [1, 0.5, 0.2, -0.1];  % low-pass filter coefficients
N = length(H0);
for i = 1 : length(H0)
    
    H1(i) = -1.^(i).*H0(i);      % high-pass filter coefficients
end



low_freq_image = round(filter(H0, 1, image));
high_freq_image = round(filter(H1,1, image));


% downsampling
low_freq_image = low_freq_image(1:2:end, 1:2:end);

high_freq_image = high_freq_image(1:2:end, 1:2:end);

figure;

subplot(311); imshow(image); title('Original image')

subplot(312); imshow(low_freq_image); title('L')


subplot(313); imshow(high_freq_image); title('H')









