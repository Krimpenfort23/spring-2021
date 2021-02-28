function imspec(in,offset,row,col,rad_flag)
%
% imspec(in,offset,row,col,rad_flag)
%
% Displays the Discrete-Space Fourier Transform (DSFT) of an image. Uses
% fft2( ) to compute samples of the DSFT. The log of the values of the
% magnitude spectrum are mapped to grayscale values and diaplyed as an
% image.  The phase values are linearly mapped to grayscale values and also
% displayed as an image (pi -> white, -pi -> black).
%
% REQUIRED INPUTS
%
% in        Input image (2D array)
%
% OPTIONAL INPUTS
%
% offset    Optional
%           Value added to Magnitude response prior to taking the log.
%           This effectively results in smaller values shown darker than a
%           with standard log mapping. This may be helpful in seeing where
%           the small spectrum values lie. (Suggested offset=100+,
%           default=1).
%
% row, col   Row and column of the n1=n2=0 sample (default = 1,1).
%
% rad_flag   1 if you want discrete frequency dipslayed in rads/sample
%               Otherwise you get cycles/sample.
%
% Author: Dr. Russell Hardie
% University of Dayton
% 2/20/02, 1/26/2010, 2/21/13, 8/27/17
% 2/8/21 imagesc() instead of custom imlin( )


% Default offset
if nargin < 2 || isempty(offset)
    offset = 1;
end

% Default n1=n2=0 is 1,1
if nargin < 4 
    row = 1;
    col = 1;
end

% Default rad_flag
if nargin < 5
    rad_flag = 0;
end

% Take 2D FFT
X = fft2(in);

% Get size info
[sy,sx] = size(in);

% Adjust phase for specified input shift and do FFTSHIFT
ky = 2*pi*[0:sy-1]/sy;
kx = 2*pi*[0:sx-1]/sx;
[K1,K2] = meshgrid(kx,ky);
S = exp(1i*(K1*(col-1)+K2*(row-1)));
X = fftshift(X.*S);


% Generate images
if rad_flag
    
    f1 = ( [1:sx] - (floor(sx/2)+1) )/sx;
    f2 = ( [1:sy] - (floor(sy/2)+1) )/sy; 
 
    w1 = 2*pi*f1;
    w2 = 2*pi*f2;

    figure
    imagesc(w1,w2,log(abs(X)+offset));
    axis image
    colormap(gray(256));
    title('DSFT Magnitude');
    xlabel('\omega_1 (radians/sample)');
    ylabel('\omega_2 (radians/sample)');
    
    figure
    imagesc(w1,w2,angle(X));
    axis image
    colormap(gray(256));
    title('DSFT Phase');
    xlabel('\omega_1 (radians/sample)');
    ylabel('\omega_2 (radians/sample)');
    
else
    
    f1 = ( [1:sx] - (floor(sx/2)+1) )/sx;
    f2 = ( [1:sy] - (floor(sy/2)+1) )/sy; 
 
    figure
    imagesc(f1,f2,log(abs(X)+offset));
    axis image
    colormap(gray(256));
    title('DSFT Magnitude');
    xlabel('f_1 (cycles/sample)');
    ylabel('f_2 (cycles/sample)');
    
    figure
    imagesc(f1,f2,angle(X));
    axis image
    colormap(gray(256));
    title('DSFT Phase');
    xlabel('f_1 (cycles/sample)');
    ylabel('f_2 (cycles/sample)');
    
end
