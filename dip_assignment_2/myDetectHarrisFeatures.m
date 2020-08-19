%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% MYDETECTHARRISFEATURES computes the corners of an image                 %
%                                                                         %
% USAGE: [corners] = myDetectHarrisFeatures(im)                           %
%                                                                         %
% DESCRIPTION: The algorithm uses the Laplacian of Gaussian approach in   %
% order to calculate the appropriate variables for the algorithm. There   %
% is a series of equations acquired both by the slides taught in class    %
% and also by the book "Digital Image Processing" from Rafael C. Gonzalex %
% & Richard E. Woods.                                                     %
%                                                                         %
% INPUTS                                                                  %
% 1) im: is the input image                                               %
%                                                                         %
% OUTPUTS                                                                 %
% 1) corners: array of n*2 which holds the coordinates of n corners.      %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [corners] = myDetectHarrisFeatures(im)
%% Initializations
    [ROWS, COLS] = size(im);
    imageR = zeros(ROWS,COLS);
    
    k = 0.05;
    Threshold = 92*10^(-4);
    sigma = 1;
    coords = sigma * 1;
    
%% Computations 
    % 1) Compute meshgrid
    [xx, yy] = meshgrid(-coords:coords,-coords:coords);
    
    % 2) Compute Laplacian of Gaussian (LoG) 
    Gxy = exp(-(xx.^2 + yy.^2)/(2*sigma^2));
    Gx = xx .* Gxy;
    Gy = yy .* Gxy;

    % 3) Compute x and y derivatives of image through convolution
    Ix = conv2(Gx,im);
    Iy = conv2(Gy,im);

    % 4) Compute products and powers of derivatives at every pixel
    Ix2 = Ix .^ 2;
    Iy2 = Iy .^ 2;
    Ixy = Ix .* Iy;

    % 5) Compute the convolution of the products of derivatives at each pixel
    Sx2 = conv2(Gxy,Ix2);
    Sy2 = conv2(Gxy,Iy2);
    Sxy = conv2(Gxy,Ixy);

%% Generate R image
    for x = 1:ROWS
       for y = 1:COLS
           H = [Sx2(x,y) Sxy(x,y); Sxy(x,y) Sy2(x,y)];  % 6) Compute at each pixel the mask H
           R = det(H) - k*(trace(H)^2);                 % 7) Compute the AngleMetric at each pixel
           if (R > Threshold)
              imageR(x,y) = R;                          % 8) Threshold on value of R
           end % endif
       end % end for COLS
    end % end for ROWS
    
%% Dilate image
    [cornerLoc, cornerCount] = myCornerFiltering(imageR);

%% Generate corner array
    count = 1;
    corners = zeros(cornerCount,2);
    for r = 1:ROWS
        for c = 1:COLS
            if cornerLoc(r,c) == 1
                corners(count,1) = c;
                corners(count,2) = r;
                count = count + 1;
            end %endif
        end %end of COLS
    end %end of ROWS
end