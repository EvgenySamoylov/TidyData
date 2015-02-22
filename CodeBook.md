# Code book of the tidy dataset

The resulting tidy dataset are processed from the initial 'UCI HAR Dataset' dataset (available here: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) with the following steps:

* Merges the X_train.txt and the X_test.txt sets in one dataset with 10299 observations of 561 variables.
* Extracts the only variables with the mean and standard deviation for each measurement. It means subsetting the only variables contained either 'mean()' or 'std()' at the end of the names (check the features_info.txt for more details). The resulted dataset has 10299 obs. of 79 variables after this step.
* Adds the labels to the data. Labels are stored in the y_train.txt and y_test.txt files. The resulted labels dataset has 10299 obs of 1 variable. Labels dataset is added to the X dataset as the last column, so the resulted X dataset has 80 variables after this step.
* Changes the numeric labels to the descriptive view. The descriptive names are from the activity_labels.txt file.
* Adds the Subjects to the data. Subjects are stored in the subject_train.txt and subject_test.txt files. The resulted Subjects dataset has 10299 obs of 1 variable. Subjects dataset is added to the X dataset as the last column, so the resulted X dataset has 81 variables after this step.
* Calculates the average value for all the dataset variables for each unique Activity/Subject pair. The melt() and dcast() functions from the *reshape2* package are used here. Please check the http://seananderson.ca/2013/10/19/reshape.html for more intuition.
* Saves the result in the tidy_data.txt file using the write.table() function.

## Tidy_data.txt features

Tidy_data.txt is the tidy data.frame which has 180 observations of 81 variables.

* *Column 1:* Activity label. Character. Possible values: "WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING".
* *Column 2:* Subject code. Integer from 1 to 30. An identifier of the subject who carried out the experiment.
* *Columns 3-81:* Average values of the Mean and Standard deviation variables for each unique Activity/Subject pair. Numeric.
