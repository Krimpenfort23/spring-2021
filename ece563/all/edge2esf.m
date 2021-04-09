function [esf, x, y, desired_x] = edge2esf(edge, L, show_plot)
%
% [esf, x, y, desired_x] = edge2esf( edge, L, show_plot );
%
% Generates an edge spread function on a supersampled grid from a slant
% edge.
%
% REQUIRED INPUTS
% edge      Edge image
% L         Upsampling factor (relative to edge)
%
% OPTIONAL INPUTS
% show_plot If 1, generates analysis plot
%
% OUTPUTS
% esf       Supersampled edge spreaf function amplitude values
% x         X xalue determined from all the edge data
% y         Corresponding Y values from all the edge data
% desired_x Fractional X values corresponding to esf
%
% Author: Dr. Russell Hardie
% 2/22/10
%
% COPYRIGHT © 2010 RUSSELL C. HARDIE.  ALL RIGHTS RESERVED. This is
% UNPUBLISHED PROPRIETARY SOURCE CODE of Russell C. Hardie; the contents of
% this file may not be disclosed to third parties, copied or duplicated in
% any form, in whole or in part, without the prior written permission of
% Russell C. Hardie.

%% Segment edge image into bright and dark

idx = kmeans(edge(:), 2, 'EmptyAction', 'singleton'); % statistics toolbox required
high = mean(edge(idx == 2));
low = mean(edge(idx == 1));
segmented = edge > (high + low) / 2;

%% get edge line equation (slope and intercept)

% Get size into
[sy, sx] = size(edge);

for row = 1:sy
    line.y(row) = row;
    line.x(row) = min(find(segmented(row, :)));
end

P = polyfit(line.y, line.x, 1);

% Get the fractional col (x) offset for each row
col_offset = polyval(P, [1:sy]);
avg_offset = mean(col_offset);

%% Create array from all rows with all edge amplitude and registered positional information

x = zeros(1, sx*sy);
y = zeros(1, sx*sy);

for idx = 1:sy

    y((idx-1)*sx+1:idx*sx) = edge(idx, :);
    x((idx-1)*sx+1:idx*sx) = [1:sx] - col_offset(idx) + avg_offset;

end

%% Bin the samples and average to get the output at each desired x value

desired_x = [1:1 / L:sx];
binx = (1 / (2 * L));
esf = zeros(size(desired_x));

for idx = 1:length(desired_x)

    I = x <= desired_x(idx)+binx & x > desired_x(idx)-binx;
    esf(idx) = mean(y(I));

end

%% Plots

if nargin < 2
    show_plot = 0;
end

if show_plot == 1

    figure
    plot(x, y, 'r.', desired_x, esf, 'b-')
    xlabel('x')
    ylabel('y')
    title('Edge Data')
    legend('Registered Samples', 'ESF', 'Location', 'SouthEast')

end
