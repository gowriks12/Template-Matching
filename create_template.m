function [chars,coords,all_temp] = create_template(img,match)
%create_template This function creates template from the image for the
%given set of letters specified.
%   The function takes two inputs, first being the image and the second
%   being the match values for which templates has to be created. The
%   function returns characters read from the ground truth file,
%   coordinates of each charater, along with a cell that contains the
%   templates of each letter.
fileId = fopen("parenthood_gt.txt",'r'); %Reading the ground truth file
C = textscan(fileId,'%c %d %d'); %Scanning the file into a Cell
fclose(fileId);
chars = [C{1,1}]; %First value in the cell is converted to a character array
coords = [C{1,2},C{1,3}]; %Coordinate values are also coppied to a different array

match_row=zeros(1,size(match,2)); %Array to hold the value of each char location
for i = 1:size(match,2)
    for j = 1:size(chars,1)
        if match(i) == chars(j) %Find the first instance of the char in the ground truth file
            match_row(i)=j; %Copy the row value of each first occurance of character
            break; %Stop after first 
        end
    end
end
% Using the locations in the char array, respective coordinates are found
% and a template is created for each based on the way it looks. Each of
% them are saved to a temporary variable to display the template and
% eventually it is put into a cell and returned to the main function.
all_temp = {};
o_temp = img(coords(match_row(1),2)-3:coords(match_row(1),2)+7, coords(match_row(1),1)-4:coords(match_row(1),1)+5); %figure(); imshow(o_temp);
e_temp = img(coords(match_row(2),2)-5:coords(match_row(2),2)+7, coords(match_row(2),1)-3:coords(match_row(2),1)+5); %figure(); imshow(e_temp);
p_temp=img(coords(match_row(3),2)-5:coords(match_row(3),2)+11, coords(match_row(3),1)-4:coords(match_row(3),1)+5); % figure(); imshow(p_temp);
q_temp=img(coords(match_row(4),2)-3:coords(match_row(4),2)+13, coords(match_row(4),1)-3:coords(match_row(4),1)+5);% figure(); imshow(q_temp);
x_temp = img(coords(match_row(5),2)-4:coords(match_row(5),2)+9, coords(match_row(5),1)-3:coords(match_row(5),1)+5); %figure(); imshow(x_temp);

all_temp{1,1}=o_temp;
all_temp{1,2}=e_temp;
all_temp{1,3}=p_temp;
all_temp{1,4}=q_temp;
all_temp{1,5}=x_temp;
clear o_temp;clear e_temp;clear p_temp;clear q_temp;clear x_temp;
end

