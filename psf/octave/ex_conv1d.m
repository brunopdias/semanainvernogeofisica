% Example: 1D Convolution

% Load octave packages
pkg load signal

% Make signals and convolve
a = mexihat(lb=-5., ub=15., n=100.);
b = zeros(1,100); b(50) = 1.;
c = conv(a,b);

% Plot figures
figure(1)
plot(a,";a;","linewidth",3,"color","blue")
title("a","fontsize",18)

figure(2)
plot(b,";b;","linewidth",3,"color","green")
title("b","fontsize",18)

figure(3)
plot(c,";c;","linewidth",3,"color","red")
title("c","fontsize",18)