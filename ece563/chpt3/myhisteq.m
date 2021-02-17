function [out,F,h,x] = myhisteq(in,L)
%
% [out,F,h,x] = myhisteq(in,L);
%
% My histogram equalization function. Takes an L level input image 'in'
% (must be integer) and maps it to an L Level output with an approximately
% flat histogram.
%
% REQUIRED INPUTS
% in        Input array (any dimensions)
% L         The number of levels in the input image (e.g., 2^8 for 8
%           bit image)
%
% OUTPUTS
% out       Equalized image (L levels)
% F         Mapping function
% h         Input image histogram value
% x         Input image histogram bins
%
% Author: Dr. Russell Hardie
% University of Dayton
% 3/20/02, revised 1/15/07, 8/12/08
% 1/25/2021 changed hist() to histcounts()
%
% COPYRIGHT © 2002, 2008 RUSSELL C. HARDIE.  ALL RIGHTS RESERVED. This is
% UNPUBLISHED PROPRIETARY SOURCE CODE of Russell C. Hardie; the contents of
% this file may not be disclosed to third parties, copied or duplicated in
% any form, in whole or in part, without the prior written permission of
% Russell C. Hardie. 


% Get input size
N = length(in(:));

% Get input image histogram
x = [0:L-1];
h = histcounts( in(:), x )/N;

% Form histogram equalization mapping function
F = cumsum(h);

% Map input image to get output
out = (L-1)*F(round(in)+1);
