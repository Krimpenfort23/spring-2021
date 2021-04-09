function [a, XI, YI] = gencircsym(r, pval, maxx)
%
% [a,XI,YI]=gencircsym(r,pval,maxx);
%
% Generates a circularly symmetric
% array based on the radius values in r.
% The output array is 2*length(r)-1 square.
%
% a	Output image (circularly symmetric)
% XI	Vector of x positions for each point (used in plotting)
% YI	Vector of y positions for each point (used in plotting)
%
% r	Array of radius values
%
% pval	Value to put in the corners of the ouput array (optional).
%	default is 0.  Other ideas include max(r) or min(r).
%
% maxx  The distance from 0,0 that the final value in r is (optional).
%       Needed to create XI,YI vectors (default = length(r)-1).
%
% Author: Dr. Russell Hardie
% 11/6/97 University of Dayton
% Modified 1/30/99

% size of output array
lr = length(r);
N = 2 * lr - 1;

% create the grid of x,y points in the array
R = linspace(-(lr - 1), (lr - 1), N);
[X, Y] = meshgrid(R);

% create the output array indices
if nargin < 3
    XI = R; % default
else
    XI = linspace(-maxx, maxx, N);
end
YI = XI; % output array is symmetric and square

% get radial distance to every x,y point
RAD = sqrt(X(:).^2 + Y(:).^2);

% expanded r to deal with corners and fill with pval
extra = ceil(sqrt(2)*(lr - 1)) - (lr - 1);

if nargin == 1
    pval = 0; % default
end

rr = [r, pval * ones(1, extra)];

% evaluate the intensity at every point
RADVAL = interp1([0:(length(rr) - 1)], rr, RAD);

% reshape all the intensities into a 2D grid
a = reshape(RADVAL, N, N);
