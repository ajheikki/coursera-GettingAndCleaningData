# Coursera, Getting and Cleaning Data project
#
# This script performs the following steps on the unzipped UCI HAR Dataset downloaded from
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
#
# 1. Merge the training and the test sets to create one data set.
# 2. Extract only the measurements on the mean and standard deviation for each measurement.
# 3. Use descriptive activity names to name the activities in the data set
# 4. Appropriately label the data set with descriptive activity names.
# 5. Creates a second, independent tidy data set with the average of each variable for 
#    each activity and each subject.
##########################################################################################################

# Clean the workspace
rm(list=ls())

# Set the working directory
# Modify to point to the folder where the unzipped data set (UCI HAR Dataset folder) 
# is located as a subfolder
setwd("C:/Data/R working directory/Coursera GetandCleanData")

###################
# Step 1. Merge the training and the test sets to create one data set.

# Read in the data from source files
features <- read.table('./UCI HAR Dataset/features.txt', header=FALSE)
activityLabel <- read.table('./UCI HAR Dataset/activity_labels.txt',header=FALSE)

# ...the train data
subjectTrain <- read.table('./UCI HAR Dataset/train/subject_train.txt',header=FALSE) 
xTrain <- read.table('./UCI HAR Dataset/train/x_train.txt',header=FALSE)      
yTrain <- read.table('./UCI HAR Dataset/train/y_train.txt',header=FALSE)

# ...the test data
subjectTest <- read.table('./UCI HAR Dataset/test/subject_test.txt',header=FALSE)
xTest <- read.table('./UCI HAR Dataset/test/x_test.txt',header=FALSE)
yTest <- read.table('./UCI HAR Dataset/test/y_test.txt',header=FALSE)


# Assign column names
colnames(activityLabel) = c('activityId','activityLabel')
colnames(subjectTrain) = "subjectId"
colnames(xTrain) = features[,2]
colnames(yTrain) = "activityId"
colnames(subjectTest) = "subjectId"
colnames(xTest) = features[,2]
colnames(yTest) = "activityId"

# Merge the data
mergedData = rbind(cbind(yTrain, subjectTrain, xTrain), 
                   cbind(yTest, subjectTest, xTest))

# Create a vector for the column names from the mergedData
# This will next be used to select the desired mean and standard deviation columns
colNames = colnames(mergedData)

###################
# Step 2. Extract only the measurements on the mean and standard deviation for each measurement.

# Create a vector containing TRUE for the IDs, mean() and std() columns and FALSE for others
# Excludes also meanFreq measurements.
logicalVector = (grepl("-mean|std", colNames) & !grepl("-meanFreq", colNames))

# Include first two columns: activityID and subjectID
logicalVector[c(1,2)] = TRUE

# Subset mergedData to keep only desired columns
mergedData = mergedData[logicalVector]

###################
# Step 3. Use descriptive activity names to name the activities in the data set

# Merge the mergedData and activityType tables to include descriptive activity names
mergedData = merge(mergedData, activityLabel, by='activityId', all.x=TRUE)

# Get the new column names
colNames = colnames(mergedData)

###################
# Step 4. Appropriately label the data set with descriptive activity names.

# Clean the variable names
for (i in 1:length(colNames))
{
  colNames[i] = gsub("\\()","",colNames[i])
  colNames[i] = gsub("-std$","StdDev",colNames[i])
  colNames[i] = gsub("-std-","StdDev-",colNames[i])
  colNames[i] = gsub("-mean","Mean",colNames[i])
  colNames[i] = gsub("^(t)","Time.",colNames[i])
  colNames[i] = gsub("^(f)","FFT.",colNames[i])
  colNames[i] = gsub("Mag","Magnitude",colNames[i])
}

# Put the new column names to the mergedData set
colnames(mergedData) <- colNames

###################
# Step 5. Create a second, independent tidy data set with the average of each variable 
# for each activity and each subject.

# Create a new table, mergedData2 without the activityLabel column
mergedData2 = mergedData[, names(mergedData) != 'activityLabel']

# Summarize the new mergedData2 as required by taking mean value of each variable 
# for each activity and each subject.
tidyData = aggregate(mergedData2[,names(mergedData2) != c('activityId','subjectId')], 
                     by=list(activityId=mergedData2$activityId, 
                             subjectId = mergedData2$subjectId), mean)

# Merge tidyData with activityLabel to once again include descriptive activity names
# put activity label into the 2nd column
tidyData = merge(tidyData, activityLabel, by='activityId', all.x=TRUE)[, c(1,69, 2:68)]

# sort by activityID, subjectID, ascending. Remove the rownames
tidyData = tidyData[order(tidyData[1], tidyData[3]), ]
rownames(tidyData) <- NULL

# Export the tidyData as required
write.table(tidyData, './tidyData.txt', row.names=FALSE, sep='\t')
# tidyData.txt is the processed output file required in the task
