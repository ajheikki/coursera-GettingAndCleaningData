## Coursera - Getting and Cleaning Data - Course Project

This is a repository for the course project for the Coursera Getting and Cleaning Data course.

# Used data
A description of the data used in this project can be found at: 
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Project source data can be obtained from here: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

# Task and implementation
run_analysis.R script implements the following given requirements:

    1. Merges the training and the test sets to create one data set.
    2. Extracts only the measurements on the mean and standard deviation for each measurement.
    3. Uses descriptive activity names to name the activities in the data set
    4. Appropriately labels the data set with descriptive activity names.
    5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# Steps to work on this course project

    - Download the source data and save UCI HAR Dataset folder into a folder.
    - Save run_analysis.R script in the parent folder of the UCI HAR Dataset
    - Open the run_analysis.R script and set the R working directory to the parent directory by modifying the setwd() command at the beginning of the script.
    - Run run_analysis.R. It generates a new file tidyData.txt in your working directory. This is the tidy data file required in the task.
