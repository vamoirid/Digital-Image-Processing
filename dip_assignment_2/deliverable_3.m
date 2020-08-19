%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                         %
% DELIVERABLE_3 computes question 1.2                                     %
%                                                                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear;
imageIn = imread('images/im2.jpg');
im = imresize(imageIn,0.1);
rotImg54 = myImgRotation(im, 54 * pi/180);
rotImg213 = myImgRotation(im, 213 * pi/180);

figure, imshow(im); title('0 degrees rotation');
figure, imshow(rotImg54); title('54 degrees rotation');
figure, imshow(rotImg213); title('213 degrees rotation');