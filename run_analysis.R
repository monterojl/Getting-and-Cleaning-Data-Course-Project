# run_analysis.R
# This function is a deliverable of the Getting and Cleaning Data Course Project in Coursera
# Merges the training and the test sets to create one data set.
# Extracts only the measurements on the mean and standard deviation for each measurement.
# Uses descriptive activity names to name the activities in the data set
# Appropriately labels the data set with descriptive variable names.
# From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# STEP 0:Downloading data file from url
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="data.zip")

# Unzip data file directory
unzip(zipfile="./data.zip")

# STEP 1: Merges the training and the test sets to create one data set.
# Data is split across different files, for training and test:
# "x_train" and "x_test" include features data for each activity performed
# "features" includes the names for the features data columns
# "y_train" and "y_test" include the related activity ID performed
# activity labels include thenames for each activity ID
# "subject_train" and "subject_test" include the subject ID that performed each activity

# Reading the different source files
x_train<-read.table("UCI HAR Dataset/train/X_train.txt")
y_train<-read.table("UCI HAR Dataset/train/Y_train.txt")
x_test<-read.table("UCI HAR Dataset/test/X_test.txt")
y_test<-read.table("UCI HAR Dataset/test/Y_test.txt")
subject_train<-read.table("UCI HAR Dataset/train/subject_train.txt")
subject_test<-read.table("UCI HAR Dataset/test/subject_test.txt")
features<-read.table("UCI HAR Dataset/features.txt")
activityLabels<-read.table("UCI HAR Dataset/activity_labels.txt")

# Assigning proper names
names(features)<-c("featureID", "featureName")
names(x_train)<-features[,"featureName"]
names(y_train)<-"activityID"
names(x_test)<-features[,"featureName"]
names(y_test)<-"activityID"
names(subject_train)<-"subjectID"
names(subject_test)<-"subjectID"
names(activityLabels)<-c("activityID", "activityName")

# Creating only one data set, first consolidating columns and then merging train and test sets
train_data<-cbind(subject_train, y_train, x_train) # Consolidates train data in one table
test_data<-cbind(subject_test, y_test, x_test)     # Consolidates test data in one table
full_data<-rbind(train_data, test_data)            # Consolidates both train and test data sets into only one

# STEP 2: Extracts only the measurements on the mean and standard deviation for each measurement.
columns<-names(full_data)                          # Get all column names
extractColumns<-(  grepl("subjectID" , columns)  | # Create a boolean vector with the columns to extract
                   grepl("activityID" , columns) | 
                   grepl("mean" , columns)       | 
                   grepl("std" , columns) 
                )
extracted_data<-full_data[extractColumns]            # Use the boolean vector created to extract the columns

# STEP 3: Uses descriptive activity names to name the activities in the data set
# Merging extracted data set and activityLabels table using activityID
extracted_with_names_data<-merge(extracted_data, activityLabels, by = "activityID")
# removing former activityID column
extracted_with_names_data<-subset(extracted_with_names_data, select = -activityID)

# STEP 4: Appropriately labels the data set with descriptive variable names.
# Replacing short strings by long meaningful words
names(extracted_with_names_data)<-gsub("tBody", "timeBody", names(extracted_with_names_data))
names(extracted_with_names_data)<-gsub("fBody", "FFTBody", names(extracted_with_names_data))
names(extracted_with_names_data)<-gsub("Acc", "Accelerator", names(extracted_with_names_data))
names(extracted_with_names_data)<-gsub("Gyro", "Gyroscope", names(extracted_with_names_data))
names(extracted_with_names_data)<-gsub("Mag", "Magnitude", names(extracted_with_names_data))

# STEP 5: From the data set in step 4, creates a second, independent tidy data set with the average 
# of each variable for each activity and each subject.

# Calculates mean for each activity and subject ID
tidy_data<-aggregate(. ~ activityName + subjectID, extracted_with_names_data, mean)

# Finally ordered by both IDs
tidy_ordered_data<-tidy_data[order(tidy_data$activityName, tidy_data$subjectID),]

# Writing tidy_ordered_data as final output of the exercise
write.table(tidy_ordered_data, "tidy_ordered_data.txt", row.name=FALSE)