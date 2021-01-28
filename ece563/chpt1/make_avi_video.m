function make_avi_video( in, name, rate, compress )
%
% make_avi_video( in, name, rate, compress );
%
% Make an uncompressed AVI video from image sequence.
%
% REQUIRED INPUTS
% in    3D array (grayscale) or 4D array (RGB color)
%       Input must be in the 0-255 dynmaic range.  It is recast to uint8
%       inside this function.
% name  string with the file name (output is 'name.avi')
%
% OPTIONAL INPUTS
% rate          Frame rate (default = 30)
% compress      1 for 'Motion JPEG AVI', otherwise use
%               'Uncompressed AVI' for color or 'Grayscale AVI' (default)
%
% OUTPUT
% creates .avi called 'name.avi'
%
% Author: Dr. Russell Hardie
% University of Dayton
% 8/12/17, updated 3/12/20, 1/15/21
%
% COPYRIGHT © 2017 RUSSELL C. HARDIE.  ALL RIGHTS RESERVED. 

% Recast input to uint8
in = uint8(in);

% Default frame rate = 30 fps
if nargin < 3 || isempty(rate)
    rate = 30;
end

% Default no compression
if nargin < 4 || isempty(compress)
    compress = 0;
end

% Determine if grayscale or color
N = ndims(in);

if N==4 % color
    
    % Number of frames
    num_frames = size(in,4);
    
    % Create color video object
    if compress
        vidObj = VideoWriter( name, 'Motion JPEG AVI' );
    else
        vidObj = VideoWriter( name, 'Uncompressed AVI' );
    end
    
elseif N==3 % grayscale
    
    % Number of frames
    num_frames = size(in,3);
    
    % Create grayscale video object
    if compress
        vidObj = VideoWriter( name, 'Motion JPEG AVI' );
    else
        vidObj = VideoWriter( name, 'Grayscale AVI' );
    end
    
else
    
    disp('Input must be 3D or 4D')
    return
    
end

% Set frame rate and open video object
vidObj.FrameRate = rate;
open(vidObj);

% Loop over frames
for idx = 1 : num_frames
    
    if N==4 % RGB color
        
        writeVideo(vidObj, in(:,:,:,idx) );
        
    else % grayscale
        
        % Add frame to AVI
        writeVideo(vidObj, in(:,:,idx) );
        
    end
    
end

% Close avi file
close(vidObj);


