# TidyData
The repository for the Getting and Cleaning Data Course Project

The run_analysis.R script analyses the 'UCI HAR Dataset' available by the URL https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip and generates the tidy dataset contained 180 obs. of 563 variables as result. This resulted dataset will be saved as the tidy_data.txt file in the script working directory.

## Function has two arguments

*directory* is the character vector of length 1. This argument specifies the script working directory where all the analysis will be performed and the resulted tidy_data.txt file will be created here as well.
  
*data.exists* is the logical argument. data.exists = TRUE means you already have the downloaded and unzipped dataset exactly in the folder named 'UCI HAR Dataset' in the script working directory. In that case script will not download and unzip any data. If you have no data prepared, just set the data.existed to FALSE. In that case script download (almost 63Mb) and unzip data itself.

## Dependencies

Script uses some functions from the 'reshape2' R package, which will be installed automatically if library("reshape2", logical.return=TRUE) returns FALSE.

## Algorithm

After downloading and unzipping the initial dataset scripth makes the following steps:
* Merges the training and the test sets to create one data set.
* Extracts only the measurements on the mean and standard deviation for each measurement. 
* Uses descriptive activity names to name the activities in the data set
* Appropriately labels the data set with descriptive variable names. 
* From the data set in previous step, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Result

The resulted tidy dataset is saved as the tidy_data.txt file in the script working directory by the write.table function.

## Time

Please be note that script may requre up to 1 minute to perform result because of the huge initial dataset size.
