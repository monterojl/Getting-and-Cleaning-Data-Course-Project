# Getting-and-Cleaning-Data-Course-Project
This repository covers the deliverables of the Getting and Cleaning Data Course Project related to the corresponding Coursera training course.

## Data source
Here are the data for the project:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

A full description is available at the site where the data was obtained:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

## Files

* README.md: This file. A description of the repository and the files included on it.
* CodeBook.md: Describes the variables, the data, and any transformations or work that you performed to clean up the data
* run_analysis.R: R script that does the following.

  1. Merges the training and the test sets to create one data set.
  2. Extracts only the measurements on the mean and standard deviation for each measurement.
  3. Uses descriptive activity names to name the activities in the data set
  4. Appropriately labels the data set with descriptive variable names.
  5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

* tidy_ordered_data.txt: Tidy data set as described below in the exercise. Final output of the script run_analysis.R
