%% Demonstrate a projective transform on slot car track
% Make the image look like the camera was directly overhead (orthographic)
% and map from pixels to cm
%
% Dr. Russell Hardie
% University of Dayton
% ECE 563 Image Processing

%% New method (fitgeotrans, imwarp)

% Load and display input image
load car
im(car)
title('Corner camera image')

% Select the table corners lower left, lower right, top left, top right
[X, Y] = ginput(4); % Pixel coodinates of corners of table in input pixels

% World coordinates of table (in cm)
X2 = [10, 175, 10, 175]'; % table corners in output pixels
Y2 = [1, 1, 225, 225]'; % table corners in output pixels

% Make projective transform from pixels to world
tform2 = fitgeotrans([X, Y], [X2, Y2], 'projective');

% Transform pixel image into world coordinates in cm
I_projective = imwarp(car, tform2, 'FillValues', 0);

% Display the input image
im(car)
title('Corner camera image')

% Display the transformed image
im(I_projective, 1, 1)
title('Projective image')
axis xy
axis square

%% Old method (maketform, imtransform)

% Load and display input image
load car
im(car)
title('Corner camera image')

% Select the table corners lower left, lower right, top left, top right
[X, Y] = ginput(4); % Pixel coodinates of corners of table in input pixels

% World coordinates of table (in cm)
X2 = [10, 175, 10, 175]'; % table corners in output pixels
Y2 = [1, 1, 225, 225]'; % table corners in output pixels

% Make projective transform from pixels to world
tform2 = maketform('projective', [X, Y], [X2, Y2]);

% Transform pixel image into world coordinates in cm
I_projective = imtransform(car, tform2, 'FillValues', 0, 'XYScale', 1);

% Display the input image
im(car)
title('Corner camera image')

% Display the transformed image
im(I_projective, 1, 1)
title('Projective image')
axis xy
axis square
