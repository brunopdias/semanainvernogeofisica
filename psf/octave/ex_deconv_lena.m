%
% Lena deconvolution
%

% Load octave packages
pkg load image

% make sure we have a clean environment
clear
rand('state',0);
randn('state',0);



% 1) Read image file
I=imread("lena_rgb.png");
G=double(rgb2gray(I));
figure(1)
im1=abs(G);
%imshow(0.2*G,gray)
imshow(32*im1/max(max(im1)),gray)
[n1,n2]=size(G)

% 2) Create PSF
x = linspace(-3,3,n1);
y = linspace(-3,3,n2);
[X Y] = meshgrid(x,y);
sigma=15;
psf = exp(-((X.^2)+(Y.^2))/(2./sigma^2));

figure(2)
imshow(psf)

% 3) Spectrum

Gkk=fft2(G);
psfkk=fft2(psf);

figure(3)
im=abs(fftshift(Gkk));
imshow(128000*im/max(max(im)),gray)

figure(4)
im=abs(fftshift(psfkk));
imshow(32*im/max(max(im)),gray)

% 4) Convolution

migkk=Gkk.*psfkk;

mig=fftshift(real(ifft2(migkk)));

figure(5)
imshow(32*mig/max(max(mig)),gray)

% 5) Deconvolution
%err 1
deconvkk=migkk.*conj(psfkk)./(psfkk.*conj(psfkk)+1e-3);
deconv=fftshift(real(ifft2(deconvkk)));
figure(6)
im=abs(fftshift(deconv));
imshow(32*im/max(max(im)),gray)

