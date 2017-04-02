run_analysis <- function (){
        
        library(dplyr)
        
        ## 1. Read files into data frames
        
        s_train <- read.table(".\\UCI HAR Dataset\\train\\subject_train.txt")
        x_train <- read.table(".\\UCI HAR Dataset\\train\\X_train.txt")
        y_train <- read.table(".\\UCI HAR Dataset\\train\\y_train.txt")
        
        s_test <- read.table(".\\UCI HAR Dataset\\test\\subject_test.txt")
        x_test <- read.table(".\\UCI HAR Dataset\\test\\X_test.txt")
        y_test <- read.table(".\\UCI HAR Dataset\\test\\y_test.txt")
        
        activity_labels <- read.table(".\\UCI HAR Dataset\\activity_labels.txt")
        features <- read.table(".\\UCI HAR Dataset\\features.txt")
        
        ## 2. Append activity indexes to main "x" data frames from 
        ## corresponding "y" data frames
         
        x_test$Activity <- y_test[[1]]
        x_train$Activity <- y_train[[1]]
        
        ## 3. Append subject indexes to main "x" data frames from 
        ## corresponding "s" data frames
        
        x_test$Subject <- s_test[[1]]
        x_train$Subject <- s_train[[1]]
        
        ## 4. Merge test and training data frames by rows
        
        x <- rbind(x_train, x_test)
        
        ## 5. Substitute variable names by appropriate labels from
        ## "features" data frame
        
        names(x)[-(562:563)] <- lapply(names(x)[-(562:563)], function (i) 
                i <- as.character(features[features$V1 == sub("V", "", i), 2]))
         
        ## 6. Substitute activity indexes by appropriate activity names from
        ## "activity_labels" data frame
        
        x$Activity <- sapply(x$Activity, function (i) 
                i <- activity_labels[activity_labels$V1 == i, 2])
        
        ## 7. Extract only the measurements on the mean and standard deviation
        ## for each measurement
         
        x_selected <- x[, regexpr("(mean\\(\\)|std\\(\\)|Activity|Subject)", names(x))!=-1]

        ## 8. Create a second tidy data set with the average of 
        ## each variable for each activity and each subject 
        
        x_grouped <- x_selected %>% group_by(Subject, Activity) %>% summarize_all(mean)
         
        ## 9. Export resulting data set into a file "dataset.txt"
        
        write.table(x_grouped, "dataset.txt", row.names = FALSE)
         
}
