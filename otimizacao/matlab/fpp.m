function [J] = fpp(x,obf)

switch(obf)
    case 1
     J(1,1) = 4;
     J(1,2) = 2;
     J(2,1) = 2;
     J(2,2) = 2;
    case 2
     alpha=10.;
     J(1,1) = 2 -4.*alpha*(x(2)-x(1).^2)+8.*alpha*x(1).^2;
     J(1,2) = -4*alpha*x(1);
     J(2,1) = -4*alpha*x(1);
     J(2,2) = 2.*alpha;   
        
end