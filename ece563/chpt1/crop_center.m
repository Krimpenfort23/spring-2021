function out = crop_center( in, wsx, wsy, cx, cy )
%
% out = crop_center( in, wsx, wsy, cx, cy  );
%
% Crops a wsy x wsx portion of an array centered about cy,cx
%
% REQUIRED INPUTS
% in        Input array of dimensions 1, 2 or 3
% wsx       Window size in x (odd integer)
% wsy       Window size in y (odd integer)
%
% OPTIONAL INPUTS
% cx        Center in x (default = floor( (size(in,2)+1)/2 );
% cy        Center in y (default = floor( (size(in,1)+1)/2 );
%
% OUTPUT
% out       Cropped array (crops in dimension 1 and/or 2)
%
% Author: Dr. Russell C. Hardie
% University of Dayton
% 2015
%
% COPYRIGHT © 2015 RUSSELL C. HARDIE.  ALL RIGHTS RESERVED. 


% Get input size
[sy,sx,~] = size(in);

% Default cx
if nargin <  4 || isempty( cx )
    cx = floor( (sx+1)/2 );
end

% Default cy
if nargin <  5 || isempty( cy )
    cy = floor( (sy+1)/2 );
end

% Half width
half_width_y = (wsy+1)/2;
half_width_x = (wsx+1)/2;

% Start coordinates
sty = cy - half_width_y;
stx = cx - half_width_x;

% Crop array in dimensions 1 and/or 2
out = in( sty+1: sty+wsy,  stx+1: stx+wsx, : );


