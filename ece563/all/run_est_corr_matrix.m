%% Demonstrate the estimation of an autocorrelation matrix
%
% Dr. Russell Hardie
% University of Dayton
% ECE 563
%
%

%% Load image

cl

% Load image
x = double(imread('westconcordorthophoto.png'));

% Display image
im(x)
title('Input Image')

%% Estimate autocorrelation matrix from raw image pixels

% Extract observation windows (5x5)
X = im2col(x, [5, 5], 'sliding');
N = size(X, 2);

% Estimate correlation matrix directly (Note unbiased estiator divides by
% N-1, not N)
R = (1 / (N - 1)) * X * X';

% Estimate correlation matrix using cov and the mean\ (see class notes)
MU = mean(X');
R2 = cov(X') + MU' * MU;

figure
mesh(R)
title('Est. Correlation Matrix (Direct)')

figure
mesh(R2)
title('Est. Correlation Matrix (from Covariance Matrix)')

im(R)
title('Est. Correlation Matrix (Direct)')

%% Estimate correlation matrix from local mean subtracted data

% Subtract local mean to make it more WSS
s = 5;
h = fspecial('gaussian', 6*s+1, s);

% Estimate local spatial mean
x_mean = conv2(padarray(x, [3 * s, 3 * s], 'both', 'symmetric'), h, 'valid'); 
% x_mean = mean2(x);  % Still does not decay to 0 (non-stationarity impacting)
% x_mean = 0;  % Dominated by DC

% Subtract the local mean
x2 = x - x_mean;

% Extract local windows
X2 = im2col(x2, [5, 5], 'sliding');
N = size(X2, 2);

% Estimate correlation matrix (unbiased)
R = (1 / (N - 1)) * X2 * X2';

% Estimate correlation matrix using cov and the mean (mean should be ~zero)
R2 = cov(X2');

figure
mesh(R)
title('Est. Correlation Matrix (Direct) (Mean Subtracted)')

figure
mesh(R2)
title('Est. Correlation Matrix (from Covariance) (Mean Subtracted)')

im(R)
title('Est. Correlation Matrix (Direct) (Mean Subtracted)')

%% Estimate autocorrelation function empirically

ws = 20;
rxx = est_corr(x2, ws, 1);
axis tight

%% Evaluate theoretical autocorrelation model

rdd.m = [-20:20];
rdd.n = [-20:20];
[M, N] = meshgrid(rdd.m, rdd.n);
var_d = 1100;
rho = .7;
rdd.z = var_d * rho.^(sqrt(M.^2 + N.^2));
figure
mesh(rdd.m, rdd.n, rdd.z);
xlabel('m');
ylabel('n');
zlabel('r_{d,d}(m,n)');
title('Theoretical WSS Image Correlation Model')
axis tight

%% Get the correlation matrix from the autocorrelation functions

% Create one obs window grid (centers of each LR pixel) HR pixel spacings
[WX, WY] = meshgrid([1 : 5], [1 : 5]);

% Evaluate the autocorrelations for these positions
M = length(WX(:));
XX = repmat(WX(:), [1, M]);
YY = repmat(WY(:), [1, M]);
DX = (XX' - XX);
DY = (YY' - YY);

% Interpolation from the theoretical 2D autocorrelation function
R_model = interp2(rdd.m, rdd.n, rdd.z, DX, DY);

% Interpolation from the empirical 2D autocorrelation function
R_func_to_mx = interp2(rxx.x, rxx.y, rxx.z_circ, DX, DY);

figure
mesh(R_model)
title('Correlation Matrix from Theoretical Model')

figure
mesh(R_func_to_mx)
title('Correlation Matrix from Empirical Correlation Function')
