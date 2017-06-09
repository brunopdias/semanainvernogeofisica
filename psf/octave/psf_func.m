## Copyright (C) 2017 Bruno
## 
## This program is free software; you can redistribute it and/or modify it
## under the terms of the GNU General Public License as published by
## the Free Software Foundation; either version 3 of the License, or
## (at your option) any later version.
## 
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
## 
## You should have received a copy of the GNU General Public License
## along with this program.  If not, see <http://www.gnu.org/licenses/>.

## -*- texinfo -*- 
## @deftypefn {Function File} {@var{retval} =} psf_func (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: Bruno <bruno@marilia-Galago-UltraPro>
## Created: 2017-06-09

function y = psf_func(x, adj="notransp")
  global n1 n2 psf
  
  xx = reshape(x,n1,n2);

  if ( strcmp(adj,"transp") )
    psf_adj = fliplr(flipud(psf));
    blur = conv2(xx,psf_adj,SHAPE="same");
  else
    blur = conv2(xx,psf,SHAPE="same");
  end

   y = reshape(blur,n1*n2,1);

endfunction
