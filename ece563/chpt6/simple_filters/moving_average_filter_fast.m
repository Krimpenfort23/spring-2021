function out = moving_average_filter_fast(x, ma_size, pad_type)
%
% out = moving_average_filter_fast( x, ma_size, pad_type )
%
% Performs 2D moving average FIR filter.
%
% REQUIRED INPUTS
% x                 2D image to be processed (double precision)
% ma_size           Window size (2*ma_size+1) x (2*ma_size+1)
%
% OPTIONAL INPUTS
% pad_type         'symmetric','replicate','circular' (default='symmetric')
%
% OUTPUT
% out               2D processed image
%
% Author: Dr. Russell Hardie
% 8/1/07
% 8/15/07 (modified window size as (2*ma_size+1) x (2*ma_size+1)
% versus ma_size x ma_size
% 8/1/08 Compute MA using cumsum for speed on large windows
%
% COPYRIGHT © 2007 RUSSELL C. HARDIE.  ALL RIGHTS RESERVED. This is
% UNPUBLISHED PROPRIETARY SOURCE CODE of Russell C. Hardie; the contents of
% this file may not be disclosed to third parties, copied or duplicated in
% any form, in whole or in part, without the prior written permission of
% Russell C. Hardie.

if ma_size < 1

    out = x;

else

    % Default array padding
    if nargin < 3
        pad_type = 'symmetric';
    end

    % Pad input array
    x_pad = padarray(x, [ma_size + 1, ma_size + 1], pad_type, 'both');

    % cumsum image
    sum_y = cumsum(x_pad, 1);
    sum_both = cumsum(sum_y, 2);

    % Get MA by combining cumsum image corners of MA window
    out = circshift(sum_both, [ma_size, ma_size]) ...
        -circshift(sum_both, [ma_size, -ma_size - 1]) ...
        -circshift(sum_both, [-ma_size - 1, ma_size]) ...
        +circshift(sum_both, [-ma_size - 1, -ma_size - 1]);

    % Normalize and crop
    out = out(ma_size+1:end-ma_size-2, ma_size+1:end-ma_size-2) ...
        / ((2 * ma_size + 1).^2);

end