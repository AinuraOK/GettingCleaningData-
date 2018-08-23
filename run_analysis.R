
#script (please refer to Codebok.md for the detailed description)

#setwd("~/Desktop/Data science lessons/Getting and cleaning data ")
library(dplyr)
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./data/Dataset.zip")

unzip(zipfile="./data/Dataset.zip",exdir="./data")

# 1. 
#a.
x_train <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./data/UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")
#b.
x_test <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./data/UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")
#c.
features <- read.table('./data/UCI HAR Dataset/features.txt')
#d.
activityLabels = read.table('./data/UCI HAR Dataset/activity_labels.txt')

#1.1.
colnames(x_train) <- features[,2] 
colnames(y_train) <-"activity"
colnames(subject_train) <- "subject"

colnames(x_test) <- features[,2] 
colnames(y_test) <- "activity"
colnames(subject_test) <- "subject"

colnames(activityLabels) <- c('activity','activityType')
#1.2.
data_train <- cbind(y_train, subject_train, x_train)
data_test <- cbind(y_test, subject_test, x_test)
Onedataset <- rbind(data_train, data_test)

#2.
colNames <- colnames(Onedataset)
mean_and_std <- (grepl("activity" , colNames) | 
                   grepl("subject" , colNames) | 
                   grepl("mean.." , colNames) | 
                   grepl("std.." , colNames) 
)

MeanAndStd <- Onedataset[ , mean_and_std == TRUE]

#3.

ActivityNames <- merge(MeanAndStd, activityLabels,
                              by='activity',
                              all.x=TRUE)

#4.
names(ActivityNames)<-gsub("()", "", names(ActivityNames), fixed=TRUE)
names(ActivityNames)<-gsub("std", "SD", names(ActivityNames))
names(ActivityNames)<-gsub("mean", "MEAN", names(ActivityNames))
names(ActivityNames)<-gsub("^t", "time", names(ActivityNames))
names(ActivityNames)<-gsub("^f", "frequency", names(ActivityNames))
names(ActivityNames)<-gsub("Acc", "Accelerometer", names(ActivityNames))
names(ActivityNames)<-gsub("Gyro", "Gyroscope", names(ActivityNames))
names(ActivityNames)<-gsub("Mag", "Magnitude", names(ActivityNames))
names(ActivityNames)<-gsub("BodyBody", "Body", names(ActivityNames))

#5.
tidydata <- aggregate(. ~subject + activity, ActivityNames, mean)
tidydata <- tidydata[order(tidydata$subject, tidydata$activity),]
write.table(tidydata, "tidydata.txt", row.name=FALSE)




