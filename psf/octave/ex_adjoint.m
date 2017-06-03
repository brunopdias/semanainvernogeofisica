%
% Example adjoint test
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

%psf = fspecial("gaussian",9,1);
psf = fspecial("motion",6,45);

% Add non-symmetric term
psf(1:3,4:6) -= fspecial("gaussian",3,0.5);

psf_adj = fliplr(flipud(psf));

G = psf_to_matrix(N,psf);

img2 = reshape(G*img1(:),N,N);

img3 = conv2(img1,psf,SHAPE="same");

img4 = reshape(G'*img1(:),N,N);

img5 = conv2(img1,psf_adj,SHAPE="same");

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
title("Blurred Image (Convolution)")

figure(5)
imagesc(img3-img2)
colormap(gray);
title("Difference: Convolution - Matrix")
colorbar()

figure(6)
imagesc(psf_adj)
colormap(gray);
title("PSF Adjoint")

figure(7)
imagesc(img4)
colormap(gray);
title("Blurred Image (Matrix Adjoint)")

figure(8)
imagesc(img5)
colormap(gray);
title("Blurred Image (Convolution Adjoint)")

figure(9)
imagesc(img5-img4)
colormap(gray);
title("Difference Adjoint: Convolution - Matrix")
colorbar()

