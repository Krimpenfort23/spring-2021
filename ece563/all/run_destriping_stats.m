%% Run destriping using spatial statistics
%
% Author: Dr. Russell Hardie
% University of Dayton
% ECE 563
%
% Revision history:
% 3/2/2021 updated

%% Path and read data

% Nonuniformity correction
% https://sites.google.com/a/udayton.edu/rhardie1/research/nonuniformity-correction

% B. Narayanan, R. C. Hardie, R. A. Muse, "Scene-based nonuniformity
% correction technique that exploits knowledge of the focal-plane array
% readout architecture,” Applied Optics, Volume 44, No. 17, June 2005 , pp.
% 3482-3491.

cl

% Load image
name = 'njolov2.gif';
x = double(imread(name));

% First row and column are bad
x = x(2:end, 2:end);
[sy, sx] = size(x);

% Display image
im(x);
title(name);

% Show image spectrum using Chp. 5 custom tool
imspec(x)

% Show image historgram
figure
hist(x(:), 50);

% Clip the outliers
x(x > 100) = 100;

% Display modified histogram
figure
hist(x(:), 50);

%% Compute stats and correct

% Get the column means
col_mean = mean(x, 1);

% Display column means
figure
plot(col_mean, 'b-o');
xlabel('Column Number');
ylabel('Column Average (DU)')

% Pattern is periodic
% every 7'th column seems to go through same readout amplifier
period = 7;

% Extract every 7'th column and average together
for k = 1:period
    M(k) = mean2(x(:, k:period:end));
end

% Create a bias image using M
M2 = repmat(M, [sy, ceil(sx / period)]);
M2 = M2(:, 1:sx);

% Correct the image by subtracting the bias image
out = x - M2;

% Display the images
im(M2);
title('Estimated Bias Image')

im(x);
title('Input Image');

im(out);
title('Output Image');

%% Apply to a second image

% Load the second image
name = 'l0r_b6_lg.gif';
x = imread(name);

% Rotate to make stripes be columns so we can reuse code above
x = double(x');

% Display image
im(x);
title(name)

% Show image spectrum using Chp. 5 custom tool
imspec(x)

% Get image size
[sy, sx] = size(x);

% Pattern is periodic
% every 8'th column seems to go through same readout amplifier
period = 8;

% Get the column means
col_mean = mean(x, 1);

% Plot the column means
figure
plot(col_mean, 'b-o');
xlabel('Column Number');
ylabel('Column Average (DU)')

% Groupd like columns and get the collective mean
for k = 1:period
    M(k) = mean2(x(:, k:period:end));
end

% Form a bias image using M
M2 = repmat(M, [sy, ceil(sx / period)]);
M2 = M2(:, 1:sx);

% Correct the image
out = x - M2;

% Display the images
im(M2);
title('Estimated Bias Image')

im(x);
title('Input Image');

im(out);
title('Output Image');
