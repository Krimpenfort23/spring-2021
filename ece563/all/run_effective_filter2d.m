addpath(genpath('../../MATLAB'));


%% Gaussian

h = fspecial( 'gaussian', [9,9], 2 );

[n1,n2] = meshgrid(-4:4);

figure
stem3( n1, n2, h )
xlabel('n_1'); ylabel('n_2'); zlabel('h(n_1,n_2)');
title('Discrete impuse response')

% DSFT style plot
dsft(h,5,5,128);

% Effective filter (CSFT style plot)
effective_filter2d(h,5.6e-6,5,5,128);


%% Sobel

h = fspecial( 'sobel' );

[n1,n2] = meshgrid(-1:1);

figure
stem3( n1, n2, h )
xlabel('n_1'); ylabel('n_2'); zlabel('h(n_1,n_2)');
title('Discrete impuse response')

% DSFT style plot
dsft(h,2,2,128);

% Effective filter (CSFT style plot)
effective_filter2d(h,5.6e-6,2,2,128);
