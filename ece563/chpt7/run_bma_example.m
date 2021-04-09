%% Block matching registratoin example
%
% Dr. Russell Hardie
% University of Dayton
% ECE 563 Image Processing

%% Read image and simulate a fractional shift

addpath(genpath('../../MATLAB/'))

cl

% load reference image
ref = double(imread('pout.tif'));
[sy, sx] = size(ref);

% define input pixel coordinates
[X, Y] = meshgrid([1:sx], [1:sy]);
IN = [X(:)'; Y(:)'; ones(1, sx * sy)];

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

% Block Matching
max_shift = 20;

im(ref);
title('Full Reference Image');
mask = zeros(size(ref));
mask(max_shift+1:end-max_shift, max_shift+1:end-max_shift) = 1;
hold on
contour(mask, 1, 'r-');

ref2 = ref(max_shift+1:end-max_shift, max_shift+1:end-max_shift);
im(ref2);
title('Reference Interior');

im(target);
title('Full Target Image');

%% Start BMA Search

h = waitbar(0, 'Please wait...');
shx = [-max_shift : max_shift];
shy = [-max_shift : max_shift];
numx = length(shx);
numy = length(shy);
mae = zeros(numy, numx);

for idxx = 1:numx
    for idxy = 1:numy

        temp = circshift(target, [shy(idxy), shx(idxx)]);
        err = dif2(ref2, temp(max_shift + 1:end - max_shift, ...
            max_shift + 1:end - max_shift));
        mae(idxy, idxx) = err.mae;

    end
    waitbar(idxx/numx, h)
end
close(h)


% You can interpolate then do BMA for subpixel
% You can interpolate the mae mesh for subpixel
% You do BMA at multiple scales for speed improvement for large searches
% You can use other error metrics
% You can do locally to get automated tie points (does not have to be
% applied to whole image gobally).  You can even apply to each pixel to get
% the optical flow field.  Use quiver to plot.

[min_idxy, min_idxx] = find(mae == min(mae(:)))

bma_shx = shx(min_idxx)
bma_shy = shy(min_idxy)


figure
mesh(shx, shy, mae)
xlabel('x')
ylabel('y')
zlabel('MAE')
title('BMA Error Surface')

hold on

plot3(bma_shx, bma_shy, 0, 'rx')
