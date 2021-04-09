%% Compare pseudo inverse and Wiener filter
%
% Dr. Russell Hardie
% University of Dayton
% ECE 563
%

%% Load and degrade image with conv2

cl

% Load image
f = double(imread('cameraman.tif'));

% Degrade image with simulated motino blur
[N, M] = size(f);
h = fspecial('motion', 9, 45);
[L, K] = size(h);

% Pad image
padx = (K - 1) / 2;
pady = (L - 1) / 2;
fpad = padarray(f, [pady, padx], 'symmetric', 'both');

% Do convolution to degrade image
g = conv2(fpad, h, 'valid');

% Display input image
im(f);
title('Ideal Image');

% Display degraded image (conv2)
im(g);
err = dif(f, g);
title(sprintf('Motion Blurred Image (MSE=%2.2f)', err.mse));

% Display impulse response
figure
mesh([-padx:padx], [-pady:pady]', h)
title('Motion Blur Impulse Response')
xlabel('n_1');
ylabel('n_2');
zlabel('h(n_1,n_2)');
axis ij % Note use axis ij for everything in this example to be consistent

%% Pseudo inverse with extra padding to reduce border effects

% Do padding with extra pad
extra_pad = 100;
g2 = padarray(g, [pady+extra_pad, padx+extra_pad], 'symmetric', 'both');

% Get new size
[sy2, sx2] = size(g2);

% Take FFTs at the larger size
H = fft2(h, sy2, sx2);
G2 = fft2(g2);

% Compute pseudo inverse filter
thresh = .05;
HPI = 1 ./ H;
HPI(abs(H) < thresh) = 0;

% Apply filter
FHAT2 = HPI .* G2;
fhat2 = ifft2(FHAT2);

% Crop for extra padding
fhat2 = fhat2(extra_pad+1:extra_pad+N, extra_pad+1:extra_pad+M);

% Display output
im(fhat2);
err2 = dif(f, fhat2);
title(sprintf('Pseudo Inverse (Extra Padding) (MSE=%2.2f)', err2.mse));

%% Use Wiener filter with teh same exta padding

% Wiener filter in DFT domain
nsr = .01;
absH2 = abs(H.^2);
HW = conj(H) ./ (absH2 + nsr);

% Apply Wiener filter
FHAT3 = HW .* G2;
fhat3 = ifft2(FHAT3);

% Crop for extra padding
fhat3 = fhat3(extra_pad+1:extra_pad+N, extra_pad+1:extra_pad+M);

% Display output
im(fhat3);
err3 = dif(f, fhat3);
title(sprintf('Wiener Filter (Extra Padding) (MSE=%2.2f)', err3.mse));

%% Compare frequency responses

% Get frequency axis
[~, ~, f1, f2] = fftshift_samples2d([sx2, sy2]);

% Display magnitude frequency response zero centered
im(abs(fftshift(H)), 1, 0, 2, f1, f2);
title('Motion Blur Magnitude Freq Response');
xlabel('f_1 (cyc/samp)');
ylabel('f_2 (cyc/samp)');

% Display magnitude frequency response zero centered
im(abs(fftshift(HPI)), 1, 0, 2, f1, f2);
title('Motion Blur Magnitude Freq Response');
xlabel('f_1 (cyc/samp)');
ylabel('f_2 (cyc/samp)');

% Display magnitude frequency response zero centered
im(abs(fftshift(HW)), 1, 0, 2, f1, f2);
title('Motion Blur Magnitude Freq Response');
xlabel('f_1 (cyc/samp)');
ylabel('f_2 (cyc/samp)');
