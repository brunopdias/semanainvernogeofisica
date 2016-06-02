%
% Steepest descent method: run steepest-descent.oct
%
sopt='Steepest-Descent Method'
epsilon = 1.0e-6;               % gradient min val
nit = 1e3;                      % number of iterations

clear pp
more on
x0(1) = input('Give the starting point: first component:');
x0(2) = input('Give the starting point: second component:');
i=1;

disp('Choose Objective function:')
obf = input('1-> Quadratic; 2-> Rosenbrock:');

while( (norm(fp(x0,obf)) > epsilon) && (i < nit))     % gradient norm limit
  pp(i,:) = x0(:);
  S = -fp(x0,obf);                  % steepest-descent
  ss = 0.01;                    % initial step-length
  x1 = x0+ss*S;                 % model update
  while(ss > epsilon)            % minimum step
    while( ( f(x1,obf) < f(x0,obf) ) )  % objective function reduction
      x0 = x1;                  % model update
      x1 = x0+ss*S;
    end
    x0 = x0-ss*S;
    ss = 0.5*ss;                % stepsize reduction
  end
  x0=x1;
  i=i+1;
end
disp('Number of iterations:'),disp(i)
disp('Solution:'),disp(x0)
disp('Function value:'),disp(f(x0,obf))
disp('Norm of fprime:'),disp(norm(fp(x0,obf)))
