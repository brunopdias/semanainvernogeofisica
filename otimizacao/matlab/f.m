function [y] = f(x,obf)

switch(obf)
    case 1 % Quadratic function
      y = x(1)-x(2) + 2*x(1)^2 + 2*x(1)*x(2) + x(2)^2;

    case 2 % Rosenbrock function
    alpha=10.;
      y = (1-x(1)).^2 + alpha*(x(2)-x(1).^2).^2;
end