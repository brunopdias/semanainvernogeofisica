%
% Marquardt method: run marquardt.oct
%
sopt='Marquardt Method';
epsilon = 1.0e-6;
nit = 1e3;
alpha1 = 1;

clear pp
more on
x0(1) = input('Give the starting point: first component:');
x0(2) = input('Give the starting point: second component:');
i=1;

disp('Choose Objective function:')
obf = input('1-> Quadratic; 2-> Rosenbrock:');

JJ = fpp(x0,obf);
f0 = f(x0,obf);
while((norm(fp(x0,obf)) > epsilon) && (i < nit))
  pp(i,:) = x0(:);
  S = -(inv(JJ+alpha1*eye(size(JJ)))*fp(x0,obf)')';
  ss = 0.01;
  x1 = x0+ss*S;
  f1 = f(x1,obf);
  while(ss > epsilon)
    while( (f(x0,obf) - f(x1,obf)) > 0)
      x0 = x1;
      x1 = x0+ss*S;
    end
    x0 = x0-ss*S;
    ss = 0.5*ss;
  end
  x0=x1;
  i=i+1;
end
disp('Number of iterations:'),disp(i)
disp('Solution:'),disp(x0)
disp('Function value:'),disp(f(x0,obf))
disp('Norm of fprime:'),disp(norm(fp(x0,obf)))
