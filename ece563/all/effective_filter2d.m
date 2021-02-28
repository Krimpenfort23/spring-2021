function effective_filter2d(h,d,row,col,N);
%
% effective_filter2d(h,d,row,col,N);
% 
% Plot the effective frequency response and impulse response of a discrete
% impulse repsonse h, with n1=n2=0 at row,col, using N FFT samples.
%
% REQUIRED INPUTS
%
% h             Impulse response
% d             Sample spacing
%
% OPTIONAL INPUTS
%
% row, col      Row and column of the n1=n2=0 sample (default = 1,1).
%
% N             Optional.  Number of frequency points 
%               to compute and plot (default=64).
%
% Author: Dr. Russell Hardie
% University of Dayton
% 9/14/17


% Default FFT size is 64
if nargin < 5
    N=64;
end

% Default n1=n2=0 is 1,1
if nargin < 4
    row = 1;
    col = 1;
end

% Do 2D FFT
[~,~,~,~,u,v] = fftshift_samples2d( N, d );
H = fft2(h,N,N);

% Adjust phase for specified input shift and do FFTSHIFT
k = 2*pi*[0:N-1]/N;
[K1,K2] = meshgrid(k,k);
S = exp(1i*(K1*(col-1)+K2*(row-1)));
H2 = fftshift(H.*S);


% Display effective frequency response
figure
subplot(211)
mesh(u,v,abs(H2));
xlabel('u (cycles/meter)');
ylabel('v (cycles/meter)');
zlabel('|H(u,v)|');
axis tight
title('Effective filter magnitude');

subplot(212)
mesh(u,v,angle(H2));
xlabel('u (cycles/meter)');
ylabel('v (cycles/meter)');
zlabel('\angle H(u,v)');
axis tight
title('Effective filter Phase');

% Display effective impulse response
figure
h = padarray( h, [2,2], 0, 'both' );
[sy,sx] = size(h);
x = [0:d:d*(sx-1)];
y = [0:d:d*(sy-1)]';
x = x - x(col+2);
y = y - y(row+2);
mesh( x, y, h );
xlabel('x (meters)');
ylabel('y (meters)');
zlabel('h(x,y)');
axis tight
title('Effective filter impulse response');