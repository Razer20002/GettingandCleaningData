# Load require packages
library(dplyr)
library(reshape2)
##Training data##
#Activities label merge and rename
Act_lab <- read.table("./UCI HAR Dataset/activity_labels.txt", header=FALSE)
Train_labID <- read.table("./UCI HAR Dataset/train/Y_train.txt", header=FALSE)
Train_lab <- merge(Train_labID, Act_lab, by.x="V1", by.y ="V1", sort=FALSE)
Train_lab <- select(Train_lab, V2)
Train_lab <- rename(Train_lab, Exercise = V2)

#Obtain data and rename columns
Train_subject <- read.table("./UCI HAR Dataset/train/subject_train.txt", header=FALSE)
Train_subject <- rename(Train_subject, Subject = V1)
Train_data <- read.table("./UCI HAR Dataset/train/X_train.txt", header=FALSE)
features <- read.table("./UCI HAR Dataset/features.txt", sep="\t", header=FALSE)
feature_names <- features[,1]
colnames(Train_data) <- feature_names

#Combine to have 1 data set
Train_set <- cbind(Train_lab,Train_subject)
Train_set <- cbind(Train_set,Train_data)

##Test data##
#Activities label merge and rename
Test_labID <- read.table("./UCI HAR Dataset/test/Y_test.txt", header=FALSE)
Test_lab <- merge(Test_labID, Act_lab, by.x="V1", by.y ="V1", sort=FALSE)
Test_lab <- select(Test_lab, V2)
Test_lab <- rename(Test_lab, Exercise = V2)

#Obtain data and rename columns
Test_subject <- read.table("./UCI HAR Dataset/test/subject_test.txt", header=FALSE)
Test_subject <- rename(Test_subject, Subject = V1)
Test_data <- read.table("./UCI HAR Dataset/test/X_test.txt", header=FALSE)
colnames(Test_data) <- feature_names

#Combine to have 1 data set
Test_set <- cbind(Test_lab,Test_subject)
Test_set <- cbind(Test_set,Test_data)

#Combine train and test data sets
All_data <- rbind(Train_set, Test_set)

#Select the mean and standard deviation data
All_data2 <- select(All_data, Exercise, Subject, contains("mean()"), contains("std()"))

#Calculate mean of each variable by Exercise and Subject
All_data3 <- melt(All_data2, id=c("Exercise","Subject"))
Data_averages <- dcast(All_data3,Exercise + Subject ~ variable,mean)

