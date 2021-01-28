function rgb = yuy2rgb(yuy)
%
% Converts YUY format from webcam to RGB format.  Will work on single frame
% or mutiple frames.
%
%  rgb = yuy2rgb(yuy);
%
% REQUIRED INPUTS
% yuy       YUY format frame (3D) or video (4D), with frame index dim 4.
%
% OUTPUTS
% rgb       RGB output, same size as input
%
% Author: Dr. Russell Hardie
% University of Dayton
% 3/7/09


% Initialize output
rgb = yuy;

% Overwrite output with transformed color coordinates
rgb(:,:,3,:) = 1.164*(yuy(:,:,1,:) - 16) + 2.018*(yuy(:,:,2,:) - 128); % B
rgb(:,:,2,:) = 1.164*(yuy(:,:,1,:) - 16) - 0.813*(yuy(:,:,3,:) - 128) - 0.391*(yuy(:,:,2,:) - 128); % G
rgb(:,:,1,:) = 1.164*(yuy(:,:,1,:) - 16) + 1.596*(yuy(:,:,3,:) - 128); % R
