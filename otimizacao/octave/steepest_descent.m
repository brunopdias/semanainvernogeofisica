%
% Steepest descent method: run steepest-descent.oct
%
sopt="Steepest-Descent Method"
epsilon = 1.0e-6;               % gradient min val
nit = 1e3;                      % number of iterations

clear pp
more on
x0(1) = input("Give the starting point: first component:");
x0(2) = input("Give the starting point: second component:");
i=1;
while( (norm(fp(x0)) > epsilon) && (i < nit))     % gradient norm limit
  pp(i,:) = x0(:);
  S = -fp(x0);                  % steepest-descent
  ss = 0.01;                    % initial step-length
  x1 = x0+ss*S;                 % model update
  while(ss > epsilon)            % minimum step
    while( ( f(x1) < f(x0) ) )  % objective function reduction
      x0 = x1;                  % model update
      x1 = x0+ss*S;
    endwhile
    x0 = x0-ss*S;
    ss = 0.5*ss;                % stepsize reduction
  endwhile
  x0=x1;
  i=i+1;
endwhile
disp("Number of iterations:"),disp(i)
disp("Solution:"),disp(x0)
disp("Function value:"),disp(f(x0))
disp("Norm of fprime:"),disp(norm(fp(x0)))
