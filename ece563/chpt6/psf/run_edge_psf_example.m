%% Determine PSF from edge image
%
% Dr. Russell Hardie
% University of Dayton
% ECE 563
%

%% Create ideal edge image

cl

% Idea edge image
ideal_edge = [zeros(256, 128), ones(256, 128)];

% Display edge image
im(ideal_edge);
title('Ideal Edge');
xlabel('x')
ylabel('y')


%% Degrade edge to simulate a camera's PSF

% Create circularly symmetric point spread function (PSF) to test
r = [ones(1, 10), .5 * ones(1, 10), zeros(1,6) ];
[h_true, XI, YI] = gencircsym(r, 0);
h_true = h_true / sum( h_true(:) ); % DC = 1

% Mesh the PSF
figure
mesh(XI, YI, h_true)
title('True PSF');
xlabel('m')
ylabel('n')
zlabel('h(m,n)');
axis tight

% Blur edge with the PSF
[hsy, hsx] = size(h_true);
pady = (hsy - 1) / 2;
padx = (hsx - 1) / 2;
blurred_edge = conv2(padarray(ideal_edge, [pady, padx], 'both', ...
    'symmetric'), h_true, 'valid');

% Dispay blurred image
im(blurred_edge);
title('Blurred Edge');

%% Determine PSF

% Parameters for edge2psf.m
params.buff = 10;
params.K = 3;
params.psf_size = 51;
params.L = 1;
params.verbose = 1;

% Convert from edge spread function (ESF) to point spread function (PSF)
[psf, OTF, OTF2] = edge2psf(blurred_edge, params);
