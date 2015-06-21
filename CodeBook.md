## CodeBook.md

This file describes the operation of the run_analysis.R script and the variable names used in the analysis.

### run_analysis.R

This script does the following analysis on the data in the Project directory 
1. Merges the training and the test sets to create one data set. 
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set 
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable 
for each activity and each subject.

Read the train and test x and Y data files, the features and subject description files Combine the train 
and test data into one data frame (df) using the row bind operation. The column names are in the features.txt 
file in column form, they need to be transposed to a row so they can be applied as column names for the 
data frame df. This is done using transpose ("t") function in r and subsetting the data set to extract the names. 
This data frame has all the 561 columns and column names but does not have the subject or activity columns

Next the Subject and Activity columns are added to this data frame, the Activity columns have numbers which 
represent activities, these are replaced with labels as described below
* 1. WALKING
* 2. WALKING_UPSTAIRS
* 3. WALKING_DOWNSTAIRS
* 4. SITTING
* 5. STANDING
* 6. LAYING

The Subject and Activity columns are now combined with the previous data frame using cbind and labels added to 
these two columns. You now have a data frame which has a dim of 10299x563 and satisfies objectives 1,3 and 4 
of the project.

Extract only the mean and standard deviation measurement columns from the data set that was created above. 
Search for column names that have mean or standard deviation (std) in the column names. There are also Freqmean 
and Freqstd column names that get selected but they are not real measurements of means and std so omit them. 
Remove () from column names and make the names unique so that they are syntactically valid names. Assign the names 
to a vector cind, which is used as an index into the data frame mydata which then results in a data frame of mean 
and std columns only called ms_data. This meets objective 2 of the project.

Create a new data frame with with the Subject, Activity and the mean and std columns called tidy_data. Pipe this 
data to he group_by function and group this data frame by Subject and Activity and then pipe it to the 
summarise_each function to find the mean of every column for every subject for every activity. Next write this 
new data frame to a text file called tidydata.txt The result is a tidy dataset of dim 180x68 which meets 
objective 5 of the project

#### Description of Variables

* 1. Subject - Subject identifier, integer values between 1 to 30
* 2. Activity - Activity identifier can be WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING
* 3. tBodyAcc.mean...X - Mean of tBodyAcc in X direction, values between [-1,1] 
* 4. tBodyAcc.mean...Y - Mean of tBodyAcc in Y direction, values between [-1,1]
* 5. tBodyAcc.mean...Z - Mean of tBodyAcc in Z direction, values between [-1,1]
* 6. tBodyAcc.std...X - Standard Deviation of tBodyAcc in X direction, values between [-1,1]
* 7. tBodyAcc.std...Y - Standard Deviation of tBodyAcc in Y direction, values between [-1,1]
* 8. tBodyAcc.std...Z - Standard Deviation of tBodyAcc in Z direction, values between [-1,1]
* 9. tGravityAcc.mean...X - Mean of tGravityAcc in X direction, values between [-1,1]
* 10. tGravityAcc.mean...Y - Mean of tGravityAcc in Y direction, values between [-1,1]
* 11. tGravityAcc.mean...Z - Mean of tGravityAcc in Z direction, values between [-1,1]
* 12. tGravityAcc.std...X - Standard Deviation of tGravityAcc in X direction, values between [-1,1]
* 13. tGravityAcc.std...Y - Standard Deviation of tGravityAcc in Y direction, values between [-1,1]
* 14. tGravityAcc.std...Z - Standard Deviation of tGravityAcc in Z direction, values between [-1,1]
* 15. tBodyAccJerk.mean...X - Mean of tBodyAccJerk in X direction, values between [-1,1]
* 16. tBodyAccJerk.mean...Y - Mean of tBodyAccJerk in Y direction, values between [-1,1]
* 17. tBodyAccJerk.mean...Z - Mean of tBodyAccJerk in Z direction, values between [-1,1]
* 18. tBodyAccJerk.std...X - Standard Deviation of tBodyAccJerk in X direction, values between [-1,1]
* 19. tBodyAccJerk.std...Y - Standard Deviation of tBodyAccJerk in Y direction, values between [-1,1]
* 20. tBodyAccJerk.std...Z - Standard Deviation of tBodyAccJerk in Z direction, values between [-1,1]
* 21. tBodyGyro.mean...X - Mean of tBodyGyro in X direction, values between [-1,1]
* 22. tBodyGyro.mean...Y - Mean of tBodyGyro in Y direction, values between [-1,1]
* 23. tBodyGyro.mean...Z - Mean of tBodyGyro in Z direction, values between [-1,1]
* 24. tBodyGyro.std...X - Standard Deviation of tBodyGyro in X direction, values between [-1,1]
* 25. tBodyGyro.std...Y - Standard Deviation of tBodyGyro in Y direction, values between [-1,1]
* 26. tBodyGyro.std...Z - Standard Deviation of tBodyGyro in Z direction, values between [-1,1]
* 27. tBodyGyroJerk.mean...X - Mean of tBodyGyroJerk in X direction, values between [-1,1]
* 28. tBodyGyroJerk.mean...Y - Mean of tBodyGyroJerk in Y direction, values between [-1,1]
* 29. tBodyGyroJerk.mean...Z - Mean of tBodyGyroJerk in Z direction, values between [-1,1]
* 30. tBodyGyroJerk.std...X - Standard Deviation of tBodyGyroJerk in X direction, values between [-1,1]
* 31. tBodyGyroJerk.std...Y - Standard Deviation of tBodyGyroJerk in Y direction, values between [-1,1]
* 32. tBodyGyroJerk.std...Z - Standard Deviation of tBodyGyroJerk in Z direction, values between [-1,1]
* 33. tBodyAccMag.mean.. - Mean of tBodyAcc, values between [-1,1]
* 34. tBodyAccMag.std.. - Standard Deviation of tBodyAcc, values between [-1,1]
* 35. tGravityAccMag.mean.. - Mean of tGravityAccMag, values between [-1,1]
* 36. tGravityAccMag.std.. - Standard Deviation of tGravityAccMag, values between [-1,1]
* 37. tBodyAccJerkMag.mean.. - Mean of tBodyAccJerkMag, values between [-1,1]
* 38. tBodyAccJerkMag.std.. - Standard Deviation of tBodyAccJerkMag, values between [-1,1]
* 39. tBodyGyroMag.mean.. - Mean of tBodyGyroMag, values between [-1,1]
* 40. tBodyGyroMag.std.. - Standard Deviation of tBodyGyroMag, values between [-1,1]
* 41. tBodyGyroJerkMag.mean.. - Mean of tBodyGyroJerkMag, values between [-1,1]
* 42. tBodyGyroJerkMag.std.. - Standard Deviation of tBodyGyroJerkMag, values between [-1,1]
* 43. fBodyAcc.mean...X - Mean of fBodyAcc in X direction, values between [-1,1]
* 44. fBodyAcc.mean...Y - Mean of fBodyAcc in Y direction, values between [-1,1]
* 45. fBodyAcc.mean...Z - Mean of fBodyAcc in Z direction, values between [-1,1]
* 46. fBodyAcc.std...X - Standard Deviation of fBodyAcc in X direction, values between [-1,1]
* 47. BodyAcc.std...Y - Standard Deviation of fBodyAcc in Y direction, values between [-1,1]
* 48. fBodyAcc.std...Z - Standard Deviation of fBodyAcc in Z direction, values between [-1,1]
* 49. fBodyAccJerk.mean...X - Mean of fBodyAccJerk in X direction, values between [-1,1]
* 50. fBodyAccJerk.mean...Y - Mean of fBodyAccJerk in Y direction, values between [-1,1]
* 51. fBodyAccJerk.mean...Z - Mean of fBodyAccJerk in Z direction, values between [-1,1]
* 52. BodyAccJerk.std...X - Standard Deviation of fBodyAccJerk in X direction, values between [-1,1]
* 53. fBodyAccJerk.std...Y - Standard Deviation of fBodyAccJerk in Y direction, values between [-1,1]
* 54. fBodyAccJerk.std...Z - Standard Deviation of fBodyAccJerk in Z direction, values between [-1,1]
* 55. fBodyGyro.mean...X - Mean of fBodyGyro in X direction, values between [-1,1]
* 56. fBodyGyro.mean...Y - Mean of fBodyGyro in Y direction, values between [-1,1]
* 57. fBodyGyro.mean...Z - Mean of fBodyGyro in Z direction, values between [-1,1]
* 58. fBodyGyro.std...X - Standard Deviation of fBodyGyro in X direction, values between [-1,1]
* 59. fBodyGyro.std...Y - Standard Deviation of fBodyGyro in Y direction, values between [-1,1]
* 60. fBodyGyro.std...Z - Standard Deviation of fBodyGyro in Z direction, values between [-1,1]
* 61. fBodyAccMag.mean.. - Mean of fBodyAccMag, values between [-1,1]
* 62. fBodyAccMag.std.. - Standard Deviation of fBodyAccMag, values between [-1,1]
* 63. fBodyBodyAccJerkMag.mean.. - Mean of fBodyAccJerkMag, values between [-1,1] 
* 64. fBodyBodyAccJerkMag.std.. - Standard Deviation of fBodyAccJerkMag, values between [-1,1]
* 65. fBodyBodyGyroMag.mean.. - Mean of fBodyGyroMag, values between [-1,1]
* 66. fBodyBodyGyroMag.std.. - Standard Deviation of fBodyGyroMag, values between [-1,1]
* 67. fBodyBodyGyroJerkMag.mean.. - Mean of fBodyGyroJerkMag, values between [-1,1] 
* 68. fBodyBodyGyroJerkMag.std.. - Standard Deviation of fBodyGyroJerkMag, values between [-1,1]