%
% Evaluating the condition number of blur matrix
%

N = 50;
k = 15;

nn = 11;
c = zeros(1,nn);
sigma = linspace(0.1,2.0,nn);
for i = 1:nn
  G=blur(N,k,sigma(i));
  c(i) = cond(G);
end

semilogy(sigma,c)