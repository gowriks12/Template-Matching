function [thresh_img,img,detected] = thresholding(msf_img,th,img,dr,dc)
%thresholding Thresholds the msf image to a given threshold value and
%returns image with detected letters marked
%   Inputs to the function are msf image, threshold, dr and dc. The
%   function thresholds and outputs the thresholded image, image with
%   detected points marked and array with detected point values.
thresh_img = zeros(size(msf_img));
y=1;
for i=1:size(msf_img,1)
    for j=1:size(msf_img,2)
        if(msf_img(i,j)>th)
            thresh_img(i+dr-1:i+dr+1,j+dc-1:j+dc+1) = 255; %Set the value in threshold image =255
            img(i+dr-1:i+dr+1,j+dc-1:j+dc+1) = 0; %Mark the detected values to 0
            detected(1,y)=i+dr;
            detected(2,y)=j+dc;
            y=y+1;
        end
    end
end
end

