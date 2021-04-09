%% Examples of affine spatial transformations
% Rotation about (0,0) and about the image center
%
% Dr. Russell Hardie
% University of Dayton
% ECE 563 Image Processing

addpath(genpath('../../MATLAB/'))

%% Image Rotation

% Rotation matrix
theta = pi / 4;
R = [cos(theta), -sin(theta), 0; ...
    sin(theta), cos(theta), 0; ...
    0, 0, 1];
% load image
in = double(imread('pout.tif'));
[sy, sx] = size(in);

% define input pixel coordinates
[X, Y] = meshgrid([1:sx], [1:sy]);
IN = [X(:)'; Y(:)'; ones(1, sx * sy)];

% Perform affine coordinate transformation
OUT = R * IN;

% Extract the new X,Y coordinates (use clip to prevent coordinate values
% outside original image)
X2 = clip(OUT(1, :), 1, sx);
Y2 = clip(OUT(2, :), 1, sy);

% Reshape coordinates into sy x sx 2D arrays
X2 = reshape(X2, sy, sx);
Y2 = reshape(Y2, sy, sx);

% Get the values at the new coordinates
out = interp2(X, Y, in, X2, Y2, 'bil');

im(out)
% What is up with this image???
% It is rotated about 0,0 (not the image center)

%% Rotate about center

% Image center coordinates
x0 = (sx + 1) / 2;
y0 = (sy + 1) / 2;

% Affine transformation to shift input x0,y0 to output 0,0
S1 = [1, 0, x0; ...
    0, 1, y0; ...
    0, 0, 1];

% Affine transformation to shift input 0,0 to output x0,y0
S2 = [1, 0, -x0; ...
    0, 1, -y0; ...
    0, 0, 1];

% Perform affine coordinate transformation
% S1: make x0,y0 in input be 0,0
% R:  rotate about 0,0
% S2: make 0,0 go to x0,y0
OUT = (S1 * R * S2) * IN;

% Extract the new X,Y coordinates
X2 = clip(OUT(1, :), 1, sx);
Y2 = clip(OUT(2, :), 1, sy);

% Reshape coordinates into sy x sx 2D arrays
X2 = reshape(X2, sy, sx);
Y2 = reshape(Y2, sy, sx);

% Get the values at the new coordinates
out2 = interp2(X, Y, in, X2, Y2, 'bil');
im(out2)
