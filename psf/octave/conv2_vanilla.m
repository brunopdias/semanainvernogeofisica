## Copyright (C) 2017 Bruno

## -*- texinfo -*- 
## @deftypefn {Function File} {@var{retval} =} conv_vanilla (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: Bruno 
## Created: 2017-06-04

function out = conv2_vanilla (A, B, ADJ = false)

[n1, n2] = size(A);
[m1, m2] = size(B);

if ( ( mod(m1,2) == 0 ) ||  ( mod(m2,2) == 0 ) )
  error("expecting odd size psf")
end

p = [(m1-1)/2, (m2-1)/2];

if ADJ

  A = padarray(A,p);
  out = zeros(n1, n2);

  for j = 1:n2
  for i = 1:n1
    r = 0.;
    for l = 1:m2
    for k = 1:m1
      r += A(i+k-1,j+l-1)*B(k,l);
    end
    end
    out(i,j) = r;
  end
  end

else

  out = zeros(n1+m1-1, n2+m2-1);

  for j = 1:n2
  for i = 1:n1
    r = A(i,j);
    for l = 1:m2
    for k = 1:m1
      out(i+k-1,j+l-1) += r*B(k,l);
    end
    end
  end
  end
  
  out = out((p(1)+1):(end-p(1)), (p(2)+1):(end-p(2)));
end
  
endfunction
