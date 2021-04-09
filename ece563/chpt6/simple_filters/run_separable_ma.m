%% Compare moving average implementations for speed
%
% Dr. Russell Hardie
% University of Dayton
% ECE 563
%

%% Standard conv2() for moving average

ws = 101;
pad = (ws - 1) / 2;
h = ones(ws, ws) / (ws * ws);

% 2D Convolution
tic
ma1 = conv2(padarray(y, [pad, pad], 'symmetric', 'both'), h, 'valid');
t1 = toc

% Display MA image and processing time (2D convolution)
im(ma1);
title(sprintf('%d x %d MA (2D Convolution) (Time=%2.4f s)', ws, ws, t1));


%% Separable moving average

% Separable convolution
hx = ones(1, ws) / ws;
hy = hx';

tic
ma2 = conv2(padarray(y, (size(hx) - 1) / 2, 'symmetric', 'both'), hx, 'valid');
ma2 = conv2(padarray(ma2, (size(hy) - 1) / 2, 'symmetric', 'both'), hy, 'valid');
t2 = toc

% Display MA image and processing time (separable)
im(ma2);
title(sprintf('%d x %d MA Separable (Time=%2.4f s)', ws, ws, t2));


%% Cumulative sum implementation

tic
ma3 = moving_average_filter_fast( y, (ws-1)/2 );
t3 = toc

% Display MA image and processing time (cumulative)
im(ma2);
title(sprintf('%d x %d MA Cumulative Sum (Time=%2.4f s)', ws, ws, t3));

