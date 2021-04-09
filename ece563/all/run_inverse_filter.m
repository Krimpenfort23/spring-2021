%% Demonstrate inverse and pseudo inverse image filtering
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
title('Motion Blurred Image (conv2)');

% Display impulse response
figure
mesh([-padx:padx], [-pady:pady]', h)
title('Motion Blur Impulse Response')
xlabel('n_1');
ylabel('n_2');
zlabel('h(n_1,n_2)');
axis ij % Note use axis ij for everything in this example to be consistent

%% Degradation frequency response

H = fft2(h, N+L-1, M+K-1);

% Get frequency axis
[~, ~, f1, f2] = fftshift_samples2d([M+K-1, N+L-1]);

% Display magnitude frequency response zero centered
im(abs(fftshift(H)), 1, 0, 2, f1, f2);
title('Motion Blur Magnitude Freq Response');
xlabel('f_1 (cyc/samp)');
ylabel('f_2 (cyc/samp)');

%% Degrade with H (equivalent to conv2 here)

% Do FFTs
FPAD = fft2(fpad, N+L-1, M+K-1);
H = fft2(h, N+L-1, M+K-1);

% Multiply FFTs
G = H .* FPAD;

% Inverse transform
g2 = real(ifft2(G));

% Crop
g2 = g2(L:end, K:end);

% Or circ shift to account for impulse repsonse treated as first quadrant,
% but not really first quadrant (shift of pady, padx)
% g2  = circshift( g2, [-pady, -padx] );
%
% Crop the padding
% g2 = g2( pady+1:end-pady, padx+1:end-padx);

% Display the degraded image (FFT)
im(g2);
title('Motion Blurred Image (FFT)');

% Measure difference
dif(g, g2)

%% Inverse Filter

% Pad the degraded image
gpad = padarray(g, [pady, padx], 'symmetric', 'both');

% Take FFT
GPAD = fft2(gpad);

% Inverse filter
HI = 1 ./ H;

% Apply inverse filter
FHAT = HI .* GPAD;

% Inverse transform
fhat = ifft2(FHAT);

% Crop (opposite from the forward model)
fhat = fhat(1:N, 1:M);

% Display inverse filtered image
im(fhat);
title('Inverse Filter Output');

% Display magnitude frequency response zero centered
im(abs(fftshift(HI)), 1, 0, 2, f1, f2);
title('Inverse Filter Magnitude Freq Response');
xlabel('f_1 (cyc/samp)');
ylabel('f_2 (cyc/samp)');

%% Pseudo-Inverse Filter

% Pad the degraded image
gpad = padarray(g, [pady, padx], 'symmetric', 'both');

% Take FFT
GPAD = fft2(gpad);

% Pseudo inverse filter
thresh = .05;
HPI = 1 ./ H;
HPI(abs(H) < thresh) = 0;

% Apply inverse filter
FHAT = HPI .* GPAD;

% Inverse transform
fhat = ifft2(FHAT);

% Crop (opposite from the forward model)
fhat = fhat(1:N, 1:M);

% Display inverse filtered image
im(fhat);
title('Pseudo Inverse Filter Output');

% Display magnitude frequency response zero centered
im(abs(fftshift(HPI)), 1, 0, 2, f1, f2);
title('Pseudo Inverse Filter Magnitude Freq Response');
xlabel('f_1 (cyc/samp)');
ylabel('f_2 (cyc/samp)');

%% Extra padding to reduce border effects

% Do padding with extra pad
extra_pad = 100;
g2 = padarray(g, [pady+extra_pad, padx+extra_pad], 'symmetric', 'both');

% Get new size
[sy2, sx2] = size(g2);

% Take FFTs at the larger size
H = fft2(h, sy2, sx2);
G2 = fft2(g2);

% Compute pseudo inverse filter
thresh = 0.05;
HPI = 1 ./ H;
HPI(abs(H) < thresh) = 0;

% Apply filter
FHAT2 = HPI .* G2;
fhat2 = ifft2(FHAT2);

% Crop for extra padding
fhat2 = fhat2(extra_pad+1:extra_pad+N, extra_pad+1:extra_pad+M);

% Display output
im(fhat2);
title('Pseudo Inverse Filter Output (Extra Padding)');

% % Display input image
% im(f);
% title('Ideal Image');
%
% % Display degraded image (conv2)
% im(g);
% title('Motion Blurred Image (conv2)');
%
