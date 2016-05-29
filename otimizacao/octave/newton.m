%
% Newton's method: run newton.oct
%
sopt="Newton Method"
epsilon = 1.0e-6;
nit = 1e3;

clear pp
more on
x0(1) = input("Give the starting point: first component:");
x0(2) = input("Give the starting point: second component:");
i=1;
JJ = inv(fpp(x0));
while((norm(fp(x0)) > epsilon) && (i < nit))
  pp(i,:) = x0(:);
  S = -(JJ*fp(x0)')';
  ss = 0.01;
  x1 = x0+ss*S;
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
