## Coursera - Getting and Cleaning Data
Course Project

# Data
A full description of the data used in this project can be found at: 
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Project source data can be obtained from here: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

# 
run_analysis.R script does the following:

    1. Merges the training and the test sets to create one data set.
    2. Extracts only the measurements on the mean and standard deviation for each measurement.
    3. Uses descriptive activity names to name the activities in the data set
    4. Appropriately labels the data set with descriptive activity names.
    5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Steps to work on this course project

    Download the data source and put into a folder on your local drive. You'll have a UCI HAR Dataset folder.
    Put run_analysis.R in the parent folder of UCI HAR Dataset, then set it as your working directory using setwd() function in RStudio.
    Run source("run_analysis.R"), then it will generate a new file tiny_data.txt in your working directory.

