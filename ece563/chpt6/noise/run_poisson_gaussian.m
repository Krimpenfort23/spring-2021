%% Explore Poisson-Gaussian noise
%
% The image  g  is assumed to follow the Poisson-Gaussian noise model
%
%    g = alpha * p(f_bar) + n
%
% The variable "p"  is a Poisson-distributed realization of the expected
% photon count "f_bar".  The parameter  alpha  is a positive scaling factor
% that is a camera gain parameter (relating photons to pixel digital units
% (DUs)).  The variable "n"  is additive zero-mean Gaussian noise with
% standard deviation sigma.
%
% The parameters of this Poisson-Gaussian noise model are alpha and sigma.
% The parameter alpha impacts the Poisson component, and sigma is the
% standard deviation of the additive Gaussian noise component.  These are
% camera specific parameters.  They depend on the CCD array in the camera
% and also on the integration time.  These parameters should not change
% when we change the optics!
%
% Uses:
% chp1 files
% GenAnscombe_forward.m
% GenAnscombe_inverse_closed_form.m
%
% Author: Dr. Russell Hardie
% University of Dayton
% ECE 563 10/10/17
%
% Revision history:
% 3/2/2021 updated

%% Create ideal image

% Clear, close all, clc
cl

% Camera parameters
alpha = 2.5; % Camera photon count to pixel DU gain
sigma = 2; % additive Gaussian noise standard deviation

% Load "ideal" image
f = double(imread('cameraman.tif'));

% Scale ideal image to expected photon count image
f_bar = f / alpha;
im(f_bar);
title('Expected Photon Count Image')

% Histogram of Poisson-Gaussian Image
figure
hist(f(:), 200)
xlabel('Pixel Value (DU)')
ylabel('Number of Occurances')
title('Ideal Image Histogram')

% Histogram of Poisson-Gaussian Image
figure
hist(f_bar(:), 200)
xlabel('Photon Count')
ylabel('Number of Occurances')
title('Photon Count Histogram')

%% Simulate Poisson-Gaussian image

% Corrupt "noise_free" array with Poisson-Gaussian noise
g = alpha * poissrnd(f_bar) + sigma * randn(size(f_bar));

% Display Poisson-Gaussian Image
im(f);
title('Ideal Image')

% Display Poisson-Gaussian Image
im(g);
title('Poisson-Gaussian Image')

%% Make image sequence and play video

% Repeat ROI to make simulated static video sequence
f_bar_video = repmat(f_bar(51:200, 36:185), [1, 1, 100]);

% Simulate Poisson-Gaussian noise
g_video = alpha * poissrnd(f_bar_video) + ...
    sigma * randn(size(f_bar_video));

% Display video
% sliceViewer( g_video, 'DisplayRange', [0,255] )

% Display image sequence with implay
handle = implay(g_video);

% Set the colormap grayscale range for implay
handle.Visual.ColorMap.UserRange = 256;
handle.Visual.ColorMap.UserRangeMin = 0;
handle.Visual.ColorMap.UserRangeMax = 255;

% Compute temporal statistics
M = mean(g_video, 3);
V = var(g_video, [], 3);

% Plot temporal statistics
figure
plot(M(:), V(:), 'b.')
xlabel('Mean Value (DU)')
ylabel('Variance (DU)')
title('Temporal Statistics')
grid

%% Use Anscombe transform to stabilize variance

% https://en.wikipedia.org/wiki/Anscombe_transform
% http://www.cs.tut.fi/~foi/invansc/

% Apply Anscombe transform to make noise variance look constant for
% restoration (noise variance is 1 for all pixels)

g_anscombe = GenAnscombe_forward(g, sigma, alpha, 0);

% Display Poisson-Gaussian Image
im(g);
title('Poisson-Gaussian Image')

im(g_anscombe);
title('Poisson-Gaussian Image after Anscombe Transform')

% Apply Anscombe to each frame of video
for idx = 1:size(g_video, 3)

    g_video_anscombe(:, :, idx) = GenAnscombe_forward(g_video(:, :, idx), sigma, alpha, 0);

end

figure
hist(g_video_anscombe(:), 100)
title('Histogram after Anscombe transform')

% Display image sequence with implay
handle = implay(g_video_anscombe);

% Set the colormap grayscale range for implay
handle.Visual.ColorMap.UserRange = 256;
handle.Visual.ColorMap.UserRangeMin = 0;
handle.Visual.ColorMap.UserRangeMax = max(g_video_anscombe(:));

% Compute temporal statistics
M = mean(g_video_anscombe, 3);
V = var(g_video_anscombe, [], 3);

% Plot temporal statistics
figure
plot(M(:), V(:), 'b.')
xlabel('Mean Value (DU)')
ylabel('Variance (DU)')
title('Temporal Statistics after Anscombe')
grid

%% Inverse Anscombe

% One would now process the imagery 'g_anscombe' and then use the inverse
% Anscombe transform to bring the histogram back to the the original range.

% Inverse Anscombe
g2 = GenAnscombe_inverse_closed_form(g_anscombe, sigma, alpha);

% Display the originial Poisson-Gaussian image (left) next to the
% foraward--> inverse Anscombe image (right).  They should look the same
im([g, g2]);
title('Original (left), Forward-Inverse Anscombe (right)')

% Slightly difference due to numerical issues
dif(g, g2)
