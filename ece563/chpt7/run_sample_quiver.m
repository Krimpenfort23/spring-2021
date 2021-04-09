%% Display image with 2D sampling comb function
%
% Dr. Russell Hardie
% University of Dayton
% ECE 563 Image Processing

% x = imread('cameraman.tif');
x = imread('westconcordorthophoto.png');

[sy, sx] = size(x);

figure
surf(zeros(sy, sx), x)
shading interp
colormap(gray(256))
view(-19, 66)
axis ij

step = 20;
[X, Y] = meshgrid(1:step:sx, 1:step:sy);
Z = zeros(size(X));

U = Z;
V = Z;
W = x(1:step:sy, 1:step:sx);

hold on
quiver3(X, Y, Z, U, V, W, 'off', 'g', 'linewidth', 1)
