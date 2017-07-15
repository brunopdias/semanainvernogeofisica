%
% Example adjoint test
%
% Comparison with matrix transpose
%

% Load octave packages
pkg load image

% make sure we have a clean environment
clear

% Load the raw image in.
img=double(rgb2gray(imread("lena_rgb.png")));

psf = fspecial("gaussian",25,5);
%psf = fspecial("motion",6,45);

% Add non-symmetric term
%psf(1:3,4:6) -= 0.5*fspecial("gaussian",3,0.5);

blur = conv2(img,psf,SHAPE="same");

niter = 10;
[X,rho,eta]=psf_cgls(psf,blur,niter);
%[X,rho,eta]=psf_cg(psf,blur,niter);
%[X,rho,eta]=psf_sd(psf,blur,niter);

printf("Final residue norm=%d\n",rho(end))
printf("Final normalized residue norm=%d\n",rho(end)/rho(1))

figure(1)
imagesc(img)
colormap(gray);
title("Original Image","fontsize",18)

figure(2)
imagesc(psf)
colormap(gray);
title("PSF","fontsize",18)

figure(3)
imagesc(blur)
colormap(gray);
title("Blurred Image","fontsize",18)

figure(4)
imagesc(X(:,:,niter),[0 256])
colormap(gray);
title("Deblurred Image","fontsize",18)

figure(5)
plot(rho/rho(1),"-o","linewidth",3,"color","black")
xlim ([1 niter])
title("Residue norm","fontsize",18)

figure(6)
plot(eta/eta(1),"-o","linewidth",3,"color","black")
xlim ([1 niter])
title("Model norm","fontsize",18)