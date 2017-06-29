%
% Example of matrix blurr and deblur
%

% Load octave packages
pkg load image

% make sure we have a clean environment
clear
rand('state',0);
randn('state',0);

% Load the raw image in.
img=double(rgb2gray(imread("lena_rgb.png")));

% Resize to make computional feasible
img1 = img(1:4:end,1:4:end);

N=size(img1,1);

psf = fspecial("gaussian",9,1);
%psf = fspecial("motion",6,45);

% Add non-symmetric term
%psf(1:3,4:6) -= fspecial("gaussian",3,0.5);

psf_adj = fliplr(flipud(psf));

G = psf_to_matrix(N,psf);

img2 = reshape(G*img1(:),N,N);

noise=0; %2.0e-2;
img2 += noise*randn(N);

img3 = reshape(img2(:)'/G,N,N);

figure(1)
imagesc(img)
colormap(gray);
title("Original Image")

figure(2)
imagesc(psf)
colormap(gray);
title("PSF")

figure(3)
imagesc(img2)
colormap(gray);
title("Blurred Image (Matrix)")

figure(4)
imagesc(img3)
colormap(gray);
title("Deblurred Image")
