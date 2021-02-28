function opt = optical_parameters( opt )
%
% opt = optical_parameters( opt )
% 
% Computed basic optical parameters for an imaging system.  
%
% REQUIRED INPUT FIELDS
% opt.wavelength        Wavelength of light used (meters)
% opt.focal_length      Focal length (meters) % (often seen as l)
% opt.f_number          F-number of optics (often seen as f/#)
% opt.fpa_pitch         Actual FPA detector pitch (meters)
% opt.fpa_size          Width of FPA in (meters) % (often seen as X)
% opt.distance          Distance to object plane in (meters) % (often seen as do)
%
% OUTPUT FIELDS ADDED
% opt.aperture          Aperture diameter (meters)
% opt.cutoff_focal      Maximum # of spatial cycles that can be
%                       theoretically “resolved” per m in the focal plane
%                       (cycles/meter)
% opt.cutoff_object     Spatial cutoff frequency as seen in the object
%                       plane (cycles/meter)
% opt.cutoff_angular    Maximum # of spatial cycles that can be
%                       theoretically “resolved” per radian (toward object
%                       or FPA) (cycles/radian)
% opt.image_distance    Distance from lens to focused image (meters)
% opt.magnification     Linear magnification of optical system (unitless)
% opt.angular_fov       Field of view (radians) 
% opt.spatial_fov       Field of view (meters) 
% opt.sampling_frequency Spatial sampling frequency (1/pitch) (cyc/m)
% opt.Nyquist_pitch     Detector pitch required for Nyquist sampling
% opt.undersampling     Undersampling factor
% opt.pix2object        Scales fpa_pitch to object plane
%
% Author: Evan Krimpenfort
% University of Dayton
% ECE 563 Image Processing with Dr. Russell Hardie 
% Date:  February 9th, 2021

% Aperture diameter (meters)
opt.aperture = opt.focal_length/opt.f_number;

% Maximum # of spatial cycles that can be
% theoretically “resolved” per m in the focal plane
% (cycles/meter)
opt.cutoff_focal = 1/(opt.wavelength * opt.f_number);

% Spatial cutoff frequency as seen in the object
% plane (cycles/meter)
opt.cutoff_angular = opt.aperture / opt.wavelength;

% Maximum # of spatial cycles that can be
% theoretically “resolved” per radian (toward object
% or FPA) (cycles/radian)
opt.cutoff_object = opt.cutoff_angular/opt.distance;

% Distance from lens to focused image (meters)
opt.image_distance = inv((1/opt.focal_length) - (1/opt.distance));

% Linear magnification of optical system (unitless)
opt.magnification = opt.focal_length/(opt.focal_length - opt.distance);

% Field of view (radians) 
opt.angular_fov = 2 * atan(opt.fpa_size/(2 * opt.focal_length));

% Field of view (meters)
opt.spatial_fov = opt.fpa_size/abs(opt.magnification);

% Spatial sampling frequency (1/pitch) (cyc/m)
opt.sampling_frequency = 1/opt.fpa_pitch;

% Detector pitch required for Nyquist sampling
opt.Nyquist_pitch = 1/(2 * opt.cutoff_focal);

% Undersampling factor
opt.undersampling = opt.fpa_pitch / opt.Nyquist_pitch;

% Scales fpa_pitch to object plane
opt.pix2object = opt.fpa_pitch / opt.cutoff_object;

% End of function