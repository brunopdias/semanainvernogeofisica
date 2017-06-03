%
% M=blurker(k,sigma)
%
% produces a 2*k-1 by 2*k-1 matrix containing the kernel of a
% Gaussian blur with 
%
%   M(i,j)=(1/(2*pi*sigma^2))*exp(-((i-k)^2+(j-k)^2)/(2*sigma^2))
%
function M=blurker(k,sigma)
M=zeros(2*k-1,2*k-1);
for i=1:(2*k-1)
  for j=1:(2*k-1)
    M(i,j)=(1/(2*pi*sigma^2))*exp(-((i-k)^2+(j-k)^2)/(2*sigma^2));
  end
end