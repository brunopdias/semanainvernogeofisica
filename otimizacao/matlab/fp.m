function [yp] = fp(x,obf)

switch(obf)
    case 1
     yp(1) = 1.0 +2*x(2) + 4*x(1);
     yp(2) = -1.0 + 2*x(1) + 2*x(2);
    
    case 2
     alpha=10.;
     yp(1) = -2*(1-x(1)) -4*alpha*x(1)*(x(2)-x(1).^2);
     yp(2) = 2*alpha*(x(2)-x(1).^2);
end