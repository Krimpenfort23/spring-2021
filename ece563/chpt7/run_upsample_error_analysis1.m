%% Compare various upsampling methods quantitatively
%
% Dr. Russell Hardie
% University of Dayton
% ECE 563 Image Processing

%% Load image

addpath(genpath('../../MATLAB'))

cl

% x = double( imread('cameraman.tif') );
x = double(imread('westconcordorthophoto.png'));

[sy, sx] = size(x);

im(x);
title('Input')

%% Downsample
L = 3;

% Allow aliasing
y = imresize(x, 1/L, 'bil');

im(y)
title('Downsampled')


% Upsample
z1 = imresize(y, L, 'nea');
z2 = imresize(y, L, 'bil');
z3 = imresize(y, L, 'bic');
z4 = imresize(y, L, 'lanczos3');

z1 = z1(1:sy, 1:sx);
z2 = z2(1:sy, 1:sx);
z3 = z3(1:sy, 1:sx);
z4 = z4(1:sy, 1:sx);

% Display
im(z1);
title('ZOH');
im(z2);
title('Bilinear');
im(z3);
title('Bicubic');
im(z4);
title('Lanczos3');

% Error analysis
e_zoh = dif(x(41:end - 40, 41:end - 40), z1(41:end - 40, 41:end - 40))
e_bil = dif(x(41:end - 40, 41:end - 40), z2(41:end - 40, 41:end - 40))
e_bic = dif(x(41:end - 40, 41:end - 40), z3(41:end - 40, 41:end - 40))
e_lan = dif(x(41:end - 40, 41:end - 40), z4(41:end - 40, 41:end - 40))
