% Parameter Estimation and Inverse Problems, 2nd edition, 2011 
% by R. Aster, B. Borchers, C. Thurber
%
% [X,rho,eta]=cgls(G,d,niter)
%
% Performs niter iterations of the CGLS algorithm on the least
% squares problem
% 
%   min norm(G*m-d)
%
% The iterates 1, 2, ..., niter are returned in the columns of the
% matrix X.  For each iterate we also compute rho(i)=norm(G*m-d)
% and eta(i)=norm(m).
function [X,rho,eta]=psf_cgls(psf,img,niter,shift=0.)
%
psf_adj = fliplr(flipud(psf));

% Figure out problem size.
[n1,n2]=size(img);

% Setup space for the results.
X=zeros(n1,n2,niter);
rho=zeros(niter,1);
eta=zeros(niter,1);

% Setup for the first iteration.
m=zeros(n1,n2,1);
p=zeros(n1,n2,1);
beta=0;
s=img;
r=conv2(s,psf_adj,SHAPE="same");          %G'*s;

% Main loop- perform CGLS iterations.
for k=0:niter-1
  % We'll precompute r'*r since it's used in several places.
  rtr=sum(sum(r.*r));

  %  Update beta.
  if (k>0)
    beta=rtr/sum(sum(prevr.*prevr));
  end

  %  Update p
  p=r+beta*p;

  % Compute the new alpha.  To avoid doing the matrix vector
  % multiplication repeatedly, we store G*p in Gp
  Gp=conv2(p,psf,SHAPE="same"); %G*p;
  alpha=rtr/sum(sum(Gp.*Gp));

  % Update m.
  m=m+alpha*p;

  % Update s.
  s=s-alpha*Gp;

  % Save r for the next iteration, and then update it.
  prevr=r;
  r=conv2(s,psf_adj,SHAPE="same") + shift*m;

  % Store the new iterate.
  X(:,:,k+1)=m;
  rho(k+1)=sqrt(norm(s(:)));
  eta(k+1)=sqrt(norm(m(:)));
end
