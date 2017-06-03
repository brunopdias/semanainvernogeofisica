%
% G=blur(N,k,sigma)
%
% Computes a matrix G such that G*m is blurred version of m, where
% m is an N by N image reshaped into vector form with
% reshape(image,N*N,1)
%
% The point spread function of the blurring operation is a
% truncated Gaussian bump, of size 2*k-1 by 2*k-1 pixels, given by 
%
%   M(i,j)=(1/(2*pi*sigma^2))*exp(-((i-k)^2+(j-k)^2)/(2*sigma^2))
%   
function G=psf_to_matrix(N,M)

if ( size(M,1) != size(M,2) )
  error("expecting square size psf")
end

if ( mod(size(M,1),2) == 0 )
  error("expecting odd size psf")
end

% Get the point spread function.
k = (size(M,1)-1)/2+1;

% Fill in columns of G.  Start with a zero G matrix.
G=sparse(N*N,N*N);

%  Make a working image with a border around the edges.  Will put M
%  in here in the appropriate space, and then cut away the border
%  to get the image of the PSF kernel within the frame of our image.
%
zeroimg=sparse(N+2*k-2,N+2*k-2);
l=0;
for j=1:N
  for i=1:N
    %reset the image we are working with
    img=zeroimg;

    % Put the blur kernel into img
    img(i:i+2*k-2,j:j+2*k-2)=M;

    % Cut away the border.
    img2=img(k:end-k+1,k:end-k+1);

    % put this into column l of G.
    l=l+1;
    G(:,l)=reshape(img2,N*N,1);
  end
end
