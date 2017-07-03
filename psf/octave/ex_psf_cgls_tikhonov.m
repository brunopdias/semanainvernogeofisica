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

[n1,n2] = size(img);

psf = fspecial("gaussian",35,9);
%psf = fspecial("motion",6,45);

% Add non-symmetric term
%psf(1:3,4:6) -= 0.5*fspecial("gaussian",3,0.5);

blur = conv2(img,psf,SHAPE="same");

noise = 10;
blur += noise*rand(n1,n2);
%imnoise(blur, "poisson");

niter = 50;

fig=1
for lambda=[0. 1e-4 1e-3 1e-2 1e-1 5e-1]
  [X,rho,eta]=psf_cgls(psf,blur,niter,lambda);

  printf("Final residue norm=%d\n",rho(end))
  printf("Final model norm=%d\n",rho(end))
  
  figure(fig++)
  imagesc(X(:,:,niter),[0 256])
  colormap(gray);
  t=sprintf("Deblurred Image: Iteration %d Lambda=%g",niter,lambda);
  title(t,"fontsize",18)
end
