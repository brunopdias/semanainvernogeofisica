%
% Monte-Carlo random search: run monte_carlo.m
%
sopt="Monte-Carlo Method"

clear pp
more on
N = input("Maximum number of iterations: ");
i=1;

n1=size(lx);
n2=size(ly);

x0 = [lx(randi(n1)) ly(randi(n2))];
pp(i,:) = x0(:);

disp("The initial point is:"),disp(x0)

for j=1:N
  x1 = [lx(randi(n1)) ly(randi(n2))];
  if(  f(x1) < f(x0) )
    x0 = x1;
    pp(i,:) = x0(:);
    i = i+1;
  endif
endfor

disp("Number of updates: "),disp(i)
disp("The optimum point is:"),disp(x0)
disp("The optimum value is:"),disp(f(x0))

