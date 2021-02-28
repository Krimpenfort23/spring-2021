function out = dft_lowpass2d(in,fcx,fcy,pad);
%
% 2D Low-pass filter implemented using DFT Masking
%
% REQUIRED INPUTS
% in        Input image
% fcx, fcy  Cut-off frequencies in cycles/sample (0-.5)
%
% OPTIONAL INPUTS
% pad       Padding to reduce circular convolution artifacts 
%           (default = 0)
%
% OUTPUT
% out       Filtered image
%
% Author: Dr. Russell Hardie
% University of Dayton
% 9/16/17

if nargin < 4
    pad = 0;
end

% pad input
in = padarray( in, [pad,pad], 'both', 'symmetric' );

% Input image size
[sy,sx] = size(in);

% FFT of input
IN = fft2(in);

% LPF mask
[~,~,f1,f2] = fftshift_samples2d( [sx,sy] );
[F1,F2] = meshgrid(f1,f2);
MASK = ifftshift( double( abs(F1) < fcx & abs(F2) < fcy ) );

% Get output
out = real(ifft2(IN.*MASK));
out = out(pad+1:end-pad, pad+1:end-pad);

