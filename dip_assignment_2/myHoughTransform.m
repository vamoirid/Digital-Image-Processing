%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% MYHOUGHTRANSFORM computes the Hough Transformation of an image          %
%                                                                         %
% USAGE: [H, L, res] = myHoughTransform(img_binary, Drho, Dtheta, n)      %
%                                                                         %
% DESCRIPITION: The Hough Transformation is computed in this routine.     %
% After the main code of the transformation is done, the colormap of the  %
% Hough Table is plotted. In addition to this, n peaks of the Hough Table %
% are found and used in order to calculate the L array. Finally, the res  %
% value is calculated.                                                    %
%                                                                         %
% INPUTS                                                                  %
% 1) img_binary: is the input image in binary form                        %
% 2) Drho: is the step used for the rho values                            %
% 3) Dtheta: is the step used for the theta values                        %
% 4) n: is the number of lines to be found                                %
%                                                                         %
% OUTPUTS                                                                 %
% 1) H: is the Hough Transformed Table                                    %
% 2) L: is the array with the rho and theta values of the n lines         %
% 3) res: is the number of points not contributing to lines               %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [H, L, res] = myHoughTransform(img_binary, Drho, Dtheta, n)
%% Initializations
    [ROWS, COLS] = size(img_binary);        %image dimensions
    rhoMax = round(sqrt(ROWS^2 + COLS^2));  %max rho value
    thetaMax = 2*pi;                        %max theta value
    rho = 1:Drho:rhoMax;                    %rho discrete values
    theta = 0:Dtheta:(thetaMax-Dtheta);     %theta discrete values
    H = zeros(length(rho), length(theta));  %initialize Hough Table
    
%% Hough Transform
    for r = 1:ROWS
        for c = 1:COLS
            if img_binary(r,c) ~= 0
                for iTheta = 1:length(theta)
                    distRho = c*cos(theta(iTheta)) + r*sin(theta(iTheta));                    
                    for iRho = 1:(length(rho) - 1)
                        if (distRho >= rho(iRho) && distRho < rho(iRho+1))
                            H(iRho, iTheta) = H(iRho, iTheta) + 1;
                            break;
                        end % if distRho
                    end % for iRho
                end % for iTheta
            end % if img_binary ~= 0
        end % for COLS
    end % for ROWS
    
%% Find peaks 
    indexL = myHoughPeaks(H, n, 0.2);
    
%% Compute L and res
    L(:,1) = rho(indexL(:,1));
    L(:,2) = theta(indexL(:,2));
    res = myResCalc(img_binary, L);

%% Plot colormap and peaks
    figure, imshow(H,[],'XData',theta,'YData',rho, 'InitialMagnification','fit');
    colormap(gca,hot);
    xlabel('\theta'), ylabel('\rho');
    axis on, axis normal, hold on;
    x = L(:,2); y = L(:,1);
    plot(x,y,'s','color','white');
end