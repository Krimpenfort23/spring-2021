function dsft(x,row,col,N,rad_flag);
%
% dsft(x,row,col,N,rad_flag);
% 
%  Discrete-Space Fourier Transform
% 
%  x is array with lower left value assumed to be at m=0,n=0
%  The displayed spectrum is for any shifted version
%  of this x array:   DSFT { x(m-shx,n-shy) }
%  Note that a negative shx,shy means we are computing 
%  the spectrum of x shifted left and down
%
% REQUIRED INPUTS
%
% x             Input array
%
% OPTIONAL INPUTS
%
% row, col      Row and column of the n1=n2=0 sample (default = 1,1).
%
% N             Optional.  Number of frequency points 
%               to compute and plot (default=64).
%
% rad_flag   1 if you want discrete frequency dipslayed in radians/sample
%               Otherwise you get cycles/sample.
%
% Author: Dr. Russell Hardie
% University of Dayton
% 2/17/02
% 2/21/13
% 8/27/17

% Default cycles flag is 0
if nargin < 5 || isempty( rad_flag )
    rad_flag = 0;
end

% Default FFT size is 64
if nargin < 4
    N = 64;
end

% Default n1=n2=0 is 1,1
if nargin < 2
    row = 1;
    col = 1;
end

% Do 2D FFT
X = fft2(x,N,N);

% Adjust phase for specified input shift and do FFTSHIFT
k = 2*pi*[0:N-1]/N;
[K1,K2] = meshgrid(k,k);
S = exp(1i*(K1*(col-1)+K2*(row-1)));
Y = fftshift(X.*S);

% Display
if rad_flag
    
    f1 = ( [1:N] - (floor(N/2)+1) )/N;
    w1 = 2*pi*f1;
    w2 = w1;
    
    figure
    subplot(211)
    mesh(w1,w2,abs(Y));
    xlabel('\omega_1 (radians/sample)');
    ylabel('\omega_2 (radians/sample)');
    zlabel('|H(\omega_1,\omega_2)|');
    axis tight
    title('Magnitude');
    
    subplot(212)
    mesh(w1,w2,angle(Y));
    xlabel('\omega_1 (radians/sample)');
    ylabel('\omega_2 (radians/sample)');
    zlabel('\angle H(\omega_1,\omega_2)');
    axis tight
    title('Phase');
    
else
      
    f1 = ( [1:N] - (floor(N/2)+1) )/N;
    f2 = f1;

    figure
    subplot(211)
    mesh(f1,f2,abs(Y));
    xlabel('f_1 (cycles/sample)');
    ylabel('f_2 (cycles/sample)');
    zlabel('|H(f_1,f_2)|');
    axis tight
    title('Magnitude');
    
    subplot(212)
    mesh(f1,f2,angle(Y));
    xlabel('f_1 (cycles/sample)');
    ylabel('f_2 (cycles/sample)');
    zlabel('\angle H(f_1,f_2)');
    axis tight
    title('Phase');
    
end



