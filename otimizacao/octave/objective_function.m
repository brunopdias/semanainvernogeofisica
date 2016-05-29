%
% Objective function
%
disp("Choose Objective function:")
obf = input("1-> Quadratic; 2-> Rosenbrock:");
switch (obf)
  case 1
    % Quadratic function
    sfun='Quadratic function';
    lx=linspace(-2,2);
    ly=linspace(-2,2);
    levels = 260:0.4:280;

    ff = @(x,y) x - y + 2*x^2 + 2*x*y + y^2;

    function y = f(x)
      y = x(1)-x(2) + 2*x(1)^2 + 2*x(1)*x(2)+x(2)^2;
    endfunction

    function yp = fp(x)
     yp(1) = 1.0 +2*x(2) + 4*x(1);
     yp(2) = -1.0 + 2*x(1) + 2*x(2);
    endfunction

    function J = fpp(x)
       J(1,1) = 4;
       J(1,2) = 2;
       J(2,1) = 2;
       J(2,2) = 2;
    endfunction
  case 2
    % Rosenbrock function
    sfun='Rosenbrock function';
    lx=linspace(-1.5,1.5);
    ly=linspace(-1,3);
    levels = [1:4 5:5:100];

    alpha=10.;

    ff = @(x,y) (1.-x).^2. + alpha*(y-x.^2).^2;

    function y = f(x)
      alpha=10.;
      y = (1-x(1)).^2 + alpha*(x(2)-x(1).^2).^2;
    endfunction

    function yp = fp(x)
      alpha=10.;
      yp(1) = -2*(1-x(1)) -4*alpha*x(1)*(x(2)-x(1).^2);
      yp(2) = 2*alpha*(x(2)-x(1).^2);
    endfunction

    function J = fpp(x)
      alpha=10.;
      J(1,1) = 2 -4.*alpha*(x(2)-x(1).^2)+8.*alpha*x(1).^2;
      J(1,2) = -4*alpha*x(1);
      J(2,1) = -4*alpha*x(1);
      J(2,2) = 2.*alpha;
    endfunction
  otherwise
    disp("Option not known!")
endswitch
