%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% MYHOUGHLINES plots the lines in the L array                             %
%                                                                         %
% USAGE: myHoughLine(imageIn, L, n)                                       %
%                                                                         %
% DESCRIPTION: For each line n, 4 possible endpoints are calculated. With %
% respect to the maximum dimensions of the image. Ater this, the 4        %
% possible endpoints are compared with the image dimensions in order to   %
% find the 2 which are the real ones. Finally the line is plotted.        %
%                                                                         %
% INPUTS                                                                  %
% 1) imageIn: is the input image                                          %
% 2) L: is the array with the rho and theta values of the n lines         %
% 3) n: is the number of lines to be plotted                              %
%                                                                         %
% OUTPUTS                                                                 %
% (None)                                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function myHoughLines(imageIn, L, n)
%% Initializations
    figure, imshow(imageIn), axis on, axis normal, hold on;
    [ROWS, COLS] = size(imageIn);

%% Compute all possible endpoints
    for iLines = 1:n
        xyStartEndCoords = zeros(4,2); % x = 1st argument, y = 2nd argument
        pointsCnt = 1;
        xy = zeros(2,2); % final Start-End coords
        
        % x = r - y * sin(theta) / cos(theta)
        % y = r - x * cos(theta) / sin(theta)
        
        %Upper point xyCoord(1,:) = (x,1) 
        xyStartEndCoords(1,2) = 1;
        xyStartEndCoords(1,1) = round((L(iLines,1) - xyStartEndCoords(1,2) * sin(L(iLines,2))) / cos(L(iLines,2)));
        
        %Lower point xyCoord(2,:) = (x,ROWS) 
        xyStartEndCoords(2,2) = ROWS;
        xyStartEndCoords(2,1) = round((L(iLines,1) - xyStartEndCoords(2,2) * sin(L(iLines,2))) / cos(L(iLines,2)));
        
        %Right-er point xyCoord(3,:) = (COLS,y) 
        xyStartEndCoords(3,1) = COLS;
        xyStartEndCoords(3,2) = round((L(iLines,1) - xyStartEndCoords(3,1) * cos(L(iLines,2))) / sin(L(iLines,2)));
        
        %Left-er point xyCoord(4,:) = (1,y) 
        xyStartEndCoords(4,1) = 1;
        xyStartEndCoords(4,2) = round((L(iLines,1) - xyStartEndCoords(4,1) * cos(L(iLines,2))) / sin(L(iLines,2)));

%%  Compute real endpoints
        for i = 1:4
            if (xyStartEndCoords(i,1) >= 1 && xyStartEndCoords(i,1) <= COLS && xyStartEndCoords(i,2) >= 1 && xyStartEndCoords(i,2) <= ROWS)
                xy(pointsCnt,1) = xyStartEndCoords(i,1);
                xy(pointsCnt,2) = xyStartEndCoords(i,2);
                pointsCnt = pointsCnt + 1;
            end % endif
        end % end for

%% Plot the line
        % Construct line
        plot(xy(:,1), xy(:,2), 'r', 'LineWidth', 2);
    end %for iLines
end