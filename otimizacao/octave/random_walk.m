%
% Random walk optimization: run random_walk.oct
%
sopt="Random Walk Method"

clear pp
more on
x1(1) = input("Give the first component of initial point :");
x1(2) = input("Give the second component of initial point:");
lambda = input("Give the step length:");
minlam = input("Give the minimum allowable step length:");
N = input("Maximum number of iterations:");
i=1;
f1 = f(x1);
while(lambda > minlam)
  while(i<=N)
    pp(i,:) = x1(:);
    u = 2.*(0.5-rand(size(x1)));
    if(norm(u) > 1) u = zeros(size(x1));
    else
      u = u./norm(u);
    endif
    x = x1+lambda*u;
    f2 = f(x);
    if(f2>f1) i = i+1;
    else
      x1=x;
      f1 = f(x);
      i=i+1;
    endif
  endwhile
  lambda = 0.5*lambda;
endwhile
display("The optimum point is:"),disp(x1)
display("The optimum value is:"),disp(f(x1))
## fminsearch(@(x) x(1)-x(2)+ 2.*x(1)^2+ 2*x(1)*x(2) + x(2)^2 ,[-2,2])
## fminunc(@(x) x(1)-x(2)+ 2.*x(1)^2+ 2*x(1)*x(2) + x(2)^2 ,[-2,2])
