%
% Plot objective function and reduction
%

switch(obf)
    case 1 % Quadratic function
        sfun='Quadratic function';
        levels = 260:0.4:280;
        lx=linspace(-2,2);
        ly=linspace(-2,2);
    case 2  % Rosenbrock function
        sfun='Rosenbrock function';
        levels = [1:4 5:5:100];
        lx=linspace(-1.5,1.5);
        ly=linspace(-1,3); 
end

[xx,yy] = meshgrid(lx,ly); fff = ff(xx,yy,obf);
LW = 'linewidth'; FS = 'fontsize'; MS = 'markersize';
contour(lx,ly,fff,levels,LW,1.2), colorbar
title(strcat(sfun,':  ',sopt))
hold on
plot(pp(:,1),pp(:,2),'-x')
hold off
