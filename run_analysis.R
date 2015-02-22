run_analysis <- function(directory = "./Documents/R/data", data.exists = TRUE) {   

## Function analyses the UCI HAR Dataset available by the URL
## https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
## and generates the tidy dataset contained 180 obs. of 563 variables
## This dataset will be saved as the tidy_data.txt file in the script working directory
  
## 'directory' is the character vector of length 1.
## This argument specifies the script working directory
## All the analysis will be performet in that directory
## and the resulted tidy_data.txt file will be created here as well
  
## 'data.exists' is the logical argument.
## 'data.exists = TRUE means you have the downloaded and unzipped dataset
## exactly in the folder named "UCI HAR Dataset" in the script working directory.
## In that case script will not download and unzip the data.
## If you have no data prepared, just set the data.existed to FALSE
## In that case script download (almost 63Mb) and unzip data itself
if (!data.exists) {
  
  ## Prepare folder
  if(!file.exists(directory)){dir.create(directory)}
  
  ## Data download
  if(!file.exists(paste(directory,"UCI HAR Dataset.zip",sep="/"))){
    fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(fileUrl,destfile=paste(directory,"UCI HAR Dataset.zip",sep="/"),method="curl")
  }
  
  ## Unzip the file
  unzip(paste(directory,"UCI HAR Dataset.zip",sep="/"), exdir=directory) 
}

## Reading the character vector of the features names
features <- read.table(paste(directory,"UCI HAR Dataset/features.txt",sep="/"), sep="", header=FALSE, row.names=1, as.is=TRUE)
feature_names <- make.names(as.vector(features[,1]))

## Reading the data
X_test <- read.table(paste(directory,"UCI HAR Dataset/test/X_test.txt",sep="/"), sep="", header=FALSE, col.names=feature_names)
X_train <- read.table(paste(directory,"UCI HAR Dataset/train/X_train.txt",sep="/"), sep="", header=FALSE, col.names=feature_names)

## Merging the training and the test sets to create one data set
X_total <- rbind(X_train,X_test)

## Preparing the numeric vector of the column indexes containing only the measurements on the mean and standard deviation
## Mean measurement column has the 'mean()' substring at the end of the name
## Standard deviation column has the 'std()' substring at the end of the name
## Please be note that the make.names() function which is used above to making 
## the syntactically valid names out of the 'features' character vector replaces
## all the brackets to the dots, so from the 'mean()' string we will get the 'mean..' one
mean_and_std <- sort(c(grep("mean..", feature_names), grep("std..", feature_names)))

## Extracting only the measurements on the mean and standard deviation for each measurement from the total dataset
X_subset <- subset(X_total, select=mean_and_std)

## Adding the labels to the data
y_test <- read.table(paste(directory,"UCI HAR Dataset/test/y_test.txt",sep="/"), header=FALSE, col.names="Activity")
y_train <- read.table(paste(directory,"UCI HAR Dataset/train/y_train.txt",sep="/"), header=FALSE, col.names="Activity")
y_total <- rbind(y_train,y_test)
X_subset <- cbind(X_subset,y_total)

## Read the activity labels
activity_labels <- read.table(paste(directory,"UCI HAR Dataset/activity_labels.txt",sep="/"), header=FALSE, sep=" ")
activity_labels[,2] <-as.character(activity_labels[,2])

## Making the 'Activity' variable to the descriptive activity names
for (i in 1:nrow(activity_labels)){
  X_subset$Activity[X_subset$Activity %in% i] = activity_labels[i,2]
}

## Adding the Subject to the data
subject_test <- read.table(paste(directory,"UCI HAR Dataset/test/subject_test.txt",sep="/"), header=FALSE, col.names="Subject")
subject_train <- read.table(paste(directory,"UCI HAR Dataset/train/subject_train.txt",sep="/"), header=FALSE, col.names="Subject")
subject_total <- rbind(subject_train,subject_test)
X_subset <- cbind(X_subset,subject_total)

## Calculating the average value for all variables for each unique Activity/Subject pair
## and store results in the tidy dataset

## install reshape2 package
if (!library("reshape2", logical.return=TRUE)){
  install.packages("reshape2")
}
library("reshape2")

## Melting the original dataset to the long format by Activity and Subject variables
melt_data <- melt(X_subset, id.vars=c("Activity","Subject"))

## Casting the molten data back to the data frame 
## and calculate the mean or all variables
## by each unique Activity/Subject pair
cast_data <- dcast(melt_data, Activity+Subject~..., fun.aggregate=mean)

## Store the tidy dataset in the tidy_data.txt file in the script working directory
write.table(cast_data, file=paste(directory,"tidy_data.txt",sep="/"), row.name=FALSE)
}