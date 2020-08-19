%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% MYRESCALC calculates the res value of the image                         %
%                                                                         %
% USAGE: [res] = myResCalc(img_binary, L)                                 %
%                                                                         %
% DESCRIPTION: For every line that is calculated from the L array values  %
% all the pixels that belong to it get a vote. If a pixel belongs to more %
% than one line gets another vote so there are 2 possible outcomes.       %
% pixelInLine(r,c) == 0 -> pixel does not belong in any line.             %
% pixelInLine(r,c) >= 1 -> pixel belongs to one or more than one lines.   %
%                                                                         %
% INPUTS                                                                  %
% 1) img_binary: is the input image in binary form                        %
% 2) L: is the array with the rho and theta values of the n lines         %
%                                                                         %
% OUTPUTS                                                                 %
% 1) res: is the number of points that do not belong to any line          %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [res] = myResCalc(img_binary, L)
%% Initializations
    [ROWS, COLS] = size(img_binary);
    pixelInLine = zeros(ROWS,COLS);
    x = 1:COLS;
    res = 0;
    
%% Voting process 
    for iLines = 1:size(L,1) %NumOfLines
        if sin(L(iLines,2)) == 0 %horizontal line
            pixelInLine(:,L(iLines,1)) = pixelInLine(:,L(iLines,1)) + 1;
        elseif sin(L(iLines,2)) == 1 %vertical line
            pixelInLine(L(iLines,1),:) = pixelInLine(L(iLines,1),:) + 1;
        else
            y = (L(iLines,1) - x * cos(L(iLines,2)))/sin(L(iLines,2));
            for j = 1:COLS
                if (y(j) >= 1 && y(j) <= ROWS)
                    pixelInLine(round(y(j)), x(j)) = pixelInLine(round(y(j)), x(j)) + 1;
                end % if y
            end % for j
        end % if sin
    end % for iLines
    
%% Calculate res  
    for r = 1:ROWS
        for c = 1:COLS
            if pixelInLine(r,c) == 0
                res = res + 1;
            end
        end
    end
end % resCalc