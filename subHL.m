function [low, high] = subHL(image,d0)
[M ,N]=size(image);

img_f = fft2(double(image));% Fourier transform to get the spectrum
img_f=fftshift(img_f);% move to the middle

m_mid=floor(M/2);% center point coordinates
n_mid=floor(N/2);  

 L = zeros(M,N);% Gaussian low-pass filter construction
 H = L;
for i = 1:M
    for j = 1:N
        d = ((i-m_mid)^2+(j-n_mid)^2);
        L(i,j) = exp(-d/(2*(d0^2)));
        H(i,j) = 1-exp(-d/(2*(d0^2)));
    end
end

img_lpf = L.*img_f;
img_hpf = H.*img_f;
img_lpf=ifftshift(img_lpf);% center shift back to the original state
img_lpf=uint8(real(ifft2(img_lpf)));% inverse Fourier transform


img_hpf=ifftshift(img_hpf);% center shift back to the original state
img_hpf=uint8(real(ifft2(img_hpf)));% inverse Fourier transform

 
 %% downsampling
 low = img_lpf(1:2:end,1:2:end);
 high = img_hpf(1:2:end,1:2:end);
end
 
 
 