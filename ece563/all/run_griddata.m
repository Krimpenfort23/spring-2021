%% Nonuniform interpolation using griddata()
%
% Dr. Russell Hardie
% University of Dayton
% ECE 563 Image Processing

addpath(genpath('../../MATLAB'));

%% delaunayTriangulation x,y points

% Random x,y points
x = rand(20, 1);
y = rand(20, 1);

% Compute the interlocking triangles making up a faceted surface
dt = delaunayTriangulation(x, y);
triplot(dt);
hold on
plot(x, y, 'rx')
xlabel('x (meters)')
ylabel('y (meters)')
title('delaunayTriangulation example')
hold off

%% delaunayTriangulation x,y,z=f(x,y)

% 2D array of x,y samples, with z=f(x,y)
x = randn(20, 20);
y = randn(20, 20);
z = sqrt(x.^2+y.^2);

% Display x,y coordinates
figure
plot(x, y, 'bo')
xlabel('x (meters)'); ylabel('y (meters)')
title('nonuniform samples')
axis equal

% Display the 3D samples x, y, z=f(x,y)
figure
stem3(x, y, z, 'bo')
xlabel('x (meters)')
ylabel('y (meters)')
zlabel('z=f(x,y)')
title('nonuniform samples')

% Perform delaunayTriangulation and siaplay triangles in x,y
figure
dt = delaunayTriangulation(x(:), y(:));
triplot(dt);

hold on
plot(x, y, 'rx')
xlabel('x (meters)')
ylabel('y (meters)')
title('nonuniform samples with delaunayTriangulation')

% Show the 3D faceted surface by connecting the triangles with their vertex
% z values
figure
tri = delaunay(x, y);
% Or extract tri from dt
% tri = dt.ConnectivityList
trimesh(tri, x, y, z)
xlabel('x (meters)')
ylabel('y (meters)')
zlabel('z=f(x,y)');
title('nonuniform samples with delaunayTriangulation')

%% griddata

[X, Y] = meshgrid(-2:.2:2);

% Display nonuniform sample locations and the uniform grid we want
figure
plot(x, y, 'bo', X, Y, 'r.')
xlabel('x (meters)'); ylabel('y (meters)')
title('nonuniform samples')
axis equal


% Run gridadata
Z = griddata(x, y, z, X, Y, 'cubic');

figure
mesh(X, Y, Z)
xlabel('x (meters)')
ylabel('y (meters)')

% Remove Nan so we can display with im()
Z_no_nan = Z;
Z_no_nan(isnan(Z)) = 0;


im(Z_no_nan, 1, 1, 2, X(1, :), Y(:, 1))
xlabel('x (meters)')
ylabel('y (meters)')
axis xy
