%% Demonstrate gradient based registration using custom register-shift.m
%
% Dr. Russell Hardie
% University of Dayton
% ECE 563 Image Processing

%% Read image and simulate a fractional shift

addpath(genpath('../../MATLAB/'))

cl

% Load reference image
ref = double(imread('pout.tif'));
[sy, sx] = size(ref);

% Define input pixel coordinates
[X, Y] = meshgrid([1:sx], [1:sy]);
IN = [X(:)'; Y(:)'; ones(1, sx * sy)];

% Define shift transformation
x0 = 3.7
y0 = -2.3

S1 = [1, 0, x0; ...
    0, 1, y0; ...
    0, 0, 1];

% Perform coordinate transformation
OUT = S1 * IN;

% Extract the new X,Y coordinates
X2 = clip(OUT(1, :), 1, sx);
Y2 = clip(OUT(2, :), 1, sy);

% Clip to be in image range
X2 = reshape(X2, sy, sx);
Y2 = reshape(Y2, sy, sx);

% Get the values at the new coordinates to create a target image
target = interp2(X, Y, ref, X2, Y2, 'bil');

%% Display Images

im(ref);
title('Reference Image');

im(target);
title('Target Image (shifted)');

%% Do gradient based shift registration

% Perform the gradient based registration
thresh = .05;
buff = 20;
method = 'bic';
S = register_shift(ref, target, thresh, buff, method);

% Truth
T = [x0; y0]

% Estimated shift (pix)
S

% Percent error
percent_error_pix = 100 * (S - T) ./ S
