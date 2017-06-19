% Example: 1D Convolution

% Load octave packages
pkg load image

% Load the original image in and convert to grayscale.
img=double(rgb2gray(imread("lena_rgb.png")));

psf = fspecial("gaussian",25,5);
%psf = fspecial("motion",6,45);
%psf(1:3,4:6) -= 0.5*fspecial("gaussian",3,0.5); % Non-symmetric term

% 2D Convolution
blur = conv2(img,psf,SHAPE="same");

% Plot figures
figure(1)
clf
imagesc(img);
colormap(gray);
H=gca;
set(H,'XTick',[]);
set(H,'YTick',[]);
title("Original Image","fontsize",18)

figure(2)
clf
imagesc(psf);
colormap(gray);
H=gca;
set(H,'XTick',[]);
set(H,'YTick',[]);
title("Point Spread Function","fontsize",18)

figure(3)
clf
imagesc(blur);
colormap(gray);
H=gca;
set(H,'XTick',[]);
set(H,'YTick',[]);
title("Blurred Image","fontsize",18)

