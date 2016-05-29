%
% Plot objective function and reduction
%
[xx,yy] = meshgrid(lx,ly); fff = ff(xx,yy);
LW = 'linewidth'; FS = 'fontsize'; MS = 'markersize';
contour(lx,ly,fff,levels,LW,1.2), colorbar
title(strcat(sfun,":  ",sopt))
hold on
plot(pp(:,1),pp(:,2),'-x')
hold off
