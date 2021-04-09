%% Demonstrate normalized cross-correlation for template matching
%
% Dr. Russell Hardie
% University of Dayton
% ECE 563 Image Processing

%% Load image

cl

addpath(genpath('../../MATLAB/'))

% Load aerial image
aerial = imread('westconcordaerial.png');

aerial = double(aerial(:, :, 2));

im(aerial)
title('Aerial Image')

%% Get the template we want to search for in image

template = aerial(345:365, 168:188);

[tsy, tsx] = size(template);
padx = (tsx - 1) / 2;
pady = (tsy - 1) / 2;

im(template)
title('Template')

%% Do normalized cross correlation

cc = normxcorr2(template, aerial);

% This coes full correlation, making the output larger than the input.
% Let's crop to get the same size.
cc2 = cc(pady+1:end-pady, padx+1:end-padx);
im(cc2)
title('Normxcorr2 output')

figure
mesh(cc2);
title('Normxcorr2 output')
axis ij

im(aerial)
display_masks(cc2 > .65);
title('Aerial Image with cc2 > .65')
