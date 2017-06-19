% Conjugate gradient method
% https://en.wikipedia.org/wiki/Conjugate_gradient_method
%
% [X,rho,eta]=psf_cg(psf,img,niter)
%
% Performs niter iterations of the Conjugate Gradient algorithm
% 
%   min (1/2)*(x'A*x - x'*b)
%
% The iterates 1, 2, ..., niter are returned in the columns of the
% matrix X.  For each iterate we also compute rho(i)=norm(G*m-d)
% and eta(i)=norm(m).
function [X,rho,eta]=psf_cg(psf,img,niter)
%
% Figure out problem size.
[n1,n2]=size(img);

% Setup space for the results.
X=zeros(n1,n2,niter);
rho=zeros(niter,1);
eta=zeros(niter,1);

% Setup for the first iteration.
x=zeros(n1,n2);
beta=0;
r=img-conv2(x,psf,SHAPE="same");          %G'*s;
p=r;

rsold = sum(sum(r.*r));

% Main loop: perform CGLS iterations.
for k=0:niter-1

  % multiplication repeatedly, we store A*p in Ap
  Ap=conv2(p,psf,SHAPE="same"); %A*p;
  
  alpha=rsold/sum(sum(p.*Ap));

  % Update x.
  x=x+alpha*p;

  % Update r.
  r=r-alpha*Ap;

  rsnew = sum(sum(r.*r));
  
  % Save r for the next iteration, and then update it.
  p = r + (rsnew / rsold) * p;
  rsold = rsnew;
  
  % Store the new iterate.
  X(:,:,k+1)=x;
  rho(k+1)=sqrt(norm(rsnew(:)));
  eta(k+1)=sqrt(norm(x(:)));
end
