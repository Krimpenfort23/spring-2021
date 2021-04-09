%% Demonstrate downsampling on a chirp image
% With and without an anti-aliasing prefilter
%
% Dr. Russell Hardie
% University of Dayton
% ECE 563 Image Processing

addpath(genpath('../../MATLAB/'))

%% Generate input image (2D chirp)

chirp1 = chirp(linspace(0, 1, 128), 0, 2, 100);
chirp2 = gencircsym(chirp1);
im(chirp2)
title('2D chirp image')

%% Down sampling with no antialiasing filter

chirp2_down4 = chirp2(1:4:end, 1:4:end);
im(chirp2_down4)
title('Downsampled by 4, no antialiasing')

%% FIR antialiasing using frequency sampling design

% Frequency sampling LPF
N = 101;
[w1, w2, f1, f2, u, v, x, y, n1, n2] = fftshift_samples2d(N);
[F1, F2] = meshgrid(f1, f2);
H = double(abs(F1) <= 1/8 & abs(F2) <= 1/8); % fc = 1/(2M), M is downsampling
h = fftshift(ifft2(ifftshift(H)));

% Impulse response
figure
mesh(n1, n2, h)
xlabel('m (sample)');
ylabel('n (sample)');
zlabel('h(m,n)');
title('LPF');

% Frequency response
figure
mesh(f1, f2, abs(H))
xlabel('f_1 (cycles/sample)');
ylabel('f_2 (cycles/sample)');
zlabel('|H(f_1,f_2)|');
title('LPF');

% Apply anti-aliasing filter
[hsy, hsx] = size(h);
pady = (hsy - 1) / 2;
padx = (hsx - 1) / 2;
chirp2_lpf = conv2(padarray(chirp2, [pady, padx], ...
    'both', 'symmetric'), h, 'valid');


im(chirp2_lpf);
title('Output FIR antialiasing filter')


chirp2_lpf_down4 = chirp2_lpf(1:4:end, 1:4:end);
im(chirp2_lpf_down4)
title('Downsampled by 4, with FIR antialiasing')
