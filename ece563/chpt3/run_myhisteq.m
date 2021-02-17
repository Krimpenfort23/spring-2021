%% Explot the builtin image forest.tif with historgram equalization

cl

% Load forest image
[X,map] = imread('forest.tif'); % color map image
x = double( ind2gray(X,map) );

% Display with custom im( ) function to auto scale
% Note the poor contrast in bright regions
% Note that the image is a negative
im(x); title('Raw Image')

% View histogram image image
figure
histogram(x(:),100); title('Raw Historgram')

% Apply histogram equalization
y = myhisteq( x, 256 );

% Display image after histogram equalization
im(y); title('Image with Histogram Eq')

% Display histogram after histogram equalization
figure
histogram(y(:),100); title('Historgram after Equalization')


%%  Display all in one figure (demonstrate imhist)

figure
subplot(2,2,1)
im(x,0); title('Raw Image')

subplot(2,2,2)
histogram(x(:),100); title('Raw Historgram')
title('Raw Historgram')

subplot(2,2,3)
im(y,0); title('Image with Histogram Eq')

subplot(2,2,4)
histogram(y(:),100); title('Historgram after Equalization')


