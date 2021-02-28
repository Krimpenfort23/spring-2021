%% Fresh Start
%
% Author:  Evan Krimpenfort
%
% Class:   ECE 563-01
%
% Purpose: Looking at the equations dealing with the analysis of certain
% input parameters in the optical world.
clc; clear all; close all;

%% Specification
% Test your function with the input parameters listed below and report 
% your output. You should write a script file to set the input parameters 
% below, call the new function, and display the output structure 
% to the command window. Name this “test_optical_parameters.m”
% to complement your functionthat should be in its own file called 
% “optical_parameters.m” Publish the script to a .pdf file and upload 
% the .pdf and your “optical_parameters.m” function file to Isidore.
% The published script should show your inputs and your outputs.

%% Code

% set all input parameters
opt.wavelength = 0.50e-6 % meters
opt.focal_length = 8e-3  % meters
opt.f_number = 8         % F/# (# = 8)
opt.fpa_pitch = 5.4e-6   % meters
opt.fpa_size = 6.4e-3    % meters
opt.distance = 5         % meters

% run the test script.
post_opt = optical_parameters(opt)

% end of test_optical_parameters.m