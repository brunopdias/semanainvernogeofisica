%
% Lena deconvolution
%

% Load octave packages
pkg load image

% make sure we have a clean environment
clear

% 1) Read image file
img = double(rgb2gray(imread("lena_rgb.png")));
[n1,n2]=size(img);

figure(1)
imagesc(img);
colormap(gray);
title("Original Image","fontsize",18)

% 2) Create PSF
x = linspace(-3,3,n1);
y = linspace(-3,3,n2);
[X Y] = meshgrid(x,y);
sigma=15;
psf = exp(-((X.^2)+(Y.^2))/(2./sigma^2));

figure(2)
imagesc(psf);
colormap(gray);
title("Point Spread Function","fontsize",18)

% 3) Spectrum
imgkk=fft2(img);
psfkk=fft2(psf);

figure(3)
imgspec=abs(fftshift(imgkk));
imagesc(imgspec,[0, quantile(imgspec(:),0.99) ]);
colormap(jet);
title("Original Image Spectrum","fontsize",18)

figure(4)
psfspec=abs(fftshift(psfkk));
imagesc(psfspec);
colormap(jet);
title("Point Spread Function Spectrum","fontsize",18)

% 4) Convolution
convkk=imgkk.*psfkk;
conv=fftshift(real(ifft2(convkk)));

noise = .1;
conv(:,:) += noise*randn(n1,n2);

figure(5)
imagesc(conv);
colormap(gray);
t=sprintf("Convolution + Noise (n=%g)",noise);
title(t,"fontsize",18)

% 5) Deconvolution
convkk=fft2(conv);

eps2=1e-5;
deconvkk=convkk.*conj(psfkk)./(psfkk.*conj(psfkk)+eps2);
deconv=fftshift(real(ifft2(deconvkk)));

figure(6)
imagesc(deconv);
colormap(gray);
t=sprintf("Deconvolution: Deblurred Image (eps2=%g)",eps2);
title(t,"fontsize",18)


