addpath(genpath('../../MATLAB'))


%% Example 1: Gaussian

N = 51; % FIR length
[w1,w2,f1,f2,u,v,x,y,n1,n2] = fftshift_samples2d( N );

[F1,F2]=meshgrid(f1,f2); % Zero centered frequency sample coordinates
H = exp(-100*(F1.^2+F2.^2));  % H(f1,f2) equation (zero centered)

h = fftshift(ifft2(ifftshift(H))); % Frequency sampling design

figure
mesh( f1, f2, H );
xlabel('f_1 (cycles/sample)'); ylabel('f_2 (cycles/sample)'); zlabel('H(f_1,f_2)');
title('Desired 2D discrete-space frequency response')

figure
mesh( n1, n2, h );
xlabel('n_1 (sample)'); ylabel('n_2 (sample)'); zlabel('h(n_1,n_2)');
title('Discrete-space FIR impulse response')

x = imread('cameraman.tif');
y = imfilter(x,h, 'symmetric');
im(x); title('Input');
im(y); title('Filtered');


%% Example 2: Butterworth HPF

N = 51; % FIR length
[w1,w2,f1,f2,u,v,x,y,n1,n2] = fftshift_samples2d( N );

[F1,F2] = meshgrid(f1,f2); % Zero centered frequency sample coordinates
fc = .1;   n=1;    % 0-.5 cyc/sample
H = 1./( 1+(fc./sqrt(F1.^2+F2.^2)).^(2*n) );  % H(f1,f2) equation (zero centered)

h = fftshift(ifft2(ifftshift(H))); % Frequency sampling design

figure;  mesh( f1, f2, H );
xlabel('f_1 (cycles/sample)'); ylabel('f_2 (cycles/sample)'); zlabel('H(f_1,f_2)');
title('Desired 2D discrete-space frequency response')

figure; mesh( n1, n2, h );
xlabel('n_1 (sample)'); ylabel('n_2 (sample)'); zlabel('h(n_1,n_2)');
title('Discrete-space FIR impulse response')

x = imread('cameraman.tif');
y = imfilter(x,h, 'symmetric');
im(x); title('Input');
im(y); title('Filtered');


%% Example 3: high boost

N = 51; % FIR length
[w1,w2,f1,f2,u,v,x,y,n1,n2] = fftshift_samples2d( N );

[F1,F2] = meshgrid(f1,f2); % Zero centered frequency sample coordinates
fc = .1; n=1; % 0-.5 cyc/sample
H = 1+2./( 1+(fc./sqrt(F1.^2+F2.^2)).^(2*n) );  % H(f1,f2) zero centered

h = fftshift(ifft2(ifftshift(H))); % Frequency sampling design

figure;  mesh( f1, f2, H );
xlabel('f_1 (cycles/sample)'); ylabel('f_2 (cycles/sample)'); zlabel('H(f_1,f_2)');
title('Desired 2D discrete-space frequency response')

figure; mesh( n1, n2, h );
xlabel('n_1 (sample)'); ylabel('n_2 (sample)'); zlabel('h(n_1,n_2)');
title('Discrete-space FIR impulse response')

x = imread('cameraman.tif');
y = imfilter(x,h, 'symmetric');
im(x); title('Input');
im(y); title('Filtered');


%% Example 4: impulse invariance

N = 51; % FIR length
d = 5.6e-6
[w1,w2,f1,f2,u,v,x,y,n1,n2] = fftshift_samples2d( N, d );

[U,V] = meshgrid(u,v); % Zero centered frequency sample coordinates
H = 1./(1+abs(U)/1000+abs(V)/4000);
h = fftshift(ifft2(ifftshift(H))); % Frequency sampling design

figure;  mesh( u, v, H );
xlabel('u (cyc/m)'); ylabel('v (cyc/m)'); zlabel('H(u,v)');
title('Desired 2D continuous-space frequency response')

figure; mesh( n1, n2, h );
xlabel('n_1 (sample)'); ylabel('n_2 (sample)'); zlabel('h(n_1,n_2)');
title('Discrete-space FIR impulse response')

x = imread('cameraman.tif');
y = imfilter(x,h, 'symmetric');
im(x); title('Input');
im(y); title('Filtered');

