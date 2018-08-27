---
title: "README"
author: "AK"
date: "23 08 2018"
output: html_document
---

#This README explains how all of the scripts work and how they are connected.

I. Codebook.md describes the how to use all this, variables, the data, and any transformations or work performed to clean up the data.

II. run_analysis.R contains all the code to perform the analyses described in the 5 steps. 

Our dataset includes the following files:

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

The script does the following:

- Merges the training and the test sets to create one data set.
- Extracts only the measurements on the mean and standard deviation for each measurement.
- Uses descriptive activity names to name the activities in the data set
- Appropriately labels the data set with descriptive variable names.
- From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

III. The submitted data set is tidydata.txt.

