addpath(genpath('../../MATLAB'))


%% Example 1: Samples of DSFT of 2D discrete sequence in first quadrant

[n1,n2] = meshgrid( 0:29 );
g = double( n1 >= 10 & n1 < 20 & n2 >= 10 & n2 < 20 );
N = 256;

G = fftshift(fft2( g, N, N ));

[w1,w2,f1,f2] = fftshift_samples2d( N );

figure
stem3( n1, n2, g  )
xlabel('n_1');
ylabel('n_2');
zlabel('g(n_1,n_2)');
title('2D discrete sequence in first quadrant')

figure
mesh( f1, f2, abs(G) );
xlabel('f_1 (cycles/sample)');
ylabel('f_2 (cycles/sample)');
zlabel('|G(f_1, f_2)|');
title('Samples of DSFT using FFT2')


%% Example 2: Infer CSFT from a first quadrant sampled 2D signal

d = .01 % meters
[x,y] = meshgrid( [0:29]*d );
g = double( x >= .1 & x < .2 & y >= .1 & y < .2 );
N = 256;

G = fftshift(fft2( g, N, N ));

[w1,w2,f1,f2,u,v] = fftshift_samples2d( N, d );

figure
mesh( x, y, g  ) % note the use of d here
xlabel('x (meters)');
ylabel('y (meters)');
zlabel('g(x,y)');
title('Samples of a first quadrant continuous-space 2D signal')

figure
mesh( u, v, abs(G)*d^2 ); % Multiply by dx*dy = d^2 when going from DFT to CSFT domain
xlabel('u (cycles/meter)');
ylabel('v (cycles/meter)');
zlabel('|G(u,v)|');
title('Inferred CSFT using FFT2')


%% Example 3: Infer CSFT from sampled zero centered 2D signal

N = 256;
d = .1; % meters

[w1,w2,f1,f2,u,v,x,y] = fftshift_samples2d( N, d );

g = sinc(x)'*sinc(y); % evaluate zero centered g(x,y)

G = fftshift(fft2(ifftshift(g)));

figure
mesh( x, y, g  ) % note the use of d here
xlabel('x (meters)');
ylabel('y (meters)');
zlabel('g(x,y)');
title('Samples of a zero-centered continuous-space 2D signal (sinc(x,y))')

figure
mesh( u, v, abs(G)*d^2 ); % Multiply by dx*dy = d^2 when going from DFT to CSFT domain
xlabel('u (cycles/meter)');
ylabel('v (cycles/meter)');
zlabel('|G(u,v)|');
title('Inferred CSFT using FFT2')


%% % Example 4: Infer CSFT from sampled zero centered 2D signal

N = 128;
d = .04; % meters

[w1,w2,f1,f2,u,v,x,y] = fftshift_samples2d( N, d );

[X,Y]=meshgrid(x,y);
g = double( sqrt( X.^2 + Y.^2 ) < 0.5 );

G = fftshift(fft2(ifftshift(g)));

figure
mesh( x, y, g  ) % note the use of d here
xlabel('x (meters)');
ylabel('y (meters)');
zlabel('g(x,y)');
title('Samples of a zero-centered continuous-space 2D signal (circ(x,y))')

figure
mesh( u, v, abs(G)*d^2 ); % Multiply by dx*dy = d^2 when going from DFT to CSFT domain
xlabel('u (cycles/meter)');
ylabel('v (cycles/meter)');
zlabel('|G(u,v)|');
title('Inferred CSFT using FFT2')


%% Example 5: Infer inverse CSFT from zero centered frequency samples

N = 128;
d = .05; % meters

[w1,w2,f1,f2,u,v,x,y] = fftshift_samples2d( N, d );

[U,V]=meshgrid(u,v);
G = double(  sqrt( (U/5).^2 + (V/5).^2) < 0.5 );

g = fftshift(ifft2(ifftshift(G)));

figure
mesh( u, v, G  ) % note the use of d here
xlabel('u (cycles/meters)');
ylabel('v (cycles/meters)');
zlabel('G(u,v)');
title('Zero-centered continuous space frequency samples')

figure
mesh( x,y, g/d^2 ); % Divide by dx*dy=d^2 when going from CSFT to DFT domain
xlabel('x (meters)');
ylabel('y (meters)');
zlabel('g(x,y)');
title('Inferred inverse CSFT')
axis tight

%% Example 3: Infer CSFT revisited with windowing

N = 256;
d = .1; % meters
 
[~,~,~,~,u,v,x,y] = fftshift_samples2d( N, d );
 
g = sinc(x)'*sinc(y); % evaluate zero centered g(x,y)
 
G = fftshift(fft2(ifftshift(g)));
 
figure; subplot(221)
mesh( x, y, g  ) % note the use of d here
xlabel('x (meters)');
ylabel('y (meters)');
zlabel('g(x,y)');
title('Samples sinc(x,y)')
 
subplot(222)
mesh( u, v, abs(G)*d^2 ); % Multiply by dx*dy = d^2 when going from DFT to CSFT domain
xlabel('u (cycles/meter)');
ylabel('v (cycles/meter)');
zlabel('|G(u,v)|');
title('Inferred CSFT using FFT2')

% Now use tapered window
% makes function approximately band- and space-limited minimizing aliasing and sampling duration issues
w  = window(@blackmanharris,N); % 1D
w2 = w*w'; % make 2D
g2 = g.*w2; 

G2 = fftshift(fft2(ifftshift(g2)));

subplot(223)
mesh( x, y, g2  ) % note the use of d here
xlabel('x (meters)');
ylabel('y (meters)');
zlabel('g(x,y)');
title('Samples of windowed sinc(x,y)')

subplot(224)
mesh( u, v, abs(G2)*d^2 ); % Multiply by dx*dy = d^2 when going from DFT to CSFT domain
xlabel('u (cycles/meter)');
ylabel('v (cycles/meter)');
zlabel('|G(u,v)|');
title('Inferred CSFT using FFT2 (with windowing)')

