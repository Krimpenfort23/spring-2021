function out = model_psf( params ) 
%
% out = model_psf( params ) 
%
% Impulse invariant PSF model for diffraction limited optical system with
% detector integration and long exposure atmospheric optical turbulence. 
%
% REQUIRED INPUTS
%
% params.fnumber        F-number of optics
% params.focal_length   Focal length
% params.wavelength     Wavelength of light
% params.a              Detector active area width
% params.b              Detector active area height
% params.r0             Fried parameter
% params.dx             Horizontal detector pitch
% params.dy             Vertical detector pitch
% params.M              Output PSF width (must be odd)
% params.N              Output PSF height (must be odd)
%
% OPTIONAL INPUTS
% params.rho_c          Cutoff Frequency
%
% OUTPUTS
%
% out.psf               Discrete impulse invariant PSF
% out.H_dif
% out.H_det
% out.H_atm
% out.H_c
% out.u = u;            u for plotting width
% out.v = v;            v for plotting height
% out.n1 = n1;          n1 for plotting width
% out.n2 = n2;          n2 for plotting height
%
% Author: Evan Krimpenfort
% Date: Mar 26th
%
% COPYRIGHT © 2021 March 26th ALL RIGHTS RESERVED.
% This is UNPUBLISHED PROPRIETARY SOURCE CODE of EVAN M. KRIMPENFORT; 
% the contents of this file may not be disclosed to third parties, 
% copied or duplicated in any form, in whole or in part, without the 
% prior written permission of EVAN M. KRIMPENFORT.

% Design Filter
M = params.M;    % Output PSF Width
N = params.N;    % Output PSF Height
dx = params.dx;  % Horizontial detector pitch
dy = params.dy;  % Vertical detector pitch
[~,~,~,~,u,v,~,~,n1,n2] = fftshift_samples2d([M, N], [dx, dy]); % sampling

[U, V] = meshgrid(u, v);    % Zero Sampled Continuous Space
rho = sqrt(U.^2 + V.^2);    % get rho

fnumber = params.fnumber;       % F-number of optics
wavelength = params.wavelength; % Wavelength of light
rho_c = params.rho_c;           % Cutoff Frequency

H_dif = (2/pi).*acos(rho./rho_c) - (2.*rho)/(pi.*rho_c).*(1 - (rho./rho_c).^2).^(1/2); % filter
H_dif(rho > rho_c) = 0; % nothing below 0

a = params.a;   % Detector active area width
b = params.b;   % Detector active area height
H_det = sinc(a.*U).*sinc(b.*V); % filter

focal_length = params.focal_length; % Focal length
r0 = params.r0;                     % Fried parameter
H_atm = exp(-3.44*(wavelength*focal_length*rho/r0).^(5/3));    % filter
H_atm(rho > rho_c) = 0; % nothing below 0

H_c = H_dif.*H_det.*H_atm;  % Overall OTF
out.psf = fftshift(ifft2(ifftshift(H_c)));  % Turns H_c into a discrete function
out.H_dif = H_dif;  % H_dif
out.H_det = H_det;  % H_det
out.H_atm = H_atm;  % H_atm
out.H_c = H_c;      % H_c
out.u = u;          % u for plotting width
out.v = v;          % v for plotting height
out.n1 = n1;        % n1 for plotting width
out.n2 = n2;        % n2 for plotting height

% end of function