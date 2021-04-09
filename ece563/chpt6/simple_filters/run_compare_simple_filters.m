%% Compare simple image smoothers for noise reduction
%
% Dr. Russell Hardie
% University of Dayton
% ECE 563
%
% Revised 3/2/2021, 3/6/2021

%% Simulate data

% Start fresh
cl

% Load ideal image
x = double(imread('cameraman.tif'));

% Define noise std
noise_std = 20;

% Generate noise array
noise = randn(size(x)) * noise_std;

% Add noise array
y = x + noise;

% Error analysis
noise_dif = dif(x, y);

% Display
im(y);
title(sprintf('Noisy Image (MAE=%2.2f)', noise_dif.mae))

%% Moving average filter

% Parameters
ws = 3;
pad = (ws - 1) / 2;
h = ones(ws, ws) / (ws * ws);

% Convolution
tic
ypad = padarray(y, [pad, pad], 'symmetric', 'both');
ma = conv2(ypad, h, 'valid');
toc

% Error analysis
ma_dif = dif(x, ma);

% Display
im(ma);
title(sprintf('%d x %d Moving Average (MAE=%2.2f)', ws, ws, ma_dif.mae));

%% Geometric mean filter

% Parameters
ws = 3;
pad = (ws - 1) / 2;

% im2col
Y = im2col(padarray(y, [pad, pad], 'symmetric', 'both'), ...
    [ws, ws], 'sliding');

% Compute geometric mean
geometric = [prod(Y)].^(1 / (ws^2));
geometric = reshape(real(geometric), size(y));

% Error analysis
gm_dif = dif(x, geometric)

% Display
im(geometric);
title(sprintf('%d x %d Geometric Mean (MAE=%2.2f)', ws, ws, gm_dif.mae));

% % Bias correction
% geometric2 = geometric - mean( geometric(:)) + mean( y(:) );
%
% gm_dif2 = dif( x, geometric2 )

%% LLMMSE

% Parameters
ws = 7;
pad = (ws - 1) / 2;

% LLMSE filter
llmmse_out = llmmse(padarray(y, [pad, pad], 'symmetric', 'both'), noise_std^2, ws, ws);

% Error analysis
llmmse_dif = dif(x, llmmse_out)

% Display
im(llmmse_out);
title(sprintf('%d x %d LLMMSE (MAE=%2.2f)', ws, ws, llmmse_dif.mae));

%% Bilateral filter

% out = bilateral( in, s, sigma )
% in = noisy
% s = spatial weighting kernel (Gaussian usually)
% sigma = assumed noise std (does not need to be the actual noise std)

% Spatial weighting
h = fspecial('gaussian', [15, 15], 9);

% Modifiy for best results
noise_std_use = 2 * noise_std;

% Bilateral filter
bilateral_out = bilateral(y, h, noise_std_use);

% Error analysis
bilateral_dif = dif(x, bilateral_out)

% Display
im(bilateral_out);
title(sprintf('%d x %d Bilateral (MAE=%2.2f)', size(h), bilateral_dif.mae));

%%  Nonlocal Means NLM

% out = nlm_filter(in,window_size,search_size,h);
%
% Non-local means image denoising filter.  Uses a window size of
% (2*window_size+1) x (2*window_size+1) and searches a range
% (2*search_size+1) x (2*search_size+1)
%
%  Implementation of the Non local filter proposed for A. Buades, B. Coll
%  and J.M. Morel in "A non-local algorithm for image denoising"
%
% REQUIRED INPUTS
% in            2D input image
%
% window_size   Similarity window (2*window_size+1) x (2*window_size+1)
%
% search_size   Search region (2*search_size+1) x (2*search_size+1)
%
% h             weights = exp(-euclidean dist squared/h).  Recommended
%               10*noise std
%
% OUTPUTS
% out           2D output image

% Parameters
window_size = 3;
search_size = 9;

% NLM filter
nlm_out = nlm_filter(y, window_size, search_size, 15*noise_std);

% Error analysis
nlm_dif = dif(x, nlm_out)

% Display
im(nlm_out);
title(sprintf('%d x %d NLM (MAE=%2.2f)', window_size, window_size, ...
    nlm_dif.mae));

%% Step through all figures with space bar

figstep

%% Salt and pepper noise

cl

x = double(imread('cameraman.tif'));

% x =imread('cameraman.tif');
% y = imnoise(x,'salt & pepper',.02); % x can't be double

% Make my own impulsive (salt and pepper) noise
possible_salt_mask = rand(size(x)) < .5;

p = .05;
noise_mask = rand(size(x)) < p;

salt_mask = noise_mask & possible_salt_mask;
pepper_mask = noise_mask & ~possible_salt_mask;

% Contaminate image
y = x;
y(salt_mask) = 255;
y(pepper_mask) = 0;

% Error analysis
corrupted_dif = dif(x, y)

% Display
im(y);
title(sprintf('Salt and Pepper Noise (p=%2.2f) (MAE=%2.2f)', p, corrupted_dif.mae))

%% Median filter

% Parameters
ws = 3;
pad = (ws - 1) / 2;

% im2col
Y = im2col(padarray(y, [pad, pad], 'symmetric', 'both'), ...
    [ws, ws], 'sliding');

% Median
med_out = median(Y);
med_out = reshape(med_out, size(x));

% Error analysis
med_dif = dif(x, med_out)

% Display
im(med_out);
title(sprintf('%d x %d Median (p=%2.2f) (MAE=%2.2f)', ws, ws, p, med_dif.mae))

%% Rank Conditioned Median (RCM) filter

% Output median only when center sample rank is in the
% bottom k or top k of the order statistics.  Otherwise output the center
% sample (i.e., don't modify the image at that point).

% Parameters
ws = 3;
k = 3;
pad = (ws - 1) / 2;

% im2col
Y = im2col(padarray(y, [pad, pad], 'symmetric', 'both'), ...
    [ws, ws], 'sliding');

% Sorting
[Y_sort, I_sort] = sort(Y);
middle_pix_idx = (ws^2 + 1) / 2;
[rank_of_center_sample, ~] = find(I_sort == middle_pix_idx); % This is kind of tricky!

% Initialize RCM output
rcm_out = y;

% Find the outliers
outlier_idx = find(rank_of_center_sample < k | rank_of_center_sample > (ws^2 - k + 1));

% Sub in the median for these outliers
% Note Y_sort( middle_pix_idx,:) are the medians
rcm_out(outlier_idx) = Y_sort(middle_pix_idx, outlier_idx);

% Error analysis
rcm_dif = dif(x, rcm_out)

% Display
im(rcm_out);
title(sprintf('%d x %d RCM k=%d (p=%2.2f) (MAE=%2.2f)', ws, ws, k, p, rcm_dif.mae))

%% Moving average (MA)

% Parameters
ws = 3;
pad = (ws - 1) / 2;
h = ones(ws, ws) / (ws * ws);

% Do convolution
ma = conv2(padarray(y, [pad, pad], 'symmetric', 'both'), h, 'valid');

% Error analysis
ma_dif = dif(x, ma)

% Display
im(ma);
title(sprintf('%d x %d Moving Average (p=%2.2f) (MAE=%2.2f)', ws, ws, p, ma_dif.mae))

%% Step through all figures with space bar

figstep
