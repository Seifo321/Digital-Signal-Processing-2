clear , clc, close all;

 I = imread('q3.png');
 if size(I, 3) == 3 
     I = rgb2gray(I);
 end
 D0 = 100;
 % 1st Stage
 
 [L, H] = subHL(I,D0);
 
 % 2nd Stage
 
 [LL,LH] = subHL(L,D0);
 [HL,HH] = subHL(H,D0);
  
 % vizualization
 
 subplot(4,3,4);imshow(I);title('Original image');
 subplot(4,3,5);imshow(L);title('1st stage low-pass filter d=100');
 subplot(4,3,8);imshow(H);title('1st stage high-pass filter d=100');
 subplot(4,3,3);imshow(LL);title('LL');
 subplot(4,3,6);imshow(LH);title('LH');
 subplot(4,3,9);imshow(HL);title('HL');
 subplot(4,3,12);imshow(HH);title('HH');


