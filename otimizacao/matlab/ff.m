function [yff] = ff(x,y,obf)

switch(obf)
    case 1 % Quadratic function
                
        yff = x - y + 2*x^2 + 2*x*y + y^2;

    case 2 % Rosenbrock function
                
        alpha=10.;        
        yff = (1.-x).^2. + alpha*(y-x.^2).^2;
      
end