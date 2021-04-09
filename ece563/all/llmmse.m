function out = llmmse(in,nvar,wsx,wsy)
%
% out = llmmse(in,nvar,wsx,wsy)
%
% Adaptive Wiener filter
% or Local Linear Minimum MSE filter
% See: J.-S. Lee, "Digital Image Enhancement and Noise Filtering
% by Use of Local Statistics,"
% Trans. on Patt. Aanalysis and Mach. Int., March 1980, Vol.2 No. 3   
% Also, p. 538 J. S. Lim Two-Dimensional Signal and Image Processing,
% Pentice Hall 1990.
%
% (requires image tool box im2col)
%
% REQUIRED INPUTS
% in		Input image
% nvar		Assumed additive noise variance 
% wsx		Window size in x
% wsy		Window size in y
%
% OUTPUTS
% out		Filterest image
%
% Author: Dr. Russell C. Hardie
% University of Dayton  5/8/98

% Get size info
[sy,sx] = size(in);
bx = (wsx-1)/2;
by = (wsy-1)/2;
middle = (wsx*wsy+1)/2;

% get all obs vectors
A = im2col(in,[wsy,wsx],'sliding'); 

% compute local obs vec means and variances
xvar = var(A);
mu = mean(A);

% weight to mean 
w2 = nvar./xvar;

% w2 must be 0 < w2 < 1
w2 = clip(w2,0,1); 

% weight to center sample
w1 = (1-w2);

% form estimate at each point
A2 = w1.*A(middle,:) + w2.*mu;

% reshape output image 
out = reshape(A2,sy-2*by,sx-2*bx); 
