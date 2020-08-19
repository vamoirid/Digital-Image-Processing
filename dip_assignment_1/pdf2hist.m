function h = pdf2hist(d, f)
    h = zeros(1,size(d,2)-1);               %Initialize the array of h values
    
    for i = 2:size(d,2)                     %Parse every d(n) value and calculate h(n)
        %Simpson's Rule
        x0 = d(i-1);
        x2 = d(i);
        x1 = (x0+x2)/2;
        a = (x2-x0)/2;
        h(i-1) = a/3 * (f(x0)+4*f(x1)+f(x2));
        %h(i-1) = integral(f,d(i-1),d(i));   %Use the f function provided in order to calculate h(n)
    end %for
    
    for i = 1:size(h,2)                     %Parse every h(n) value
        if (d(i+1) + d(i))/2 > 1            %If v(n) > 1 which is not a viable number for brigtness
            h(i) = 0;                       %Eliminate the probability of this value
        end %if
    end %for
    
    h = h/sum(h);                           %scale h(n) values to sum into 1.
end %function