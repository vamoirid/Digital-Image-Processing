function imageplot(type, X1, h, X2, v, maintitle)
    
    if type == 1
        [height, width] = size(X2);
        numOfPixels = height * width;
        [hn, hx] = hist(X2(:), v);

        figure
        sgtitle(maintitle);

        subplot(2,1,1)
        imshow(X2)
        title("Image");

        subplot(2,1,2)
        bar(hx, hn/numOfPixels)
        title("Histogram");
    else
        figure
        sgtitle(maintitle);

        subplot(2,2,1)
        imshow(X1)
        title("Original Image");

        subplot(2,2,3)
        bar(v, h)
        title("Input Histogram");

        [height, width] = size(X2);
        numOfPixels = height * width;
        [hn1, hx1] = hist(X2(:), v);

        subplot(2,2,2)
        imshow(X2)
        title("Generated Image");

        subplot(2,2,4)
        bar(hx1, hn1/numOfPixels)
        title("Approximate greedy Histogram"); 
    end
end