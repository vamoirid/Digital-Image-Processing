function [rotImg] = myImgRotation(img, angle)
    [ROWS, COLS, DIM] = size(img); 

%% Calculating imagepad
    diagonal = sqrt(ROWS^2 + COLS^2); 
    rowPad = ceil(diagonal - ROWS) + 2;
    colPad = ceil(diagonal - COLS) + 2;
    imagepad = zeros(ROWS+rowPad, COLS+colPad,DIM);
    imagepad(ceil(rowPad/2):(ceil(rowPad/2)+ROWS-1), ceil(colPad/2):(ceil(colPad/2)+COLS-1), 1:DIM) = img(1:ROWS,1:COLS,1:DIM);
    centerX = ceil((size(imagepad,1)+1)/2);
    centerY = ceil((size(imagepad,2)+1)/2);

%% Rotation routine
    rotImg = zeros(size(imagepad)); 
    for dim = 1:DIM %dimensions or else rgb
        for i = 1:size(rotImg,1) %rows of rotImg
            for j = 1:size(rotImg,2) %cols of rotImg
                x = (i-centerX)*cos(angle)+(j-centerY)*sin(angle);
                y =-(i-centerX)*sin(angle)+(j-centerY)*cos(angle);
                x = round(x)+centerX;
                y = round(y)+centerY;

                if (x >= 2 && y >= 2 && x <= (size(imagepad,1)-1) && y <= (size(imagepad,2)-1))
                   rotImg(i,j,dim)=(imagepad(x,y+1,dim) + imagepad(x-1,y,dim) + imagepad(x+1,y,dim) + imagepad(x,y-1,dim)) / 4; % k degrees rotated image         
                end %endif
            end %end of COLS
        end %end of ROWS
    end %end of dimensions

%% Image formation
    rotImg = normalize(rotImg,'range'); %normalize in [0,1]
    rotImg = im2uint8(rotImg);
end

