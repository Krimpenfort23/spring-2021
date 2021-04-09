%% Simulate nonuniformity "fixed pattern" noise
%
% Author: Dr. Russell Hardie
% University of Dayton
% ECE 563 10/10/17

%% Load image

% addpath(genpath('../../MATLAB/'))

% load input image
x = double(imread('cameraman.tif'));
im(x);
title('Input')

%% Simulate fixed pattern noise and camera jitter

% Simulate random camera motion
motion_xy = randn(30, 2) * 2;
motion_xy = round(cumsum(motion_xy));

% Get size info
[sy, sx] = size(x);
num_frames = size(motion_xy, 1);

% Generate bias nonuniformity parameters
b = randn(sy, sx) * 30;

% Initialize output
out = zeros(sy, sx, num_frames);

% Apply camera jitter motion and nonuniformity
for k = 1:size(motion_xy, 1)

    out(:, :, k) = circshift(x, -[motion_xy(k, 1), motion_xy(k, 2)]) + b;

end

%% Display sequence

% Display image sequence with implay (crop borders away)
handle = implay(out(20:end - 20, 20:end - 20, :));

% Set the colormap grayscale range for implay
handle.Visual.ColorMap.UserRange = 256;
handle.Visual.ColorMap.UserRangeMin = 0;
handle.Visual.ColorMap.UserRangeMax = 255;
