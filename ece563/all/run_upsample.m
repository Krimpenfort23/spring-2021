%% Demonstrate upsampling using convolution
%
% Dr. Russell Hardie
% University of Dayton
% ECE 563 Image Processing

addpath(genpath('../../MATLAB/'))

% load input image
% x = double( imread('cameraman.tif') );
x = imread('westconcordorthophoto.png');

im(x);
title('Input')

% Interlace zeros (expand)
[sy, sx] = size(x);
L = 2;
xe = zeros(L*sy, L*sx);
xe(1:L:end, 1:L:end) = x;
im(xe(40*L:90*L, 100*L:150*L), 1, 1);
title('Expanded (Zero Interlaced)')

% ZOH
hzoh = ones(L, L);
yzoh = conv2(xe, hzoh, 'valid');
im(yzoh(40*L:90 *L, 100*L:150*L));
title('ZOH Interpolation')

% Bilinear
hbil = tripuls([-(L - 1):(L - 1)], 2*L)' * tripuls([-(L - 1):(L - 1)], 2*L);
ybil = conv2(padarray(xe, [L - 1, L - 1], 'both', 'symmetric'), hbil, 'valid');
im(ybil(40 * L:90 * L, 100 * L:150 * L));
title('Bilinear Interpolation')

% LPF
ylpf = dft_lowpass2d(xe, 1/(2 * L), 1/(2 * L), 50);
im(ylpf(40 * L:90 * L, 100 * L:150 * L));
title('DFT LPF')
