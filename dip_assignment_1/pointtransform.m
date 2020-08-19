function [Y] = pointtransform(X, x1, y1, x2, y2)
    [width, height] = size(X);
    Y = zeros(width, height);                                 %Initialize the output image
    
    for i = 1:width
        for j = 1:height
            if X(i,j) < x1                                    %Check if it belongs to the first part
                Y(i,j) = X(i,j)*(y1/x1);                      %Transform with respect to the function
            elseif X(i,j) < x2                                %Check if it belongs to the second part
                Y(i,j) = ((y2-y1)/(x2-x1))*(X(i,j)-x1)+y1;    %Transform with respect to the function
            else                                              %Or else it belongs to the last part
                Y(i,j) = ((1-y2)/(1-x2))*(X(i,j)-x2)+y2;      %Transform with respect to the function
            end %if
        end %for j
    end %for i
end %function