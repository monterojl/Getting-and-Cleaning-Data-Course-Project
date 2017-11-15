# Purpose of the project
The purpose of this project is to demonstrate the ability to collect, work with, and clean a data set. 
The goal is to prepare tidy data that can be used for later analysis (see data source below)

# Data source
The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the project:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

# R Script: "run_analysis.R"
The main task of the project is to create one R script called run_analysis.R that does the following.

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Script variables
Input data:
* "x_train" and "x_test" include features data for each activity performed
* "features" includes the names for the features data columns
* "y_train" and "y_test" include the related activity name performed
* "activityLabels" includes the names for each activity ID
* "subject_train" and "subject_test" include the subject ID that performed each activity

Input data consolidated:
* "train_data", "test_data" consolidate train and test data in one table each
* "full_data" will consolidate those table into a single one data set.

Extract of specific measurements
* "extracted_data" stores only the measurements on the mean and standard deviation for each activity.
* "extracted_with_names_data" is equal to "extracted_data" but with descriptive variable names.

Tidy data:
* "tidy data" is the tidy data set with the average of each variable for each activity and each subject
* "tidy_ordered_data" is the tidy data set additionally ordered by activity and subject

## Transformations
In order to perform the actions requested in the script, the following steps have been performed:

0. Download data source
* Using the given url .zip file is downloaded and unzipped in the working directory
1. Load different input files into R tables
* Using the read.table command, the different inout files are read and stored in variables (see variables section).
* Taking advantage of the features input file and the information provided, proper names are assigned to the columns of the tables.
* Using cbind, features data, feature name and subject ID that perform it is consolidated into one single table.
2. Extracts only the measurements on the mean and standard deviation
* Using grepl, only specific columns are gathered: activityID, subjectID and all those including the word "mean" or "std"
3. Replace activityID by the more descriptive activityName
* Matching the consolidated table with the activityLabels one, names of the activities are gathered using merge command.
4. Appropriately labels the data set with descriptive variable names
* Using gsub, short names are replaced by long descriptive names.
5. Creation of independent tidy data set with the average of each variable for each activity and each subject.
* Using aggregate function calculates mean for each activity and subject
* Using order command within subsetting, the data set is ordered by the 2 main variables activity and subject
* Write final tidy data set to a text file

