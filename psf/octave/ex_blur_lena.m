% Example 6.3
% from Parameter Estimation and Inverse Problems, 2nd edition, 2011
% by R. Aster, B. Borchers, C. Thurber

% Load octave packages
pkg load image

% make sure we have a clean environment
clear
rand('state',0);
randn('state',0);

% Load the raw image in.
img=double(rgb2gray(imread("lena_rgb.png")));

% Resize to make computional feasible
img = img(1:4:end,1:4:end);

N=size(img,1);

% Build the G matrix.
display('Build the G matrix')
G=blur(N,3,15);

% Compute the blurred image.
d=G*reshape(img,N*N,1);

% Add noise as appropriate.
dn=d+2.0e-2*randn(size(d));

% Use CGLS (with no explicit regularization) to deblur.
display('Use CGLS')
nit=200
[X,rho,eta]=cgls(G,dn,nit);

% Plots with no explicit regulariztion.

% Plot raw image
figure(1)
clf
imagesc(img);
colormap(gray);
H=gca;
set(H,'XTick',[]);
set(H,'YTick',[]);
title("Raw Image")
display('Displaying raw image (fig. 1)')

% Plot blurred image with noise
figure(2);
clf;
imagesc(reshape(dn,N,N));
colormap(gray);
H=gca;
set(H,'XTick',[]);
set(H,'YTick',[]);
title("Blurred Image")
display('Displaying blurred image with noise (fig. 2)')
print -deps lenablur.eps

% Plot CGLS solution with 30 iterations 
figure(3)
clf;
imagesc(reshape(X(:,30),N,N));
colormap(gray);
H=gca;
set(H,'XTick',[]);
set(H,'YTick',[]);
title("CGLS solution after 30 iterations")
display('Displaying CGLS solution after 30 iterations (fig. 3)')
print -deps lenablur30.eps

% Plot CGLS solution with 100 iterations 
figure(4)
clf;
imagesc(reshape(X(:,100),N,N));
colormap(gray);
H=gca;
set(H,'XTick',[]);
set(H,'YTick',[]);
title("CGLS solution after 100 iterations")
display('Displaying CGLS solution after 100 iterations (fig. 4)')
print -deps lenablur100.eps

% Plot of model norm vs. residual norm for CGLS solution
figure(5)
clf;
loglog(rho(1:N),eta(1:N),'ko');
xlabel('|| Gm-d ||');
ylabel('|| m ||');
title("Model norm vs. residual norm")
display('Displaying model norm vs. residual norm for CGLS solution (fig. 5)')

