%
% Marquardt method: run marquardt.oct
%
sopt="Marquardt Method";
epsilon = 1.0e-6;
nit = 1e3;
alpha1 = 1;

clear pp
more on
x0(1) = input("Give the starting point: first component:");
x0(2) = input("Give the starting point: second component:");
i=1;

JJ = fpp(x0);
f0 = f(x0);
while((norm(fp(x0)) > epsilon) && (i < nit))
  pp(i,:) = x0(:);
  S = -(inv(JJ+alpha1*eye(size(JJ)))*fp(x0)')';
  ss = 0.01;
  x1 = x0+ss*S;
  f1 = f(x1);
  while(ss > epsilon)
    while( (f(x0) - f(x1)) > 0)
      x0 = x1;
      x1 = x0+ss*S;
    endwhile
    x0 = x0-ss*S;
    ss = 0.5*ss;
  endwhile
  x0=x1;
  i=i+1;
endwhile
disp("Number of iterations:"),disp(i)
disp("Solution:"),disp(x0)
disp("Function value:"),disp(f(x0))
disp("Norm of fprime:"),disp(norm(fp(x0)))
