if exist('vid')
    stop(vid)
end

clear
close all

% Note imaqreset is a useful command if you need to reset the vid object.

%---------------%
% Set up camera %
%---------------%

% See what camera formats are available

% Note: you need to install any camera drivers first and install MATLAB's
% image acquisition support package.  The adaptor you need for a standard
% webcam is:  Windows Video (winvideo) Image Acquisition Toolbox Support
% Package for OS Generic Video Interface.  Use the imaqtool function to do
% a simple camera test.
dev_info = imaqhwinfo('macvideo')
dev_info.DeviceInfo.SupportedFormats

% Pick a format available with your camera here
vid = videoinput('winvideo',1,'YUY2_640x480')

triggerconfig(vid, 'Manual')
% triggerconfig(vid, 'Immediate')

set(vid,'TriggerRepeat',Inf);
vid.FrameGrabInterval = 1; % 5

set(vid,'FramesPerTrigger',1)


%--------------------------------%
% Start acquiring and processing %
%--------------------------------%

% Display figure window
close all
figure(1)
subplot(121)
axis image
title('Raw Frames')
subplot(122)
axis image
title('Edge Detection')

% Start video object, wait until it is running to move on
start(vid)
while (~isrunning(vid))
    % wait
end

% Infinite processing loop (use CTRL-C to stop)
while(isrunning(vid))

    trigger(vid)

    % Get first group of frames
    data = getdata(vid,1);
    % data = peekdata(vid,1);
    % data = getsnapshot(vid);

    % Convert to double precision for processing
    in = double( data );
  
    % Apply Sobel edge detection
    E = edge(in(:,:,1),'sobel',10); % Processing first field of color image

    % Display raw image and edge mask
    subplot(121)
    image(uint8( yuy2rgb(in) ) ); % yuy2rgb not needed if already RGB
    axis image
    title('Raw Frames')
    subplot(122)
    image(E*255);
    colormap(gray(256))
    axis image
    title('Edge Detection')

    % Force images to display before resuming loop
    drawnow
 
end

stop(vid) % Clean up when using finite loop

