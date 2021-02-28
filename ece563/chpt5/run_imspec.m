addpath(genpath('..\..\MATLAB\'));

%% show image spectra for two images

x = double(imread('cameraman.tif'));
imspec( x );

y = double(imread('board.tif'));
y = y(:,:,2);
imspec( y );


%% Add striping noise

imspec( x, 1000 );


x = double(imread('cameraman.tif'));
x2 = x;
x2(:, 1:4:end ) = x(:, 1:4:end ) + 20;
im(x2)

imspec( x2, 1000 );


%% swap magnitude and phase between two images


x = double(imread('cameraman.tif'));
y = double(imread('board.tif'));

y = y(1:256,1:256,2);

imswapspec(x,y);



