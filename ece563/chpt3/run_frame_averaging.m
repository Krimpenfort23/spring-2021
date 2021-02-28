%% Create a synthetic noisy image sequence and use frame averaging

cl

% load image
x = double( imread('cameraman.tif') );

% Replicate to make 30 static frames
x_noise = repmat(x,[1,1,30]);

% Add noise
x_noise = x_noise + 40*randn( size( x_noise ) );

% Display video with sliceViewer
sliceViewer( x_noise,'DisplayRange', [0,255] );

% % Display video with implay
% handle = implay( x_noise );
% 
% % Set the colormap grayscale range for implay
% handle.Visual.ColorMap.UserRange = 256;
% handle.Visual.ColorMap.UserRangeMin = 0;
% handle.Visual.ColorMap.UserRangeMax = 255;

% Do frame average
frame_average = mean( x_noise, 3 );

figure
subplot(221)
im(x,0)
title('Original');
subplot(222)
im(x_noise(:,:,1),0)
title('One Noisy Frame');
subplot(223)
im(frame_average,0);
title('30 Frame Average');
