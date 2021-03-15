%% Fresh Start
% Author:  Evan Krimpenfort
% Class:   ECE 563-01
% Purpose: <This is a blank. Fill this out.>
clc; clear all; close all;

%% Code

% define constants
l = 0.5;    % Focal Length in meters
lambda = 0.5e-6;    % Wavelength in meters
r0 = 0.01;  % Fried Parameter in meters
rho_c = 100000; % cutoff frequency in cycles/meter
dx = 5e-6;  % pixel pitch

% Design Filter
N = 257;    % sample max size
[w1,w2,f1,f2,u,v,x,y,n1,n2] = fftshift_samples2d(N, dx); % sampling

[U, V] = meshgrid(u, v);    % mesh the u and v variables to get U and V
rho = sqrt(U.^2 + V.^2);    % get rho

H = exp(-3.44*(lambda*l*rho/r0).^(5/3));    % filter
H(rho > rho_c) = 0; % nothing below 0

% print to see the filter's effects
figure(1);
mesh(u, v, H);
title(sprintf('Atmo                 spheric OTF (r_0=%2.2f m)', r0));
xlabel('u (cyc/m)');
ylabel('v (cyc/m)');
zlabel('$|H_c(u, v)|$', 'interpreter', 'latex');

h = fftshift(ifft2(ifftshift(H)));  % centering the filter response

% Implement Filter
x = double(imread('cameraman.tif'));
xpad = padarray(x, (size(h)-1)/2, 'symmetric', 'both');
y = conv2(xpad, h, 'valid');

im(x);
im(y);

% <Change as needed.>