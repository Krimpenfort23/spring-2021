addpath(genpath('../../MATLAB'));

%% Test dft_lowpass2d.m

x = double(imread('cameraman.tif'));

im(x)
title('Input')

y = dft_lowpass2d(x,.1,.1,0);

im(y)
title('DFT masking LPF (no padding)')

y = dft_lowpass2d(x,.1,.1,100);

im(y)
title('DFT masking LPF (with padding)')


%% FIR frequency sampling


% Frequency sampling LPF FIR
N = 101;
[w1,w2,f1,f2] = fftshift_samples2d( N );
[F1,F2] = meshgrid(f1,f2); 
H = double( abs(F1) <= 0.1 & abs(F2) <= 0.1 );  
h = fftshift(ifft2(ifftshift(H)));  

% Implement with convolution
y = imfilter( x, h, 'symmetric');

im(y)
title('Frequency samping LPF FIR')


