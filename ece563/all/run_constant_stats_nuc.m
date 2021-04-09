%% Constant statistics NUC
%
% Author: Dr. Russell Hardie
% University of Dayton
% ECE 563
%
% Revision history:
% 3/2/2021 updated

%% Load and display image

cl

x = double(imread('concordorthophoto.png'));

im(x);
title('Input Image')

%% Simulate nonuniformity (fixed pattern noise)

% Get size info
x = x(1:512, 1:512);
[sy, sx] = size(x);
num_frames = 100;

% Generate random camera shifts
motion_xy = randn(num_frames, 2) * 100;
motion_xy = round(conv2(motion_xy, ones(21, 1) / 21, 'same'));
motion_xy(1, :) = [0, 0];

% Fixed pattern bias
b = randn(sy, sx) * 40;

out = zeros(sy, sx, num_frames);
for k = 1:size(motion_xy, 1)

    % Use MATLAB's circshift to simulate camera shift jitter
    out(:, :, k) = circshift(x, [motion_xy(k, 1), motion_xy(k, 2)]) + b;

end

% Display image stack
figure
sliceViewer(out (101:end - 100, 101:end - 100, :), 'DisplayRange', [0, 255])
title('Sequence with Fixed Pattern Noise')

%% References

% Constant statictics nonuniformity correction
% @ARTICLE{harrisc,
%         AUTHOR             = {J. G. Harris and Y.-M. Chiang},
%         JOURNAL            = {Proceedings of the SPIE Aerospace/Defense
% Sensing and Controls, 1997,
% Infrared Technology and Applications XXIII, B. F. Anderson and M.
%  Strojnik, eds.},
%         TITLE              = {Nonuniformity correction
% using constant average  statistics constraint:
% Analog and digital implementations},
%         VOLUME             = {3061},
%         YEAR               = {1997},
% 	PAGES		= {895-905}

% R. C. Hardie, F. Baxley, B. Brys, P. Hytla, “Scene-based Nonuniformity
% Correction with Reduced Ghosting Using a Gated LMS Algorithm,” OSA Optics
% Express, Vol. 17, No. 17, pp. 14918-14933, August 2009.

%% Apply constant statistics NUC

% Estimate temporal statistics
temporal_mean = mean(out, 3);
temporal_std = std(out, [], 3);

% Apply correction to frame 1
nuc1 = (out(:, :, 1) - temporal_mean) ./ temporal_std;

% Display cropped images to remove any circshift wrap
crp = 100;

im(x(crp + 1:end - crp, crp + 1:end - crp))
title('True Frame 1')

im(out(crp + 1:end - 100, 101:end - crp, 1))
title('Frame 1 with Nonuniformity')

im(nuc1(crp + 1:end - crp, crp + 1:end - crp))
title('Frame 1 with Constant Statistics NUC')
