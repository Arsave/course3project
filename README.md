---
title: "Readme for Getting and Cleaning Data courese project"
author: "Artyom Savelyev"
date: '2 april 2017 '
output: html_document
---

run_analysis.R contains one function which performs:

(list items correspond to ones within the script)

#####  Loads "dplyr" package.

#####1. Reads data into data frames from both training and test data sets:  
        Main data set into "x_test" and "x_train" data frames.  
        Activity indexes into "y_test" and "y_train" data frames.  
        Subject indexes into "s_test" and "s_train" data frames.  
   Reads activity labels into "activity_labels" data frame.  
   Reads features names into "features" data frame.  
   
#####2. Appends activity indexes to main "x" data frames from corresponding "y" data frames.  
        As the original "y" data set contains only one variable and the same number of rows as the original "x" data set I assume that it corresponds to observations within "x" data set explicitly from the first to the last row (row by row).
        
#####3. Appends subject indexes to main "x" data frames from corresponding "s" data frames.  
        I do similar assumption as in the previous item.  
        
#####4. Merges test and training data frames by rows.  
        As test and training sets were divided just by separating subjects into two groups (and so contain the same set of variables) we may join them by appending one by another by rows.
        
#####5. Substitutes variable names by appropriate labels from "features" data frame.  
        I use the link between index and label of each variable given by "features" data frame to substitute each index name by corresponding label.
        562 and 563 columns are Activity and Subjects respectively so they are excluded from the procedure.
        
#####6. Substitutes activity indexes by appropriate activity names from "activity_labels" data frame.  
        I use similar approach as in the previous item except that in this case I substitute column values and not names.
        
#####7. Extracts only the measurements on the mean and standard deviation for each measurement.  
        dplyr's "select" statement produces an error caused by data set having doubled variable names.

#####8. Creates a second tidy data set with the average of each variable for each activity and each subject.
        
#####9. Exports resulting data set into a file "dataset.txt".

        