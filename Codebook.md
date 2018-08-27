---
title: "Codebook"
author: "AK"
date: "23 08 2018"
output: html_document
---

# This code book describes the variables, the data, and any transformations or work performed to clean up the data in the script run_analysis.R


#Data Set Information:
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities:
- WALKING, 
- WALKING_UPSTAIRS, 
- WALKING_DOWNSTAIRS, 
- SITTING, 
- STANDING, 
-LAYING, 
wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Downloaded data
#setwd("~/Desktop/Data science lessons/Getting and cleaning data ")

Our dataset includes the following files:

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

VARIABLES
The complete list of variables of each feature vector is available in 'features.txt'. These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag

Below you cand find how we renamed these variables to make it more descriptive (e.g, Acc to Accelerometer, Mag to Magnitude)

From these signals, in paricular, Mean value (mean()) and Standard deviation (std()) were estimated.

So the file with R code "run_analysis.R" perform 5 following steps (in accordance assigned task of course work):

1. Merging the training and the test sets to create one data set.
Work out how various parts (x files, y files, subjects, train vs test) flow together by reading:
a. Trainings tables
b. Testing tables
c. Feature vector
d. Activity labels
1.1.Fitting data together 

Setting column names for x_train and x_test from features.txt

colnames(x_train) <- features[,2] 
colnames(x_test) <- features[,2]

setting column name "activity" for WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING 

colnames(y_train) <-"activity"
colnames(y_test) <- "activity"

setting column name "subject" 
colnames(subject_train) <- "subject"
colnames(subject_test) <- "subject"

Now this enables to clip data in one data set:

1.2. Clipping data together using cbind and rbind into Onedataset
 
 dim(Onedataset)
[1] 10299   563

2.Extracting only the measurements on the mean and standard deviation for each measurement
#Applying grepl we  search for matches (activity, subject, mean and std) to argument pattern within each element of a character vecto to create subset "MeanAndStd" from Onedataset:
mean_and_std <- (grepl("activity" , colNames) | 
                   grepl("subject" , colNames) | 
                   grepl("mean.." , colNames) | 
                   grepl("std.." , colNames)

3.Using descriptive activity names to name the activities in the data set
We merged MeanAndStd and activityLabels into ActivityNames: 
ActivityNames <- merge(MeanAndStd, activityLabels,
                              by='activity',
                              all.x=TRUE)

4.Appropriately labeling the data set with descriptive variable names
Applying gsub() we replaced variable names as follows:
(): removed
std: SD (standard deviation)
mean: MEAN
^t: time
^f: frequency
Acc: Accelerometer
Gyro: Gyroscope
Mag: Magnitude
BodyBody: Body

So now we have descriptive variable names. Examples of updated variable names: 

"timeBodyAccelerometer-MEAN-X"
"timeBodyAccelerometer-MEAN-Y" 
"timeBodyAccelerometer-MEAN-Z"
"timeGravityAccelerometer-MEAN-X"
"timeBodyGyroscope-MEAN-X"

5.Creating a second, independent tidy data set with the average of each variable for each activity and each subject
#Made second data set called "tidydata" and wrote txt file "tidydata.txt"

tidydata <- aggregate(. ~subject + activity, ActivityNames, mean)
tidydata <- tidydata[order(tidydata$subject, tidydata$activity),]
write.table(tidydata, "tidydata.txt", row.name=FALSE)

Finally we have a tidy data set which can be used for further analytical exercises. 


