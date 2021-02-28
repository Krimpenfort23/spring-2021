function out = local_contrast( in, gauss_std, min_local_std )
%
% out = local_contrast( in, gauss_std, min_local_std )
%
% in            the input image to be enhanced.
% gauss_std     the Gaussian low pass filter spatial standard deviation.
% min_local_std the minimum allowable local standard deviation estimate value.
%
% Computing a local contrast image processing technique on the image in.
%
% Author: Evan Krimpenfort
% University of Dayton
% ECE 563 Image Processing with Dr. Russell Hardie 
% Date:  February 26th, 2021

% creating the fpecial hsize
hsize = 5 * ceil(gauss_std);

% checking to make sure that the hsize is an odd value
if mod(hsize, 2) == 0
    hsize = hsize + 1;
end

% running fspecial to make h(m,n) (both the xvalue and yvalue)
hy = fspecial('gaussian', hsize, gauss_std);
hx = hy';

% running the convolution function through the x and y values to make the
% function mu(m,n)
mu = conv2( padarray( in, (size(hx)-1)/2, 'symmetric', 'both' ), hx, 'valid');
mu = conv2( padarray( mu, (size(hy)-1)/2, 'symmetric', 'both' ), hy, 'valid');

% running the convolution function again through the x y values to make the
% function sigma(m,n)
in2 = (in - mu).^2;
sigma_squared = conv2( padarray( in2, (size(hx)-1)/2, 'symmetric', 'both'), hx, 'valid');
sigma_squared = conv2( padarray( sigma_squared, (size(hx)-1)/2, 'symmetric', 'both'), hy, 'valid');

% getting sigma by sqrt'ing sigma_squared
sigma = sqrt(sigma_squared);

% checking to make sure that sigma isn't 0.
if sigma == 0
    out = 64 * ((in - mu)./(min_local_std)) + 127;
else
    out = 64 * ((in - mu)./(sigma)) + 127;
end

% End of function