%% Fresh Start
% Author:  Evan Krimpenfort
% Class:   ECE 563-01
% Purpose: Simple Image Processing with our Camera
clc; clear all; close all;

%% Specification
% Preface: Take a picture of something (ex. yourself) that is a color
% image. Write a well commented MATLAB script to perfomr the following
% tasks.
%
% 1. Load the image with imread()
% 2. Display the image with im()
% 3. Extract the green color channel, producing a grayscale image array.
% Give the Grayscale image a new variable name.
% 4. Display the Grayscale image with im().
% 5. Compute and display the correct histogram of the grayscale image using
% hist(), histogram(), and/or imhist().
% 6. Crop the image around your head and face with the MATLAB indexing
% operation. Give the cropped image array a new variable name.
% 7. Display the cropped image with im().
% 8. Write the cropped grayscale image with imwrite() as a .png image. You
% DO NOT need to keep or uplaod this image. Just verify that it open using
% your favorite image viewer and then delete it.
%
% Upload the script file as a .pdf using MATLAB's publish tab.
%% Code
% Read the image using imread().
image = imread('myself.tif');

% Display the image in a figure using im().
figure(1);
im(image);

% To extract the green color, you need to get the 2nd layer of the 3
% dimensional array by doing all, all, and 2. it is 2 because of rGb. G is
% the second element.
green_image = image[:,:,2];

% Display your new image. It will be grayscale because the array is now a 2
% dimensional array.
im(green_image);

% <Change as needed.>