%% Create synthetic noise sequence and display

% Load cameraman still image
x = double(imread('cameraman.tif'));

% Replicate to make image sequence
x = repmat( x,[1,1,100] );

% Add noise os std=20 DUs
x = x + randn(size(x))*20;

% Display image sequence with implay
handle = implay( x );

% Set the colormap grayscale range for implay
handle.Visual.ColorMap.UserRange = 256;
handle.Visual.ColorMap.UserRangeMin = 0;
handle.Visual.ColorMap.UserRangeMax = 255;


%% Read and diaplay 'xylophone.mp4'

% Construct a multimedia reader object associated with file 
% 'xylophone.mp4'.
readerobj = VideoReader('xylophone.mp4');
 
% Read in all video frames.
vidFrames = read(readerobj);
 
% Display video with implay( )
implay( vidFrames )

% Read and play only frame 10 - 20
% readerobj = VideoReader('xylophone.mp4');
% vidFrames = read(readerobj, [10 20]);
% implay( vidFrames )

%% Write videos using my custom make_avi_video( ) function

% Grayscale
make_avi_video( x, 'noise' )

% Color (no compression)
make_avi_video( vidFrames, 'xylophone_no_compression' )

% Color (with compression)
make_avi_video( vidFrames, 'xylophone_compression', 30, 1 )

