function [psf, OTF, OTF2] = edge2psf(in, params, pitch)
%
% [ psf, OTF, OTF2 ] = edge2psf( in, params, pitch )
%
% Function to obtain PSF (and POTF from an edge image
%
% REQUIRED INPUTS
% in        Edge image (dark on left bright on right)
%
% OPTIONAL INPUTS
% params (defaults)
% params.buff = 10
% params.K = 3;
% params.psf_size = 51
% params.L = 1;
% params.verbose = 0;
%
% pitch     Detector pitch (determines units of OTF frequency as
%           cycles/unit distance).  Default = 1;
%
% OUTPUTS
% psf   2D circularly symmetrc PSF
% OTF   Cross-section of |OTF|: plot(OTF(:,1), OTF(:,2))
% OTF2  Complex 2D OTF function: mesh( OTF(:,1), OTF(:,1), abs( OTF2) )
%
% Author: Dr. Russell Hardie
% University of Dayton
% 8/9/17
% Updated 3/5/2021

% Default parameters
if nargin < 2 || isempty(params)
    params.buff = 10;
    params.K = 3;
    params.psf_size = 51;
    params.L = 1;
    params.verbose = 0;
end

% Default pitch
if nargin < 3
    pitch = 1; % cycles/sample
end

% Get edge spread function
esf = edge2esf(in, params.L, params.verbose);

% Get PSF
psf = esf2psf(esf, params.buff, params.K, params.psf_size, params.verbose);

% Normalize
psf = psf / sum(psf(:));

% Get OTF frequency axes
[~, ~, ~, ~, OTF(:, 1)] = fftshift_samples2d(params.psf_size, pitch);

% 2D OTF
OTF2 = fftshift(fft2(ifftshift(psf)));

% OTF crossection
OTF(:, 2) = abs(OTF2((params.psf_size+1) / 2, :));
