addpath('..\chp1\')
% imaqreset

% Laptop camera (1 or 2)
vid = videoinput('winvideo',1,'YUY2_640x480')

% Use this when attaching my second camera (1 or 2)
% vid = videoinput('winvideo',2,'Y800_640x480') 

triggerconfig(vid, 'Manual')
set(vid,'TriggerRepeat',Inf);
vid.FrameGrabInterval = 1; 
set(vid,'FramesPerTrigger',1)
 
start(vid)
while (~isrunning(vid))
    % wait
end
 
y = zeros(480,640);
a = .05;

for k=1:1000 
    
    trigger(vid)
    x = double(getdata(vid,1));
    x = x(:,:,1);
    x = x + randn(480,640)*10; % add noise to make this more obvious
 
    y = (1-a)*y + a*x;

    figure(1)
    subplot(121)
    im(x,0);
    title('Raw Frames')
    subplot(122)
    im(y,0);
    title('Recursive Temporal Averaging')
    drawnow
     
end
 
stop(vid)