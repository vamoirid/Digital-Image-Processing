function [Y] = histtransform(X, h, v)
    [width, height] = size(X);                        %image dimensions                   
    numOfPixels = height * width;                     %total number of pixels
    cntPixel = 0;                                     %counter for pixels
    n = 1;                                            %initialize the n value to point to the first value of h(n) & v(n)
    Y = zeros(width,height);                          %initialize the output image
    
    image1Dsorted = unique(X);                        %1D sorted array with all the different brightness values

    for cntLum = 1:size(image1Dsorted, 1)
        for i = 1:width
            for j = 1:height
                if X(i,j) == image1Dsorted(cntLum)    %if the pixel brightness is equal to the sorted brightness
                    Y(i,j) = v(n);                    %set the output value of this pixel to v(n)
                    cntPixel = cntPixel + 1;          %add one more pixel to the counter
                end %if
            end %for height
        end %for width
        
        if (cntPixel/numOfPixels >= h(n))             %check if the value is passed (greedy)
            n = n + 1;                                %add 1 for the next value of h(n) & v(n)
            cntPixel = 0;                             %reset counter to zero for the next value
        end %if
    end %for image1Dsorted
end %function