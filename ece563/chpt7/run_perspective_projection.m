%% Demonstrate perspective projection details
% Code allows for non-planar scene
%
% Dr. Russell Hardie
% University of Dayton
% ECE 563 Image Processing

%% Initialize script file

addpath(genpath('../../MATLAB/'))

cl

ppt_flag = 1;

%% Set up world coordinates

% Read image
orthophoto = double(imread('westconcordorthophoto.png'));

% Get size
[sy, sx] = size(orthophoto);

% Specify a ground sample distance (GSD)
gsd = 1;

% Create ground (world) X,Y coordinates
[X, Y] = meshgrid(linspace(0, (sx - 1) * gsd, sx), linspace(0, (sy - 1) * gsd, sy));

%  Specify Z coordinates (could use a digital elevation model here)
Z = zeros(size(X));

% Display scene with MATLAB's surface command
figure
surface(X, Y, Z, orthophoto)
colormap(gray(256));
shading interp
axis xy
view(-30, 25)
grid
xlabel('X (meters)')
ylabel('Y (meters)')
zlabel('Z (meters)')
hold on

% Display coordinate unit vectors
unit_scale = 100;
plot3(unit_scale*(.1 + [0, 1]), unit_scale*(.1 + [0, 0]), unit_scale*(.1 + [0, 0]), 'b-', ...
    unit_scale*(.1 + [0, 0]), unit_scale*(.1 + [0, 1]), unit_scale*(.1 + [0, 0]), 'g-', ...
    unit_scale*(.1 + [0, 0]), unit_scale*(.1 + [0, 0]), unit_scale*(.1 + [0, 1]), 'r-');

%% Camera position and angle

% Camera position in x,y,z
Tx = -100;
Ty = -100;
Tz = 200;

% Camera angle
anglex = -125;
angley = 0;
anglez = 40;

%  x, y, z (down)
r = 1;
in = r * [1, 0, 0; ...
    0, 1, 0; ...
    0, 0, 1];

[out, R] = rotation_matrix(in, pi*anglex/180, pi*angley/180, pi*anglez/180);
camerax = out(:, 1);
cameray = -out(:, 2); % invert y axis  (RH world to LH camera so Y is up)
camera_point = out(:, 3);

% Camera position
plot3(Tx, Ty, Tz, 'bo')

% Camera coordinate unit vectors
plot3(Tx+unit_scale*[0, camerax(1)], Ty+unit_scale*[0, camerax(2)], Tz+unit_scale*[0, camerax(3)], 'b-', ...
    Tx+unit_scale*[0, cameray(1)], Ty+unit_scale*[0, cameray(2)], Tz+unit_scale*[0, cameray(3)], 'g-', ...
    Tx+unit_scale*[0, camera_point(1)], Ty+unit_scale*[0, camera_point(2)], Tz+unit_scale*[0, camera_point(3)], 'r-');
title_text = 'Samples in 3D World Coordinates';
title(title_text)

%% Rotate grid to camera coordinates

% Map world to camera coordinates
R2 = R';
XX = R2 * [X(:)' - Tx; Y(:)' - Ty; Z(:)' - Tz];
X2 = XX(1, :);
Y2 = -XX(2, :);
Z2 = XX(3, :);

% Show subsampled world coordinate sample locations on world coordinates
figure
skip = 30;
Xsmall = X(1:skip:end, 1:skip:end);
Ysmall = Y(1:skip:end, 1:skip:end);
Zsmall = Z(1:skip:end, 1:skip:end);
plot3(Xsmall(:), Ysmall(:), Zsmall(:), 'm.')
grid
hold on
plot3(unit_scale*(.1 + [0, 1]), unit_scale*(.1 + [0, 0]), unit_scale*(.1 + [0, 0]), 'b-', ...
    unit_scale*(.1 + [0, 0]), unit_scale*(.1 + [0, 1]), unit_scale*(.1 + [0, 0]), 'g-', ...
    unit_scale*(.1 + [0, 0]), unit_scale*(.1 + [0, 0]), unit_scale*(.1 + [0, 1]), 'r-');
plot3(Tx+unit_scale*[0, camerax(1)], Ty+unit_scale*[0, camerax(2)], Tz+unit_scale*[0, camerax(3)], 'b-', ...
    Tx+unit_scale*[0, cameray(1)], Ty+unit_scale*[0, cameray(2)], Tz+unit_scale*[0, cameray(3)], 'g-', ...
    Tx+unit_scale*[0, camera_point(1)], Ty+unit_scale*[0, camera_point(2)], Tz+unit_scale*[0, camera_point(3)], 'r-');
xlabel('X (meters)')
ylabel('Y (meters)')
zlabel('Z (meters)')
title_text = 'Samples in 3D World Coordinates';
title(title_text)

% World points as seen in camera x,y,z
figure
X2square = reshape(X2, sy, sx);
Y2square = reshape(Y2, sy, sx);
Z2square = reshape(Z2, sy, sx);
X2small = X2square(1:skip:end, 1:skip:end);
Y2small = Y2square(1:skip:end, 1:skip:end);
Z2small = Z2square(1:skip:end, 1:skip:end);
plot3(X2small(:), Y2small(:), Z2small(:), 'm.')
grid
xlabel('X (meters)')
ylabel('Y (meters)')
zlabel('Z (meters)')
title_text = 'Samples in 3D Camera Coordinates';
title(title_text)

% World points as seen in camera x,y space
figure
plot(X2small(:), Y2small(:), 'm.')
xlabel('X (meters)')
ylabel('Y (meters)')
title_text = 'Samples in 2D Camera Coordinates (Orthographic Projection)';
title(title_text)

% World points as seen in camera with perspective
figure
plot(X2small(:)./Z2small(:), Y2small(:)./Z2small(:), 'm.')
xlabel('X (meters)')
ylabel('Y (meters)')
title_text = 'Samples in 2D Camera Coordinates (Perspective Projection)';
title(title_text)

%% Show image formation from camera (orthographic)

minx = min(X2square(:));
maxx = max(X2square(:));
miny = min(Y2square(:));
maxy = max(Y2square(:));

xi = linspace(minx, maxx, 301);
yi = linspace(miny, maxy, 301);

[XI, YI] = meshgrid(xi, yi);
ZI = griddata(X2square, Y2square, orthophoto, XI, YI);
ZI(isnan(ZI)) = 0;

im(ZI, 1, 1, 2, xi, yi);
axis xy
xlabel('X (meters)')
ylabel('Y (meters)')
title_text = 'Samples in 2D Camera Coordinates (Orthographic Projection)';
title(title_text)

%% Show image formation from camera (perspective)

X2perspective = X2square ./ Z2square;
Y2perspective = Y2square ./ Z2square;

minx = min(X2perspective(:));
maxx = max(X2perspective(:));
miny = min(Y2perspective(:));
maxy = max(Y2perspective(:));

xi = linspace(minx, maxx, 301);
yi = linspace(miny, maxy, 301);

[XI, YI] = meshgrid(xi, yi);
ZI = griddata(X2perspective, Y2perspective, orthophoto, XI, YI);
ZI(isnan(ZI)) = 0;

im(ZI, 1, 1, 2, xi, yi);
axis xy
xlabel('X (meters)')
ylabel('Y (meters)')
title_text = 'Samples in 2D Camera Coordinates (Perspective Projection)';
title(title_text)

%% Save figures in PPT presentation

if ppt_flag
    make_ppt('run_perspective_projection.ppt');
end
