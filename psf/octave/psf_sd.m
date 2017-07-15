% Steepest descent method
% https://en.wikipedia.org/wiki/Gradient_descent
%
% [X,rho,eta]=psf_sd(psf,img,niter)
%
% Performs niter iterations of the Steepest Descent method
% 
%   min (1/2)*(x'A*x - x'*b)
%
% The iterates 1, 2, ..., niter are returned in the columns of the
% matrix X.  For each iterate we also compute rho(i)=norm(G*m-d)
% and eta(i)=norm(m).
function [X,rho,eta]=psf_sd(psf,img,niter)
%
% Figure out problem size.
[n1,n2]=size(img);

% Setup space for the results.
X=zeros(n1,n2,niter);
rho=zeros(niter,1);
eta=zeros(niter,1);

% Setup for the first iteration.
x=zeros(n1,n2);

% Main loop: perform CGLS iterations.
for k=0:niter-1

  % Gradient
  r=img-conv2(x,psf,SHAPE="same");          %G'*s;
  rnorm = sum(r(:).*r(:));

  % multiplication repeatedly, we store A*r in Ar
  Ar=conv2(r,psf,SHAPE="same"); %A*r;
  
  % Step-lengh
  alpha=rnorm/sum(r(:).*Ar(:));

  % Update x.
  x=x+alpha*r;
  
  % Store the new iterate.
  X(:,:,k+1)=x;
  rho(k+1)=sqrt(norm(r(:)));
  eta(k+1)=sqrt(norm(x(:)));
end
