%% Demonstrate the estimation of a 2D autocorrelation function of image
%
% Dr. Russell Hardie
% University of Dayton
% ECE 563
%
%

%% Load image

cl

addpath(genpath('C:\Data\Teaching\ECE 563\MATLAB\'))

% Load image
% x = double( imread('cameraman.tif') );
% x = double( imread('pout.tif') );
x = double(imread('westconcordorthophoto.png'));

%% Estimate correlation

% Subtract local mean
s = 5;
h = fspecial('gaussian', 6*s+1, s);
x_mean = conv2(padarray(x, [3 * s, 3 * s], 'both', 'symmetric'), h, 'valid'); % Makes image more WSS
% x_mean = mean2(x);  % Still does not decay to 0 (non-stationarity impacting)
% x_mean = 0;  % Dominated by DC

x2 = x - x_mean;

% Estimate autocorrelation using my function est_corr.m
ws = 20;
rxx = est_corr(x2, ws, 1, 5);

%% See how deterministic autocorrelation is an estimate of the statistical autocorrelation

rxx2 = xcorr2(x2, x2) / prod(size(x2));

[sy, sx] = size(rxx2);
figure
mesh(rxx2((sy + 1) / 2 - ws:(sy + 1) / 2 + ws, (sx + 1) / 2 - ws:(sx + 1) / 2 + ws));
xlabel('m (pixels)')
ylabel('n (pixels)')
zlabel('r_{f,f}(m,n)')
title('Autocorrelation (Local Mean Subracted)')

%% If you don't subtract local mean, the autocorrelation is impacted by non-stationarity

rxx2 = xcorr2(x, x) / prod(size(x));

[sy, sx] = size(rxx2);
figure
mesh(rxx2((sy + 1) / 2 - ws:(sy + 1) / 2 + ws, (sx + 1) / 2 - ws:(sx + 1) / 2 + ws));
xlabel('m (pixels)')
ylabel('n (pixels)')
zlabel('r_{f,f}(m,n)')
title('Autocorrelation (With Local Mean)')

%% Try autocorrelation of a random noise image

ws = 20;
rnn = est_corr(randn(256, 256), ws, 1, 10);

xlabel('m (pixels)')
ylabel('n (pixels)')
zlabel('r_{f,f}(m,n)')
title('Autocorrelation of White Gaussian Noise')
