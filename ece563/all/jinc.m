function f = jinc(r)
%
% f = jinc(r)
%
% The 'jinc' function
%
%  jinc(r) = J_1(pi r) / (2r)
%
%  where J_1 is the Bessel function of the first kind, order 1.
%  Note that  CSFT( circ(x,y) ) = jinc2( u, v ) = jinc( sqrt(u.^2 + v.^2 ) )
%  where circ is a disk of diameter 1.
%
% REQUIRED INPUTS
%  r  array of values to evaluate (usually an array of radii in
%  2D continuous space frequency domain)
%
% OUTPUTS
%  f  jinc function value for each r
%
% Author: Russell Hardie
% University of Dayton
% 8-1-13

% Evaluate function
f = besselj(1, pi*r) ./ (2*r);

% Correct the r=0 value
f( r==0 ) = pi/4;


