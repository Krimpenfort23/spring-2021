function error = dif( in1, in2, mask, norm_type, peak_type )
%
% error = dif( in1, in2, mask, norm_type, peak_type )
%
% Error metrics between two arrays of arbitrary (but matching) dimensions.
% MAE, MSE, PSNR, SNR and average error.  This version allows you to
% compare the arrays only in the area in 'mask' and has normalization
% options.
%
% Note: MATAB has builtin psnr( ) and ssim( ) metrics as well in the image
% processing toolbox
%
% REQUIRED INPUTS
% in1, in2      Input arrays to be compared (same but arbitrary dimensions)
%               in1 is considered the truth or reference array
%
% OPTIONAL INPUTS
% mask          Binary mask showing the area to compute the error over
%               (default uses entire array)
%
% norm_type     0 or empty for no normalization (default)
%               1 for mean normalization
%               2 for std normalization
%               3 for mean and std normalization
%
% peak_type     'max'       max( in1(:) ) (default)
%               'range'     range( in1(:) )
%               otherwise --> peak_value = peak_type
% 
% OUTPUTS
% error.mae		Average absolute error
%
% error.mse		Average squared error
%
% error.psnr_dB    Peak signal-to-noise ratio assuming in1 is true signal
%    error.psnr_dB = 20*log10( peak_value of in1 ) / sqrt( error.mse ) );
% See 'peak_type'
%
% error.snr_dB		Signal-to-Noise ratio assuming in1 is true signal
%		error.snr_dB = 10*log10( var(in1) / var(difference) );
%
% error.avg     Error average so you can see if your estimate is biased
%
% EXAMPLE
% x = imread(  'cameraman.tif' );
% y = conv2_frames(x,ones(3,3)/9);
% dif(x,y,[],0,255)
% same as:  psnr( double(y), double(x), 255 )
%
% Author: Dr. Russell C. Hardie
% University of Dayton
% 2001
%
% Modification history:
% Based on dif.m 5/22/01
% Modified 12/10/07 (error.psnr2_dB using range).
% Modified 4/15/09 with mask option
% Normalization 11/4/10
% Added peak_type and norm_type, renamed to dif.m 7/7/2020
%
% COPYRIGHT © 2001 RUSSELL C. HARDIE.  ALL RIGHTS RESERVED. 


% Default mask 
if nargin < 3 || isempty(mask)
    I = true(size(in1));
else
    I = logical(mask);
end

% Default norm_type
if nargin < 4 || isempty( norm_type )
    norm_type = 0;
end

% Default peak_type
if nargin < 5 || isempty( peak_type )
    peak_type = 'max';
end


% Extract the pixels to be used
in1 = double(in1(I));
in2 = double(in2(I));

% Do normalization (mean, std)
switch( norm_type )
    case 1
        in2 = in2 - mean(in2) + mean(in1);
    case 2
        in2 = std(in1) * ( in2 / std(in2) );
    case 3
        in2 = std(in1) * ( in2 / std(in2) );
        in2 = in2 - mean(in2) + mean(in1);
end

% Get signal peak from in1
switch( peak_type )
    case 'max'
        peak_in1 = max( in1 );
    case 'range'
        peak_in1 = range( in1 );
    otherwise
        peak_in1 = peak_type;
end

% Compute difference
temp = in2 - in1;

% Compute mean absolute error (MAE)
error.mae = mean( abs( temp ) );

% Compute mean squared error (MSE)
error.mse = mean( temp.^2 );

% Peak signal-to-noise ration (PSNR) (dB)
error.psnr_dB = 20*log10( peak_in1 / sqrt( error.mse ) );

% Simple variance ratio (SNR) (dB) 
error.snr_dB = 10*log10( var(in1) / var(temp) );

% Average difference (bias) - mean normalization will eliminate
error.avg = mean( temp );

