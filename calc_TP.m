function [TP] = calc_TP(thresh_img,rows,cols,dr,dc)
%calc_TP From the thresholded image, true positives in the detected points
%are found
%   Inputs to this function are thresholded image, true locations of the
%   letters, dr and dc values. This function output TP value
TP=0; %Initialize TP value to 0
for i = 1:size(cols,2)
    part_img = thresh_img(rows(1,i)-dr:rows(1,i)+dr,cols(1,i)-dc:cols(1,i)+dc);
    flag=0; % Consider a part of the image of size of the template with respect 
    %to the true location of letter
    for x=1:size(part_img,1)
        for y=1:size(part_img,2)
            if(part_img(x,y)==255) %If a pixel value equals 255,
                TP=TP+1; %Increment TP
                flag=1; %Set flag = 1 to mark detected
                break; %Break out of first loop
            end            
        end
        if(flag==1)
            break; %Break out of second loop
        end
    end
end
end

