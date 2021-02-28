function [ w1, w2, f1, f2, u, v, x, y, n1, n2 ] = fftshift_samples2d( N, d )
%
% [ w1, w2, f1, f2, u, v, x, y, n1, n2 ] = fftshift_samples2d( N, d );
%
% 2D FFT (FFT2 in MATLAB) only works on first quadrant finite sequences and
% returns frequency samples in the first quadrant.  Frequently we want to
% work with zero centered spatial and/or frequency sequences.  Thus, we use
% FFTSHIFT and IFFTSHIFT along with FFT2. FFTSHIFT shifts from first
% quadrant to zero centered, and IFFTSHIFT shifts the other way.   The
% function here (fftshift_samples2d.m) helps us keep track of the spatial
% and frequency axes when using FFT2, FFTSHIFT and IFFTSHIFT.
%
% This function output arrays of zero centered frequency axis values to go
% along with G=FFTSHIFT(FFT2(g)).  These arrays can be used for plotting
% the results of G=FFTSHIFT(FFT2(g)).  The frequency samples provided can
% also be used to evaluate a zero centered frequency domain function prior
% to IFFTSHIFT, which moves the frequency samples into the first quadrant
% and ready for IFFT2.
%
% Finally, this function also returns an array of zero centered spatial
% samples (x,y) that you might use if trying to approximate a CSFT or ICSFT
% for a zero centered spatial function.
%
% REQUIRED INPUTS
% N         N = [ Nx, Ny ] Number of frequency samples in each dimension
%           for the FFT2.  If N is a scalar, it is assumed that Ny = Nx.
%
% OPTIONAL INPUTS
% d         d = [ dx, dy ] are the sample spacings in the spatial domain
%           measured in some [unit distance] (usually meters or
%           millimeters) for the spatial function being analyzed with FFT2.
%           If d is a scalar, it is assumed that dy = dx.
%
% OUTPUTS
% w1, w2    Zero centered DSFT frequency samples in rads/sample
% f1, f2    Zero centered DSFT frequency samples in cycles/sample
% u, v      Zero centered CSFT frequency samples in cycles/[unit distance].
%           Note that [unit distance] is defined by d above.
% x, y      Zero centered 2D spatial samples that can be evaluated and then
%           IFFTSHIFT-ed into the first quadrant for used with FFT2 
%           Units are [unit distance] defined by d above.
% n1, n2    Discrete zero-centered spatial indices
%
% Note that u,v and x,y require the user to enter d.
%
% Author: Dr. Russell Hardie
% University of Dayton
% 7-16-17
%
% COPYRIGHT © 2017 RUSSELL C. HARDIE.  ALL RIGHTS RESERVED. 
%
% EXAMPLES
%
%
% Example 1: Samples of DSFT of 2D discrete sequence in first quadrant
%
% gx = [zeros(1,10),ones(1,10),zeros(1,10)];
% g = gx'*gx;
% N = 256;
% G = fftshift(fft2( g, N, N ));
%
% [w1,w2,f1,f2] = fftshift_samples2d( N );
%
% figure
% stem3( [0:29], [0:29], g  ) 
% xlabel('n_1');
% ylabel('n_2');
% zlabel('g(n_1,n_2)');
% title('2D discrete sequence in first quadrant')
%
% figure
% mesh( w1, w2, abs(G) );
% xlabel('\omega_1 (rads/sample)');
% ylabel('\omega_2 (rads/sample)');
% zlabel('|G(\omega_1, \omega_2)|');
% title('Samples of DSFT using FFT2')
%
% figure
% mesh( f1, f2, abs(G) );
% xlabel('f_1 (cycles/sample)');
% ylabel('f_2 (cycles/sample)');
% zlabel('|G(f_1, f_2)|');
% title('Samples of DSFT using FFT2')
%
%
% Example 2: Infer CSFT from a first quadrant sampled 2D signal
%
% gx = [zeros(1,10),ones(1,10),zeros(1,10)];
% g = gx'*gx;
% N = 256;
% G = fftshift(fft2( g, N, N ));
% d = .01 % meters
%
% [w1,w2,f1,f2,u,v] = fftshift_samples2d( N, d );
%
% figure
% mesh( [0:29]*d, [0:29]*d, g  ) % note the use of d here
% xlabel('x (meters)');
% ylabel('y (meters)');
% zlabel('g(x,y)');
% title('Samples of a first quadrant continuous-space 2D signal')
%
% figure
% mesh( u, v, abs(G)*d^2 ); % note we need to scale amplitude by dx*dy = d^2
% xlabel('u (cycles/meter)');
% ylabel('v (cycles/meter)');
% zlabel('|G(u,v)|');
% title('Inferred CSFT using FFT2')
%
%
% Example 3: Infer CSFT from sampled zero centered 2D signal
%
% N = 256;
% d = .1; % meters
%
% [w1,w2,f1,f2,u,v,x,y] = fftshift_samples2d( N, d );
%
% g = sinc(x)'*sinc(y); % evaluate zero centered g(x,y)
%
% G = fftshift(fft2(ifftshift(g)));
%
% figure
% mesh( x, y, g  ) % note the use of d here
% xlabel('x (meters)');
% ylabel('y (meters)');
% zlabel('g(x,y)');
% title('Samples of a zero-centered continuous-space 2D signal (sinc(x,y))')
%
% figure
% mesh( u, v, abs(G)*d^2 ); % note we need to scale amplitude by dx*dy = d^2
% xlabel('u (cycles/meter)');
% ylabel('v (cycles/meter)');
% zlabel('|G(u,v)|');
% title('Inferred CSFT using FFT2')
%
%
% Example 4: Design FIR with frequency sampling method from zero centered
% discrete frequency response H(f1,f2)
%
% N = 51; % FIR length
% 
% [w1,w2,f1,f2,u,v,x,y,n1,n2] = fftshift_samples2d( N );
%
% [F1,F2] = meshgrid(f1,f2); % Zero centered frequency sample coordinates
% H = 1./(1+200*F1.^2+200*F2.^2); % any H(f1,f2) equation (zero centered)
%
% h = fftshift(ifft2(ifftshift(H))); % Frequency sampling design
%
% figure
% mesh( f1, f2, H ); 
% xlabel('f_1 (cycles/sample)');
% ylabel('f_2 (cycles/sample)');
% zlabel('H(f_1,f_2)');
% title('Desired 2D discrete-space frequency response')
%
% figure
% mesh( n1, n2, h ); 
% xlabel('n_1 (sample)');
% ylabel('n_2 (sample)');
% zlabel('h(n_1,n_2)');
% title('Discrete-space FIR impulse response')
%
%
% Example 5: Design FIR with frequency sampling method from zero centered
% continuous frequency response H(u,v)
%
% N = 51; % FIR length
% d = .1; % meters
% 
% [w1,w2,f1,f2,u,v,x,y,n1,n2] = fftshift_samples2d( N, d );
%
% [U,V] = meshgrid(u,v); % Zero centered frequency sample coordinates
% H = 1./(1+U.^2+V.^2); % any H(u,v) equation (zero centered)
%
% h = fftshift(ifft2(ifftshift(H))); % Frequency sampling design
%
% figure
% mesh( u, v, H ); 
% xlabel('u (cycles/meter)');
% ylabel('v (cycles/meter)');
% zlabel('H(u,v)');
% title('Desired 2D continuous-space frequency response')
%
% figure
% mesh( x, y, h ); 
% xlabel('x (meters)');
% ylabel('y (meters)');
% zlabel('h(x,y)');
% title('2D continuous-space impulse response')
%
% figure
% mesh( f1, f2, H ); 
% xlabel('f_1 (cycles/sample)');
% ylabel('f_2 (cycles/sample)');
% zlabel('H(f_1,f_2)');
% title('Desired 2D discrete-space frequency response')
%
% figure
% mesh( n1, n2, h ); 
% xlabel('n_1 (sample)');
% ylabel('n_2 (sample)');
% zlabel('h(n_1,n_2)');
% title('Discrete-space FIR impulse response')
%


% Default N(2) is N(1)
if length(N) < 2
    N(2) = N(1);
end

% Generic zero centered (FFTSHIFT) indices
% All zero cententered FFT related frequencies and spatial samples are
% scaled version of these
n1 = (1:N(1)) - (floor(N(1)/2)+1);
n2 = (1:N(2)) - (floor(N(2)/2)+1);

% Zero centered frequency samples in rads/sample 
% (rad/sample frequency spacing is 2*pi/N)
w1 = (2*pi/N(1)) * n1;  % rads/sample
w2 = (2*pi/N(2)) * n2;  % rads/sample

% Zero centered frequency samples in cycles/sample 
% (cycle/sample frequency spacing is 1/N)
f1 = (1/N(1)) * n1;  % cycles/sample
f2 = (1/N(2)) * n2;  % cycles/sample

if nargin > 1 % we are given the sample spacing
    
    % Default d(2) is d(1)
    if length(d) < 2
        d(2) = d(1);
    end
    
    % Zero centered frequency samples in cycles/(unit distance)
    % (frequency sample spacing is 1/(d(1)*N(1), 1/(d(2)*N(2))
    u = ( 1/(d(1)*N(1)) ) * n1; % cycles/(unit distance)
    v = ( 1/(d(2)*N(2)) ) * n2; % cycles/(unit distance)
    
    % Zero center spatial samples
    x = d(1) * n1; % (unit distance)
    y = d(2) * n2; % (unit distance)
   
else
    
    % Cannot specify these without d
    u = [];
    v = [];
    x = [];
    y = [];
    
end