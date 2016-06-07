
#Getting and cleaning data project

This repo contains a R code named as 'run_analysis.R' and a CodeBook document for the 'Getting and cleaning data' project. The R code perform the five steps listed below to achieve the goal of the project. The CodeBook describes  the variables, the data, and any transformations or work that was performed to clean up the data. This README explains how all of the scripts work and how they are connected. The source data (https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) for the project linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:
(http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).


##The code does the following:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation
   for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with
   the average of each variable for each activity and each subject.

##How to run the 'run_analysis.R' code
The code require 'reshapre2' and 'data.table' packages. To run the code 'run_analysis.R', you need to import the code to your working directory. Then source the code in RStudio (`source('run_analysis.R')`). It will first download the data from the source link (https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) and save the data as 'rawdata.zip' in a newly created folder (if not exhisting) called 'data' ('./data/rawdata.zip'). Then it will unzip the files to yield a folder called 'UCI HAR Dataset' in the 'data' file ('./data/UCI HAR Dataset'). The final output of the code is a file called 'tidy_data.txt'('./tidy_data.txt') as required by the project.

















