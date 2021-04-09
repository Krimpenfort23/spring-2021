function out = wiener_filter_2d( in, psf, NSR, pad ) 
%
% out = wiener_filter_2d( in, psf, NSR, pad ) 
%
% 2D IIR Wiener filter implemented with FFTs. Uses the constant noise to
% signal PSD ratio approximation. 
%
% Prepared for ECE 563 Image Processing with Dr. Hardie
%
% REQUIRED INPUTS
%
% in        Input image (2D array)
% psf       Degradation point spread function
% NSR       Noise to signal PSD ratio (constant)
% pad       Padding size for the FFT processing to minimize border effects
%
% OPTIONAL INPUTS
%
% OUTPUTS
%
% out.img       Output image (restored), same size as in (and aligned)
% out.HW        Wiener filter frequency response
% out.HW_mag    Wiener filter frequency response but zero centered
% out.f1        Frequency axis in x for out.HW in cyc/sample
% out.f2        Frequency axis in y for out.HW in cyc/sample
%
% Author: Evan Krimpenfort
% Date: April 9th, 2021 
%
% COPYRIGHT © 2021 EVAN KRIMPENFORT. ALL RIGHTS RESERVED.
% This is UNPUBLISHED PROPRIETARY SOURCE CODE of EVAN KRIMPENFORT; the
% contents of this file may not be disclosed to third parties, copied or
% duplicated in any form, in whole or in part, without the prior written
% permission of EVAN KRIMPENFORT.

% size of the input psf and input image
[L, K] = size(psf);
[N, M] = size(in);

% find the padding of the input image
padx = (K - 1)/2;
pady = (L - 1)/2;

% placing the extra padding
in2 = padarray(in, [pady+pad, padx+pad], 'symmetric', 'both');

% Get new size
[sy2, sx2] = size(in2);

% Take FFTs at the larger size
PSF = fft2(psf, sy2, sx2);
IN2 = fft2(in2);

% Use Wiener filter with the same exta padding
% Wiener filter in DFT domain
absPSFsquared = abs(PSF.^2);    % finding abs
out.HW = ((1 + NSR) * conj(PSF)) ./ (absPSFsquared + NSR);  % function execution
out.HW_mag = abs(fftshift(out.HW)); % finding the magnitude

% Apply Wiener filter
FHAT = out.HW .* IN2;
fhat = ifft2(FHAT);

% Crop for extra padding
out.img = fhat(pad+1:pad+N, pad+1:pad+M);

% Get frequency axis
[~, ~, out.f1, out.f2] = fftshift_samples2d([sx2, sy2]);

% end of function