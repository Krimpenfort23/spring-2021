function rxx = est_corr(in, ws, plot_flag, order)
%
% rxx = est_corr( in, ws, plot_flag, order );
%
% Estimate the 2D autocorrelation for input image.
%
% REQUIRED INPUTS
%
% in        "desired" ideal image
% ws        2*ws+1 x 2*ws+1 = size of autocorrelation output
%
% OPTIONAL INPUTS
%
% plot_flag (Optional)  1 to display plots, else no display
%
% order (optional) (default = 5)  Polynomial order for fitting
%
% OUTPUT
%
% rxx.x          X coordinates of autocorrelation (pixels)
% rxx.y          Y coordinates of autocorrelation (pixels)
% rxx.z_circ     Autocorrelation assuming circularly symmetric
% rxx.z_raw      2D autocorrelation
% rxx.radial     Radial autocorrelation function
% rxx.P          Radial polynomial coefficients
%
% Author: Dr. Russell Hardie
% University of Dayton
% 6/4/06, 6/7/06, 1/12/07, 11/10/17
%
% COPYRIGHT © 2006 THE UNIVERSITY OF DAYTON.  ALL RIGHTS RESERVED.


% Get size info
[sy, sx] = size(in);

% Crop input image
in2 = in(ws+1:sy-ws, ws+1:sx-ws);
[sy2, sx2] = size(in2);

% Compute correlations by sliding in2, multiplying and taking average
for i = 1:2 * ws + 1
    for j = 1:2 * ws + 1

        shy = i - ws - 1;
        shx = j - ws - 1;
        temp = in(ws+1-shy:ws+1-shy+sy2-1, ...
            ws+1-shx:ws+1-shx+sx2-1) .* in2;
        rxx.z_raw(i, j) = mean(temp(:));

    end
    i
end

% Force circularly symmetric
rxx.x = [-ws:1:ws];
rxx.y = [-ws:1:ws];
[XX, YY] = meshgrid(rxx.x, rxx.y);
D = sqrt(XX.^2+YY.^2);

if nargin > 3 && ~isempty(order)
    rxx.P = polyfit(D(:), rxx.z_raw(:), order);
else
    rxx.P = polyfit(D(:), rxx.z_raw(:), 5);
end

rxx.radial = polyval(rxx.P, [0: ws]);
% rxx.z_circ = gencircsym(rxx.radial,min(rxx.radial));
rxx.z_circ = gencircsym(rxx.radial, 0);

%---------%
% Display %
%---------%

if nargin > 2 && plot_flag == 1

    figure
    plot(D(:), rxx.z_raw(:), 'b.', ...
        [0: ws], rxx.radial, 'r-o');
    xlabel('Distance (pixels)')
    ylabel('Autocorrelation')
    legend('Sample', 'Polynomial Fit')
    title('Autocorrelation Polynomial Fit')

    figure
    mesh(rxx.x, rxx.y, rxx.z_raw)
    xlabel('m (pixels)')
    ylabel('n (pixels)')
    zlabel('r_{f,f}(m,n)')
    title('Raw Autocorrelation')

    figure
    mesh(rxx.x, rxx.y, rxx.z_circ)
    xlabel('m (pixels)')
    ylabel('n (pixels)')
    zlabel('r_{f,f}(m,n)')
    title('Circularly Symmetric Autocorrelation')

end
