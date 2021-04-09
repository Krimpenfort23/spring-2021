%% Control point selection (cpselect) image registration
% Projective transformation
%
% Dr. Russell Hardie
% University of Dayton
% ECE 563 Image Processing

%% get control points

% Load aerial image
aerial = imread('westconcordaerial.png');
im(aerial)
title('Aerial Image')

% Load orthograhic image of same region (directly above)
ortho = imread('westconcordorthophoto.png');
im(ortho)
title('Orthorectified Image')

% Match up 4 road intersections
% Select image 1 point 1, image 2 point 1
% Select image 1 point 2, image 2 point 2
% Select image 1 point 3, image 2 point 3
% Select image 1 point 4, image 2 point 4
% Then exit control point GUI (points will be output to arrays)

% Select 4 control point pairs
[aerial_points, ortho_points] = cpselect(aerial, ortho, 'Wait', true);

%% Generate transformation parameters and apply (New MATLAB)

t_concord = fitgeotrans(aerial_points, ortho_points, 'projective');
% t_concord = fitgeotrans(aerial_points,ortho_points,'affine');
t_concord.T' % t_concord.T' looks like matrix from class notes

% Create structure with pixels and world coordinates (here the same as
% pixels)
Rortho = imref2d(size(ortho));

% Warp aerial image to match Rortho
aerial_registered = imwarp(aerial, t_concord, 'OutputView', Rortho);

im(aerial_registered)
title('Aerial Image Registered')

im(ortho)
title('Orthorectified Image')

% Show ortho and registered aerial on top of each other
figure, imshowpair(aerial_registered, ortho, 'blend')

% Find the point in Orthorectified image corresponding to Aerial
% Y - in road on the right)
[x0, y0] = transformPointsForward(t_concord, 310, 84)

% Find the point in Aerial  corresponding to Orthorectified image
[a0, b0] = transformPointsInverse(t_concord, x0, y0)

% Show aerial with point (a0,b0)
im(aerial)
title('Aerial Image')
hold on
plot(a0, b0, 'rs')

% Show orthographic image with point (x0,y0)
im(ortho)
title('Orthorectified Image')
hold on
plot(x0, y0, 'rs')

%% Old MATLAB (still works, Mathworks says not recommended)

% Get geometric transformation
tform = maketform('projective', aerial_points, ortho_points);

% tformfwd
% tforminv
[x0, y0] = tformfwd(tform, 100, 200)
[x0, y0] = tforminv(tform, 100, 200)
[x0, y0] = tformfwd(tform, x0, y0)

aerial_registered2 = imtransform(aerial, tform, 'bicubic');

im(aerial_registered2)
title('Aerial Image Registered (Old functions)')

im(ortho)
title('Orthorectified Image')

%% Apply transformation with interp2

% Aerial image size
[sya, sxa, ~] = size(aerial);

% Create uniform input grid
[Xa, Ya] = meshgrid([1:sxa], [1:sya]);

% Transform ortho image grid the hard way
[syo, sxo, ~] = size(ortho);
[Xo, Yo] = meshgrid([1:sxo], [1:syo]);
Zo = inv(t_concord.T') * [Xo(:)'; Yo(:)'; ones(1, sxo * syo)];

% Apply the projective division component
Xo2 = Zo(1, :) ./ Zo(3, :);
Yo2 = Zo(2, :) ./ Zo(3, :);

% Reshape transformed coordinate grid
Yo2 = reshape(Yo2, syo, sxo);
Xo2 = reshape(Xo2, syo, sxo);

% Evaluate points on warped grid using bilinear interpolation
out = interp2(Xa, Ya, double(aerial(:, :, 2)), Xo2, Yo2, 'bil', 0);

im(out, 1, 1)
title('Aerial (t\_concord.T, interp2)')

im(ortho, 1, 1)
title('Orthorectified Image')

%% Use transformPointsInverse with interp2

% Transform the ortho image grid the easy way
[Xo2, Yo2] = transformPointsInverse(t_concord, Xo, Yo);

% Evaluate points on warped grid using bilinear interpolation
out = interp2(Xa, Ya, double(aerial(:, :, 2)), Xo2, Yo2, 'bil', 0);

im(out, 1, 1)
title('Aerial (transformPointsInverse, interp2)')

im(ortho, 1, 1)
title('Orthorectified Image')
