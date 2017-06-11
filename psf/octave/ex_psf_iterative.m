%
% Example adjoint test
%
% Comparison with matrix transpose
%

% Load octave packages
pkg load image

% make sure we have a clean environment
clear
rand('state',0);
randn('state',0);

global n1 n2 psf

% Load the raw image in.
img=double(rgb2gray(imread("lena_rgb.png")));
[n1,n2]=size(img);

%psf = fspecial("gaussian",25,5);
psf = fspecial("motion",6,45);

% Add non-symmetric term
psf(1:3,4:6) -= 0.5*fspecial("gaussian",3,0.5);

blur = conv2(img,psf,SHAPE="same");

niter = 10;
%[X, FLAG, RELRES, ITER, rho] = bicg('psf_func',blur(:),1e-6,niter);
%[X, FLAG, RELRES, ITER, rho] = qmr('psf_func',blur(:),1e-6,niter);
%[X, FLAG, RELRES, ITER, rho] = bicgstab2('psf_func',blur(:),1e-6,niter);
%[X, FLAG, RELRES, ITER, rho] = gmres('psf_func',blur(:),5,1e-6,niter);
[X, FLAG, ITER, rho] = lsqr( n1*n2, n1*n2, 'psf_func', blur(:), niter);
%[X, FLAG, ITER, rho] = lsmr('psf_func', blur(:), niter, lambda=0., atol=1e-6, btol=1e-6, conlim=1e12, localSize=0, show=1);

rho = sqrt(rho); % lsmr & lsqr

X = reshape(X,n1,n2);

printf("Final residue norm=%d\n",rho(end))
printf("Final normalized residue norm=%d\n",rho(end)/rho(1))

figure(1)
imagesc(img)
colormap(gray);
title("Original Image")

figure(2)
imagesc(psf)
colormap(gray);
title("PSF")

figure(3)
imagesc(blur)
colormap(gray);
title("Blurred Image")

figure(4)
imagesc(X(:,:),[0 256])
colormap(gray);
title("Deblurred Image")

figure(5)
plot(rho/rho(1))
xlim ([0 niter])
title("Residue norm")