function x1 = backtrack(x0,S,ss0,epsilon)
  ss = ss0;                         % initial step
  while(ss > epsilon)               % step limit
    x1 = x0+ss*S;
    while ( f(x1) < f(x0) )         % descent condition
      x0 = x1;
      x1 = x0+ss*S;
    endwhile
    ss = 0.5*ss;
  endwhile
  x1 = x0;
end

%function x1 = backtrack(x0,S,ss0,epsilon)
%   ss = ss0;                 % initial step-length
%   x1 = x0;             % model update
%   while(ss > epsilon)       % minimum step
%     x0 = x1;                % model update
%     x1 = x0+ss*S;
%     if ( f(x1) < f(x0) )    % objective function reduction
%       break;  
%     endif
%     ss = 0.5*ss;
%   endwhile
% end
