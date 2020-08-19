%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% MYCORNERFILTERING filters the input corner array                        %
%                                                                         %
% USAGE: [cornerLoc, cornerCount] = myCornerFiltering_2(imageR)           %
%                                                                         %
% DESCRIPTION: A window of size SWxSW is used in order to hold only one   %
% corner in the SWxSW area.                                               %
%                                                                         %
% INPUTS                                                                  %
% 1) imageR: image which holds the metric R instead of pixel dim          %
%                                                                         %
% OUTPUTS                                                                 %
% 1) cornerLoc: an array with the image dimensions with the value 1 in    %
% every pixel that has a corner on it.                                    %
% 2) cornerCount: number of corners left in the array.                    %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [cornerLoc, cornerCount] = myCornerFiltering(imageR)
%% Initializations
    [ROWS, COLS] = size(imageR);
    SW = 7; %searchWindow size
    cornerLoc = zeros(ROWS,COLS);
    cornerCount = 0;

%% Filtering Procedure
    for r = 1:(ROWS-SW)
        for c = 1:(COLS-SW)
            max = 0;
            rMax = 0;
            cMax = 0;
            if imageR(r,c) ~= 0
                for i = r:(r+SW)
                    for j = c:(c+SW)
                        if imageR(i,j) > max
                            max = imageR(i,j);
                            rMax = i;
                            cMax = j;
                        end % if max
                        imageR(i,j) = 0;
                    end % for COLS-window
                end %end for ROWS-window
                cornerLoc(rMax,cMax) = 1;       %Corner here
                cornerCount = cornerCount + 1;  %Increase counter
            end % if not imageR
        end % for COLS
    end % for ROWS
end