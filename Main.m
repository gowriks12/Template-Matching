clc; clear all; close all;
%% Creating templates
img = imread("parenthood.ppm");
match =['o','e','p','q','x'];
figure();
imshow(img);title("Input Image");
%%
[chars,coords,all_temp]=create_template(img,match);

%% Character that has to be matched
var = input('Pick a letter "o,e,p,q,x" (type 1 for "o" and so on)');
char = match(var);
template = double([all_temp{1,var}]);
t8 = uint8(template);
figure(); imshow(t8); title("Template");
%% Zero mean template
% Template has to be subtracted with it's mean to convert it into a
% zero-mean template
mean_template = template - mean(mean(template));
mean_template8 = uint8(mean_template);
figure,imshow(mean_template8); title("Zero mean template");
%% Padding
% With respect to the template size, padding is done to the input image
[dr,dc]=size(template); 
dr = round((dr-1)/2); %Half of the number of rows
dc = round((dc-1)/2); %Half of the number of columns
img_pad = padarray(img,[dc,dr],'both'); %Padding image
figure(),imshow(img_pad); title("Padded Image");
%% Finding the true positions of template using ground truth file
j=1; %Iterative variable
clear cols;
clear rows;
for i = 1:size(chars,1)    %Iterate though characters 
    if chars(i) == char    %If character is found in the chars array,
        cols(j) = coords(i,1); %Coppy the column and row value from coords array
        rows(j) = coords(i,2);
        j=j+1;       %Increase count
    end   
end
true_detected = img; %Visualizing the expected detected ouput
for i = 1:size(cols,2)
    true_detected(rows(1,i):rows(1,i)+3,cols(1,i):cols(1,i)+3)=0; 
    %set expected letter center to 0
end 
figure(), imshow(true_detected); title("True locations of template");
%% Calculating the Matched spatial filter image
%Cross correlation between padded image and the template
msf = cross_corr(img_pad,mean_template); %Cross correlation function is called
msf = ((msf - min(min(msf)))./(max(max(msf))-min(min(msf)))).*255; %Normalizing the msf image
msf8 = uint8(msf);
msf8 = msf8(dc+2:size(msf8,1)-(dc+3),dr+2:size(msf8,2)-(dr+5)); %Removing padding
figure,imshow(msf8);title("MSF Image");
%% Thresholding
iter = 1;
clear TPR;
clear FPR;
for th = 180:10:250
    [thresh_img,out_img,detected] = thresholding(msf8,th,img,dr,dc); %Thresholding MSF image
    thresh_img = uint8(thresh_img); %Converting threshold image into uint8
    %out_img = uint8(out_img);  
    TP = calc_TP(thresh_img,rows,cols,dr,dc); %Calculating True positives
    FP = abs(size(detected,2)-TP); %Calculating FP
    FN = abs(size(cols,2)-TP); %Calculating FN
    TN = abs(size(chars,1)-size(cols,2)-FP); %Calculating TN
    disp('True positive=');disp(TP);
    disp('False positive=');disp(FP);
    disp('False negative=');disp(FN);
    disp('True negative=');disp(TN);
    TPR(iter) = (TP/(TP+FN)); %Calculating TPR      
    FPR(iter) = (FP/(FP+TN)); %Calculating FPR    
    iter=iter+1;
end
disp('TPR=');disp(TPR);
disp('FPR=');disp(FPR);
%% ROC curve
%Plotting ROC curve
figure(),plot(FPR,TPR,'r*');hold on;
plot(FPR,TPR,'b');xlabel("FPR");ylabel("TPR"); title("ROC curve");
%% Cross confusion matrix
th =230; 
[thresh_img,out_img,detected] = thresholding(msf8,th,img,dr,dc);
out_img = uint8(out_img);
figure(), imshow(out_img); title("Teamplates detected for th=230");
TP = calc_TP(thresh_img,rows,cols,dr,dc); %Calculating True positives
FP = abs(size(detected,2)-TP); %Calculating FP


