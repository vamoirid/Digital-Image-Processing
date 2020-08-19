%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% MYHOUGHPEAKS finds peaks in Hough Table                                 %
%                                                                         %
% USAGE: [indexL] = myHoughPeaks(H,numH,thresFactor);                     %
%                                                                         %
% DESCRIPTION: Firstly, a search procedure is conducted in order to find  %
% the n first maximum values of the Hough Table. After every maximum that %
% is found (except for the 1st one) its rho and theta values are compared %
% with the values of the previous found maximums. If their rho or theta   %
% values are closer than deltaRho or deltaTheta then it is assumed that   %
% it is the same line due to Hough Transformation accuracy. Thus the      %
% maximum is not considered a valid one and so another one must be        %
% computed.                                                               %
%                                                                         %
% INPUTS                                                                  %
% 1) H: is the transformed Hough Table                                    %
% 2) numH: is the number of peaks to be found                             %
% 3) thresFactor: is a factor of the maximum value in Hough Table which   %
% is used as a threshold.                                                 %
%                                                                         %
% OUTPUTS                                                                 %
% 1) indexL: is an array which holds the indexes of the rho and theta     %
% values of each peak found. The ncol=1 has the rho indexes, the ncol=2   %
% has the theta indexes and the ncol=3 holds the number of votes of this  % 
% set of rho and theta.                                                   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [indexL] = myHoughPeaks(H,numH,thresFactor)
%% Initializations
    [ROWS, COLS] = size(H);             %image dimensions
    threshold = thresFactor * max(H);   %lower threshold for peak
    maxH = zeros(numH,1);               %values of votes for peaks
    indexL = zeros(numH,3);             %votes number and indexes of rho/theta
    deltaRho = 11;                      %minimum rho distance for different line
    deltaTheta = 6;                     %minimum theta distance for different line
    i = 1;                              %peak counter
    
%% Search for maximum values 
    while i <= numH
        maxH(i,1) = 0;
        for r = 1:ROWS
            for c = 1:COLS
                if H(r,c) >= threshold 
                    if H(r,c) > maxH(i,1)
                        maxH(i,1) = H(r,c);
                        indexL(i,3) = H(r,c);   %votes
                        indexL(i,1) = r;        %rho
                        indexL(i,2) = c;        %theta
                    end % if H > max
                end % if H > thresh
            end % for COLS
        end %for Rows
        H(indexL(i,1), indexL(i,2)) = 0;
        
%% Delete very narrow (duplicate) peaks
        if i > 1
            for j = 1:(i-1)
                if (abs(indexL(j,1) - indexL(i,1)) < deltaRho) && ((abs(indexL(j,2) - indexL(i,2)) < deltaTheta) || abs((360 - indexL(j,2)) - indexL(i,2)) < deltaTheta)
                    %indexL(j,3) = indexL(j,3) + indexL(i,3);
                    i = i - 1;  %delete line
                    break;
                end % if deltaRho/Theta
            end % for
        end % if not
        
        %LAST line before the end of the loop
        i = i + 1;
    end % while
end