# run_analysis.R
# This script does the following analysis on the data in the Project directory
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. From the data set in step 4, creates a second, independent tidy data set with the 
#    average of each variable for each activity and each subject.

# Read the train and test x and Y data files, the features and subject description files

        library(dplyr)
        setwd("C:/Users/srinivas/coursera/cleaning_data/Project")

        x_train <- read.table("UCI HAR Dataset/train/X_train.txt")
        x_test <- read.table("UCI HAR Dataset/test/X_test.txt")
        feat <- read.table("UCI HAR Dataset/features.txt")

        s_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
        s_test <- read.table("UCI HAR Dataset/test/subject_test.txt")

        y_train <- read.table("UCI HAR Dataset/train/Y_train.txt")
        y_test <- read.table("UCI HAR Dataset/test/Y_test.txt")

# Row bind the train and test data into one data frame (df), the column names are in the 
# features.txt file in column form, they need to be transposed to a row so they can be
# applied as column names for the data frame df
        
        df <- rbind(x_train,x_test)
        cnames <- t(feat)
        colnames(df) <- cnames[2,]

# Add the the subject and activity columns to the data frame

        y_subj <- rbind(s_train,s_test)
        y_act <- rbind(y_train,y_test)


# Replace activities column which has numbers with descriptive activity names

        y_act[ ,1] <- as.character(factor(y_act[ ,1], 
                                labels = c("WALKING","WALKING_UPSTAIRS","WALKING_DOWNSTAIRS",
                                        "SITTING","STANDING","LAYING")))

# mydata is a data frame that merges the training and test data sets into one data frame
# mydata has descriptive labels for the activities like WALKING,... etc. Name the Subject
# and Activity columns
#        
# All columns in the data set are now labelled with decriptive variable names from the 
# features.txt file and are in the data frame called mydata

        mydata <- cbind(df,y_subj,y_act)
        colnames(mydata)[562] <- "Subject"
        colnames(mydata)[563] <- "Activity"

# ---- End part 1,3 and 4 of project -------

# Extract only the mean and standard deviation measurement columns from the data set that was
# created above. Search for column names that have mean or standard deviation (std) in
# the column names. There are also Freqmean and Freqstd column names that get selected 
# with the first grep but they are not real measurements of means and std so omit them.

        msf_names <- grep(("mean|std"),colnames(mydata), value = TRUE)
        valid_names <- grep(("Freq"),msf_names, value = TRUE, invert = TRUE)

# Remove () from column names and make the names unique so that they are syntactically 
# valid names.

        colnames(mydata) <- make.names(colnames(mydata),unique=TRUE)
        mean_std_names <- make.names(valid_names,unique=TRUE)

# Assign the names to a vector cind, which is used as an index into the data frame mydata
# which then results in a data frame of mean and std columns only called ms_data

        cind <- c(mean_std_names)
        ms_data <- mydata[, cind]

#----- End part 2 of project -----------

# Create a new data set with with the Subject, Activity and the mean and std columns
# called tidy_data. Group this data frame by SUbject and Activity and then use the
# summarise_each function to find the mean of every column for every subject for 
# every activity. Next write this new data frame to a text file called tidydata.out
        
        tidy_data <- cbind(mydata[562],mydata[563],ms_data) %>%
        group_by(Subject, Activity) %>%
        summarise_each(funs(mean)) %>%
        write.table("tidydata.txt",sep="\t",row.names=FALSE)

#------ End part 5 of project -----------


