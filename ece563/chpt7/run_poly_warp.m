%% Examples of control point based polynomial transformations
% User selected points with ginput
%
% Dr. Russell Hardie
% University of Dayton
% ECE 563 Image Processing

addpath(genpath('../../MATLAB/'))

%% Load Data

close all

% Load aerial image
in = imread('westconcordaerial.png');

% Take green field as grayscale image
in = double(in(:, :, 2));

% Get image size
[sy, sx] = size(in);

%% Pick mapping points.

% Select 8 points in pairs.  Point 1 maps to point 2,
% point 3 maps to point 4, etc.

% Display image
im(in)
title('Input')

disp('Select 4 pairs of control points with mouse')
disp('input 1, output 1')
disp('input 2, output 2')
disp('input 3, output 3')
disp('input 4, output 4')

% Select points with mouse
[mx, my] = ginput(8);

% Separate into input and output points
poutx = round(mx(1:2:8));
pinx = round(mx(2:2:8));

pouty = round(my(1:2:8));
piny = round(my(2:2:8));

%% Solve for polynomial coefficients

% Set up the polynomial matrix
A = [; ...
    pinx(1), piny(1), pinx(1) * piny(1), 1; ...
    pinx(2), piny(2), pinx(2) * piny(2), 1; ...
    pinx(3), piny(3), pinx(3) * piny(3), 1; ...
    pinx(4), piny(4), pinx(4) * piny(4), 1; ...
    ];

% Solve for polynomial coefficients for the given control points
ax = inv(A) * poutx;
ay = inv(A) * pouty;

%% Warp image

% Create uniform input grid
[X, Y] = meshgrid([1:sx], [1:sy]);

% Warp grid with polynomial
X2 = ax(1) * X + ax(2) * Y + ax(3) * X .* Y + ax(4);
Y2 = ay(1) * X + ay(2) * Y + ay(3) * X .* Y + ay(4);

% Force points to stay in range to avoid NaN output from interp2
Y2 = clip(Y2, 1, sy);
X2 = clip(X2, 1, sx);

% Evaluate points on warped grid using bilinear interpolation
out = interp2(X, Y, in, X2, Y2, 'bil');

%% Display input and output

figure(2)
subplot(221)
im(in, 0)
title('Input')

subplot(222)
im(out, 0)
title('Output')

subplot(223)
plot(X2(1:10:sy, 1:10:sx), Y2(1:10:sy, 1:10:sx), '.');
axis('square');
axis('ij');
axis tight
title('X2,Y2 (From Grid)')

subplot(224)
plot(X(1:10:sy, 1:10:sx), Y(1:10:sy, 1:10:sx), '.');
axis('square');
axis('ij');
axis tight
title('X,Y (To Grid)')
