function [corr_img] = cross_corr(img,template)
%cross_corr Computes cross correlation between image and template
%   The function takes image and template as two values and computes cross
%   correlation between them and returns it.
img = double(img); %Convert the image to double
[rows,cols]=size(template); %Determine the size of the template
corr_img = zeros(size(img)); %Initialize the correlation output image
for i=1:size(img,1)-rows-1
    for j=1:size(img,2)-cols-1
        Nimage = img(i:i+rows-1,j:j+cols-1); %Part of the image of size of template       
        corr = sum(sum(Nimage.*template)); %Correlation
        corr_img(i,j)= corr/sqrt(sum(sum(Nimage.^2))); %Assigning value to 
        %correlation image after some modifications
    end
end
end

