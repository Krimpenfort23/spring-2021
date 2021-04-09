%% Demonstrate phase correlation for shift registration
%
% Dr. Russell Hardie
% University of Dayton
% ECE 563 Image Processing

%% Read image and simulate a fractional shift

cl

addpath(genpath('../../MATLAB/'))

% Load reference image
ref = double(imread('pout.tif'));
[sy, sx] = size(ref);

% Define input pixel coordinates
[X, Y] = meshgrid([1:sx], [1:sy]);
IN = [X(:)'; Y(:)'; ones(1, sx * sy)];

% Generate shift transformation
x0 = 10.7
y0 = -7.3

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

%% Phase correlation

% Get the FFTs
REF = fft2(ref);
TARGET = fft2(target);

% Normalized cross power spectrum
temp = REF .* conj(TARGET); % doing a circular convolution, so don't trust borders
NCS = temp ./ abs(temp);
ncs = ifft2(NCS);

% We want a 0,0 shift to peak in the center.
% Note FFT interprets the images as first quadrant and convolving them
% produces a result in the first quadrant.  If we want a zero centered
% looking image, we need to fftshift
ncs2 = fftshift(ncs);

% (0,0) index in ncs2 based on DFT sampling
zx = floor(sx/2) + 1;
zy = floor(sy/2) + 1;

% Two ways to locate the coordinates of the max value
% [max_idx_y, max_idx_x ] = find( ncs2 == max(ncs2(:)) ) % Method 1
[max_ncs, max_idx] = max(ncs2(:)); % Method 2
[max_idx_y, max_idx_x] = ind2sub(size(ref), max_idx); % Method 2

% Show the ncs2 surface (normalized cross correlation)
figure
mesh(ncs2);
title('Normalized Cross-Correlation Output')
xlabel('x');
ylabel('y');

figure
imshow(ncs2, [0, max(ncs2(:))]);
title('Normalized Cross-Correlation Output')
hold on
plot(zx, zy, 'b+')

% Get the shifts by comparing the peak to the image center which
% corresponds to no shift
shift_x = max_idx_x - zx
shift_y = max_idx_y - zy
