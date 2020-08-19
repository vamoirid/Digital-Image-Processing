function main()
    
    x_image = imread('dip_hw1_2020/lena.bmp'); % Load image
    x_image = rgb2gray(x_image);               % Convert image to gray-scale    
    x_image = double(x_image) / 255;           % Convert range from [0,255] to [0,1]
    
    % QUESTION 1.1
    image_out1 = pointtransform(x_image, 0.1961, 0.0392, 0.8039, 0.9608);
    imageplot(1, 0, 0, image_out1, 0:1/255:1, "Point Transformation 1(a)");
    image_out2 = pointtransform(x_image, 0.5, 0, 0.5, 1);
    imageplot(1, 0, 0, image_out2, 0:1/255:1, "Point Transformation 1(b)");
    
    % QUESTION 2.1
    % Case 1
    L = 10;
    v = linspace(0,1,L);
    h = ones(1, L) / L;
    image_final1 = histtransform(x_image, h, v);
    imageplot(2, x_image, h, image_final1, v, "Histogram Transformation - Case 1");

    % Case 2
    L = 20;
    v = linspace(0,1,L);
    h = ones(1, L) / L;
    image_final2 = histtransform(x_image, h, v);
    imageplot(2, x_image, h, image_final2, v, "Histogram Transformation - Case 2");

    % Case 3
    L = 10;
    v = linspace(0,1,L);
    h = normpdf(v, 0.5) / sum(normpdf(v, 0.5));
    image_final3 = histtransform(x_image, h, v);
    imageplot(2, x_image, h, image_final3, v, "Histogram Transformation - Case 3");

    % QUESTION 2.2
    BINS = 20;
    d = linspace(0,1,BINS+1);
    v = zeros(1,size(d,2)-1);
    mu = 0.5;
    sigma = 0.1;

    for i = 2:size(d,2)
        v(i-1) = (d(i-1) + d(i))/2;
    end

    funi = @(x)unifpdf(x,0,1);
    fnorm = @(x)normpdf(x,mu,sigma);
    
    h = pdf2hist(d, funi);
    figure
    bar(v,h);
    h = pdf2hist(d,fnorm);
    figure
    bar(v,h);

    % QUESTION 2.3
    BINS = 24; 
    d = linspace(0,1,BINS+1);
    v = zeros(1,size(d,2)-1);

    for i = 2:size(d,2)
        v(i-1) = (d(i-1) + d(i))/2;
    end

    % Case 1
    funi = @(x)unifpdf(x,0,1);
    h = pdf2hist(d, funi);
    image_final1 = histtransform(x_image, h, v);
    maintitle = sprintf("Uniform pdf [0,1] - bins = %d", BINS);
    imageplot(4, x_image, h, image_final1, v, maintitle);   

    % Case 2
    funi = @(x)unifpdf(x,0,2);
    h = pdf2hist(d, funi);
    image_final2 = histtransform(x_image, h, v);
    maintitle = sprintf("Uniform pdf [0,2] - bins = %d", BINS);
    imageplot(4, x_image, h, image_final2, v, maintitle);

    % Case 3
    mu = 0.5;
    sigma = 0.1;
    fnorm = @(x)normpdf(x,mu,sigma);
    h = pdf2hist(d, fnorm);
    image_final3 = histtransform(x_image, h, v);
    maintitle = sprintf("Normal pdf [0,1] - (mu,sigma) = (%0.2f,%0.2f) - bins %d", mu, sigma, BINS);
    imageplot(4, x_image, h, image_final3, v, maintitle);
    return;
end