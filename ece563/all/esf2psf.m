function psf = esf2psf(esf, buff, K, psf_size, verbose)
%
% psf = esf2psf( esf, buff, K, psf_size, verbose )
%
% Creates a point spread function from an edge spread function.  The edge
% spread function can come from sfrmat2.m for example.  Assumes PSF is
% circularly symmetric.
%
% REQUIRED INPUTS
%
% esf           1D array with edge spread function (must go low to high
%               left to right!)
%
% OPTIONAL INPUTS
%
% buff          Maximum size of flat part of edge on both sides (before
%               edge starts to roll off).  Default = 10% of esf length.
%
% K             Number of samples either side of the edge midline that we
%               expect to be equally spaced when resampling the esf to
%               center the edge.  default = 1.
%
% psf_size      Dimension of the output psf (x and y).  Must be odd.
%               Default = 15.
%
% verbose       Flag to output a variety of plots.  Default = 1.
%
% OUTPUT
%
% psf           2D psf_size x psf_size system point spread function.
%
% Author: Dr. Russell C. Hardie
% 8/25/08
% 3/5/2021
%
% COPYRIGHT © 2008 RUSSELL C. HARDIE.  ALL RIGHTS RESERVED. This is
% UNPUBLISHED PROPRIETARY SOURCE CODE of Russell C. Hardie; the contents of
% this file may not be disclosed to third parties, copied or duplicated in
% any form, in whole or in part, without the prior written permission of
% Russell C. Hardie.


N = length(esf);

% Defaults
if nargin < 2
    buff = round(.1*N);
    K = 1;
    psf_size = 15;
    verbose = 1;
elseif nargin < 3
    K = 1;
    psf_size = 15;
    verbose = 1;
elseif nargin < 4
    psf_size = 15;
    verbose = 1;
elseif nargin < 5
    verbose = 1;
end

% Get the edge values (low, high and middle, ignoring buff on each end)
low = mean(esf(1:buff));
high = mean(esf(end -buff:end));
mid = (high + low) / 2;

% Find resampling offset that makes K samples symmetric about the midline
offset = linspace(0, 1, 100);
for k = 1:length(offset)

    esf_int = interp1([1:N], esf, [1:N]+offset(k), 'pchip', 'extrap');
    % Calculate symmetry about this midpoint out K samples
    before_idx = max(find(esf_int < mid));
    error = 2 * mid - esf_int(before_idx:-1:before_idx-K) - ...
        esf_int(before_idx+1:before_idx+1+K);
    mae(k) = mean(abs(error));

end

% Pick the offset that minimizes asymmetry about the midline for the K
% samples
[min_val, min_idx] = min(mae);
offset_use = offset(min_idx);

% Apply the best resmapling
esf_int = interp1([1:N], esf, [1:N]+offset_use, 'pchip', 'extrap');

% Get the derivative of the ESF
dir_esf_int = diff(esf_int);


L = length(dir_esf_int);

% Take only the right side and repeat for forced symmetry.
% The symmetric line spread is circularly shifted such that
% it is "zero centered" removing any linear phase.
% Due to the symmetry, and no linear phase, the FFT is real valued!
[mx, mxi] = max(dir_esf_int);


%%%% This code uses the bright half of the edge and folds for symmetry %%%%
% LR=L-mxi+1; % length from max to right edge
% right=dir_esf_int(mxi:L);
% left=fliplr(right); % includes center sample again
%
% % Symmetric line spread function.  Remove 2nd center sample (LR-1).
% dir_esf_int2=[right, left(1:LR-1)];  % circ shift so FFT is real
% L2=2*LR-1; % new total length
% dir_esf_int_sym=[left(1:LR-1),right ];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%% This code uses the dark half of the edge and folds for symmetry %%%%%
LR = mxi; % length from max to right edge
left = dir_esf_int(1:LR);
right = fliplr(left); % includes center sample again

% Symmetric line spread function.  Remove 2nd center sample (LR-1).
dir_esf_int2 = [right, left(1:LR - 1)]; % circ shift so FFT is real
L2 = 2 * LR - 1; % new total length
dir_esf_int_sym = [left(1:LR - 1), right];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Take transform of the line response profile
% which should be the H(u,0) of the system frequency response.
DIR_ESF_INT2 = real(fftshift(fft(dir_esf_int2)));

% Spin the H(u,0) assuming circular symmetry
H = gencircsym(DIR_ESF_INT2((L2+1) / 2:L2), 0);

% Take inverse transform, to get PSF
psf = fftshift(ifft2(ifftshift(H)));

% Crop
S = (psf_size - 1) / 2;
middle = (L2 + 1) / 2;
psf = psf(middle-S:middle+S, middle-S:middle+S);

% Normalize for DC response of 1
psf = psf / sum(psf(:));


if verbose

    % Edge spread function
    figure
    plot([1:N], esf, 'b-o', [1, N], [mid, mid], 'r-')
    xlabel('n'); ylabel('esf(n)')
    title('Edge Spread Function')
    legend('ESF', 'Midline')

    % Edge spread function (symmetric)
    figure
    plot([1:N], esf_int, 'b-o', [1, N], [mid, mid], 'r-')
    xlabel('n'); ylabel('esf(n)')
    title('Edge Spread Function (Resampled for Symmetry)')
    legend('ESF', 'Midline')

    % Line spread function
    figure
    plot(dir_esf_int, 'b-o')
    xlabel('n'); ylabel('esf(n)')
    title('Line Spread Function (Derivative of ESF)')

    % Line spread function (forced symmetric)
    figure
    plot(dir_esf_int_sym, 'b-o')
    xlabel('n'); ylabel('esf(n)')
    title('Line Spread Function (Forced Symmetric)')

    % H(u,0)
    figure
    plot(linspace(-.5, .5, length(DIR_ESF_INT2)), DIR_ESF_INT2);
    title('DTFT of Line Response, H(u,0)');
    xlabel('u (cycles/sample)')
    ylabel('H(u,0)')

    % Circularly symmetric H(u,v)
    figure
    uv = linspace(-.5, .5, L2);
    mesh(uv, uv, H);
    title('Spun DTFT of Line Response, H(u,v)');
    axis tight
    xlabel('u (cycles/sample)')
    ylabel('v (cycles/sample)')
    zlabel('H(u,v)')

    % Circularly symmetric PSF
    figure
    mesh(-S:S, -S:S, psf)
    xlabel('m');
    ylabel('n');
    zlabel('h(m,n)');
    title('2D PSF')
    axis tight

end
