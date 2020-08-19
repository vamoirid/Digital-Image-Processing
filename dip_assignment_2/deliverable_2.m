%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                         %
% DELIVERABLE_2 computes question 1.2                                     %
%                                                                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Initializations
clear;
imageIn = imread('images/im2.jpg'); 
blackNwhiteFull = rgb2gray(imageIn); 
blackNwhiteFull = double(blackNwhiteFull) / 255;
imageBW  = imresize(blackNwhiteFull,1/10);
[ROWS, COLS] = size(imageBW);

%% Matlab's Harris Corner Detector
cornersMat = detectHarrisFeatures(imageBW);
figure;
imshow(imageBW);
hold on;
d=5;
for i = 1:size(cornersMat,1)
    x = cornersMat.Location(i,1) - d/2;
    y = cornersMat.Location(i,2) - d/2;
    pos = [x y d d];
    rectangle('Position', pos, 'EdgeColor', 'r', 'LineWidth', 1); 
end
hold off; title('MatlabDetectHarrisFeatures');

%% My Harris Corner Detector
corners = myDetectHarrisFeatures(imageBW);
figure;
imshow(imageBW)
hold on;
for i = 1:size(corners,1)
    pos2 = [corners(i,1)-5 corners(i,2)-5 5 5];
    rectangle('Position', pos2, 'EdgeColor', 'r', 'LineWidth', 1);
end
hold off; title('myDetectHarrisFeatures');