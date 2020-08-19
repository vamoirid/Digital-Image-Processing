function [mapline] = myLineGenerator(img_binary,L)
%% myLineGenerator
% is a function that given a vector L as desribed in 
% myHoughTransform function and an image, outputs a 
% matrix with the image's dimensions, where all the pixels
% that are crossed by a line defined in L are incremented
% by one. 

% That means that the mapline matrix have 3 possible values.
% 0 -> when the pixel is not crossed by a line
% 1 -> if a pixel is crossed by a single line
% >1 -> if a pixel is crossed by more than a line

% Inputs: 
% img_binary -> image vector 
% L -> L vector as output of myHoughTransform 
% 
% Output: 
% mapline -> matrix with img_binary dimensions as described above

%% myLineGenerator routine
mapline = zeros(size(img_binary));
x = 1:1:size(img_binary,2); 

for i = 1:size(L,1)
    if (sin(L(i,2)) == 0)
        mapline(:,L(i,1)) =  mapline(:,L(i,1)) + 1;
    else
        y = (L(i,1) - x * cos(L(i,2)))/sin(L(i,2));
        for k = 1:size(img_binary,2) 
            if ( y(k) >= 1 && y(k) <= size(img_binary,1))
                mapline(round(y(k)), x(k)) =  mapline(round(y(k)), x(k)) + 1;
            end
        end
    end  
end

end

