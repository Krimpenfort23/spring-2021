%% Fresh Start
% Author:  Evan Krimpenfort
% Class:   ECE 563-01
% Purpose: to test the model_psf.m function
clc; clear all; close all;

%% Code

% setting up params
params.fnumber = 3;
params.focal_length = 150e-3;   % meters
params.wavelength = 0.5e-6;     % meters
params.rho_c = 1/(params.wavelength*params.fnumber); % Cutoff frequency
rho_s = 2*params.rho_c;         % sampling frequency
params.a = 1/rho_s;
params.b = 1/rho_s;
params.r0 = 0.02;
params.dx = params.a;
params.dy = params.b;
params.M = 51;
params.N = 51;

out = model_psf( params );  % process the filter

%% print to see the filter's effects

% Overall PSF
figure;
mesh(out.n1, out.n2, out.psf);
title(sprintf('Overall PSF (r_0=%2.2f m)', params.r0));
xlabel('n1 (samples/m)');
ylabel('n2 (samples/m)');
zlabel('$|PSF(n1, n2)|$', 'interpreter', 'latex');

% H_dif
figure;
mesh(out.u, out.v, out.H_dif);
title(sprintf('Diffraction OTF (r_0=%2.2f m)', params.r0));
xlabel('u (cyc/m)');
ylabel('v (cyc/m)');
zlabel('$|H_dif(u, v)|$', 'interpreter', 'latex');

% H_det
figure;
mesh(out.u, out.v, out.H_det);
title(sprintf('Detector OTF (r_0=%2.2f m)', params.r0));
xlabel('u (cyc/m)');
ylabel('v (cyc/m)');
zlabel('$|H_det(u, v)|$', 'interpreter', 'latex');

% H_atm
figure;
mesh(out.u, out.v, out.H_atm);
title(sprintf('Atmospheric OTF (r_0=%2.2f m)', params.r0));
xlabel('u (cyc/m)');
ylabel('v (cyc/m)');
zlabel('$|H_atm(u, v)|$', 'interpreter', 'latex');

% H_c
figure;
mesh(out.u, out.v, out.H_c);
title(sprintf('Overall OTF (r_0=%2.2f m)', params.r0));
xlabel('u (cyc/m)');
ylabel('v (cyc/m)');
zlabel('$|H_c(u, v)|$', 'interpreter', 'latex');

%% ideal input v. output
in = double(imread('Dream-Factory.JPEG'));  % Read image
in_gray = double(in(:,:,2));                % Make it gray
x = imresize(in_gray, 0.4);                 % resize to get in the 255 range
xpad = padarray(x, (size(out.psf)-1)/2, 'symmetric', 'both');
y = conv2(xpad, out.psf, 'valid');

im(x); title('Input');
im(y); title('Filtered');

%% Finding Error
vector_r0 = linspace(0.01, 0.05, 10);
vector_err = zeros(1,10);

for i = 1 : 10
    params.r0 = vector_r0(i);   % modify the r0 component
    out = model_psf( params );  % process the filter
    xpad = padarray(x, (size(out.psf)-1)/2, 'symmetric', 'both');
    y = conv2(xpad, out.psf, 'valid');
    err = dif(x, y);            % difference between the photos (error)
    vector_err(i) = err.mae;    % mean absolute error
end

figure;
plot(vector_r0, vector_err);
title('r0 v. err');
xlabel('vector r0 (meters)');
ylabel('vector err');

% run_model_psf.m