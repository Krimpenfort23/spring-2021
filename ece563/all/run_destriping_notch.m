%% Destriping example using a notch filter
%
%
% Author: Dr. Russell Hardie
% University of Dayton
% ECE 563
%
% Revision history:
% 3/2/2021 updated

%% Load image

cl

% Load image
x = imread('njolov2.gif');
% x = imread('l0r_b6_lg.gif');

% Display image
im(x)
imspec(x)


%% Notch filter guided by user mouse selections

X = fft2(double(x));

[N, M] = size(x);
midu = (fix(M / 2) + 1);
midv = (fix(N / 2) + 1);

X2 = X;
button = 0;
half_width = 3;
half_height = 3;

H = ones(N, M);
while button ~= 3

    clc
    disp('Left Mouse to selected notch frequency, right to exit')
    figure(1)
    im(abs(fftshift(X2)), 0, 0, 3);
    title('Image Magnitude Spectrum');
    [x0, y0, button] = ginput(1);
    x0 = round(x0);
    y0 = round(y0);

    x0(x0 < half_width+2) = half_width + 2;
    x0(x0 > M-half_width) = M - half_width;
    y0(y0 < half_height+2) = half_height + 2;
    y0(y0 > N-half_height) = N - half_height;

    stx = x0 - half_width;
    edx = x0 + half_width;
    sty = y0 - half_height;
    edy = y0 + half_height;

    stx2 = 2 * midu - edx;
    edx2 = 2 * midu - stx;
    sty2 = 2 * midv - edy;
    edy2 = 2 * midv - sty;

    H(sty:edy, stx:edx) = 0;
    H(sty2:edy2, stx2:edx2) = 0;

    X2 = X2 .* ifftshift(H);
    x2 = ifft2(X2);

    figure(2)
    im(x, 0)
    title('Input Image');
    figure(3)
    im(x2, 0)
    title('Output Image');

end
