%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                         %
% DELIVERABLE_1 computes question 1.1                                     %
%                                                                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear;
%% Load the Image and make the right adjustments
imageIn = imread('images/im2.jpg');
originalImageResized = imresize(imageIn,0.1);
blackNwhiteFull = rgb2gray(imageIn);
blackNwhiteFull = double(blackNwhiteFull) / 255;
blackNwhite = imresize(blackNwhiteFull,0.1);

%% Choose detector and its characteristics
edgeDetector = 'Canny';
edgeThreshold = [0.26 0.34];
sigma = 1.2;

img_binary = edge(blackNwhite, edgeDetector, edgeThreshold, sigma);
figure, imshow(img_binary), title(edgeDetector);

%% Choose number of lines, rho/theta steps & compute the 1.1 question
n = 11;
Drho = 1;
Dtheta = 2*pi/360;

[H, L, res] = myHoughTransform(img_binary, Drho, Dtheta, n);
myHoughLines(originalImageResized, L, n);