%
% Steepest descent method: run steepest-descent.oct
%
sopt="Steepest-Descent Method"
epsilon = 1e-6;               % gradient min val
ss0=0.1;
nit = 1000;                   % number of iterations

clear pp
more on
x0(1) = input("Give the starting point: first component: ");
x0(2) = input("Give the starting point: second component: ");
i=1;
pp(i,:) = x0(:);
while( (norm(fp(x0)) > epsilon) && (i < nit))     % gradient norm limit
  S = -fp(x0);                  % steepest-descent
  x0 = backtrack(x0,S,ss0,epsilon);
  i=i+1;
  pp(i,:) = x0(:);
endwhile
disp("Number of iterations:"),disp(i)
disp("Solution:"),disp(x0)
disp("Function value:"),disp(f(x0))
disp("Norm of fprime:"),disp(norm(fp(x0)))
