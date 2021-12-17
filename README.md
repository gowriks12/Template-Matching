# Template-Matching

This project consists of MATLAB code to perform template matching on an image while the ground truth file is also present. First templates for the given set of words are created, a matched spatial filter is used to carry out cross correlation and thresholding is performed. Using the information present in ground truth file, true positive rate and false positive rate of the detection is computed, using which an ROC curve for each detection is plotted.
