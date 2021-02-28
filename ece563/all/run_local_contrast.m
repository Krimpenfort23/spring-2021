%% Fresh Start
%
% Author:  Evan Krimpenfort
%
% Class:   ECE 563-01
%
% Purpose: To use local contrasting to make an image better. Purpose is to
%          make a function that shouldn't be written again.
clc; clear all; close all;

%% Specification
% Create a MATLAB script file named “run_local_contrast.m” and publish it 
% to “run_local_contrast.pdf” when it is complete and ready. Turn in the 
% .pdf file resulting from “publishing.” This script file should load the 
% chest x-ray image, processes it with your local contrast enhancement 
% (with input parameters that you believe best brings out extra detail[1]),
% and display the input and output image. Have it use two figures and make
% sure they are properly titled. Make sure the script is well commented 
% (along with your function).

%% Code

% load in the .mat file and convert it to a double
load('JPCNN001_small.mat');
in = double(jrst.cxr);

% show the image before image processing
im(in);
title('image before local contrasting');

% perform the local contrasting
jrst.cxr2 = local_contrast(in, 10, 5);

% show the image after image processing
im(jrst.cxr2);
title('image after local contrasting');

% end of run_local_contrast.m