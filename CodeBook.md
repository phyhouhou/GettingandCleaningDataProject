
#Introduction

This code book describes the variables, the data, and any transformations or work
performed to clean up the data.  

##Data source 
The data for the project is given through the link (https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip). The data is collected from the accelerometers from the Samsung Galaxy S 
smartphone. A full description is available at the site where the data was obtained:
(http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

Unzipping the zipped data file gives the data folder named "UCI HAR Dataset". It contains the following files:

1. "README.txt": gives the detailed information on the dataset.
2. "activity_labels.txt": Links the class labels with their activity name.
3. "features_info.txt": Shows information on variables used on the feature vector.
4. "features.txt": List of all features.      
5. "test" folder contains 
  - "test/X_test.txt": test set.
  - "test/y_test.txt": test labels. 
  - "test/subject_test.txt":  Identifies the subject performing the activity for each      window sample. Its range is from 1 to 30.  
  - "test/Inertial Signal": data not used in this project. 
6. "train" folder contains
  - "train/X_train.txt": training set                           
  - "train/y_train.txt": training labels.
  - "train/subject_train.txt": Identifies the subject performing the activity for each      window sample. Its range is from 1 to 30.
  - "train/Inertial Signals": data not used in this project.

##Transformations performed to clean the data

1. Download the data (by `download.file`) into a data folder in the working directory      (by `setwd()`).
2. Unzip and list the files of the raw data set.
3. Select the relevant files used for the purpose of this project, namely,         
   - test/X_test.txt
   - test/y_test.txt
   - test/subject_test.txt
   - train/X_train.txt
   - train/y_train.txt
   - train/subject_train.txt
4. Combine by rows (`rbind()`), respectively, the test data 'X_test.txt' with  'X_train.txt' of the training data to get a variable called 'X', similarly, combine 'y_test.txt' with 'y_train.txt' to get 'Y', and combine 'subject_test.txt' with 'subject_train.txt' to get 'subject'. Name the variable 'subject' as 'subject', the 'Y' as 'activity' and the names of 'X' as the corresponding feature names. Then merge all the variables by columns (`cbind()`) to form a whole data set.

5. Extract only the measurements on the mean and standard deviation for each measurement by `grep()` function. Use descriptive activity names to name the activities in the data set, i.e., mapping the labels to its corresponding activity names.

6. Appropriately labels the data set, enssentially, the features with descriptive
variable names. In summary, we have made the following changes ( by functions `tolower()`, `gsub()`):
   - change all names into lower case
   - repalce '-' with '_'
   - replace '^t' with 'time_'
   - replace '^f' with 'frequency_'
   - replace 'acc' with'_accelerometer'
   - replace 'gyro' with '_gyroscope'
   - replace 'jerk' with '_jerk'
   - repalce 'mag' with '_magnititude'
   - replace 'bodybody' with 'body'

7. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. To achieve this goal, we first melt the data set through the `melt()` function by the ids 'subject' and 'activity'. Then use `dcast()` function to bring the data set to its usual form with resummarizing the data by taking averages of each variable for each 'subject' and each 'activity'. The tidy data is exported and saved as 'tidy_data.txt'.

8. We use the 'data.table' and 'reshape2' packages.
 
##Variables in the tidy_data
 
The tidy data records the averge measurements on the mean and standard deviation for each of the 30 subjects and each of the 6 perfoming 'activity'. Thus the tidy data has 180 rows (30 subjects*6 activities). It has 68 columns (variables) as given below:

 1. the 'subject' column ranges from 1 to 30. 
 2. the 'activity' column contains designed activities, namely, 'WALKING', 'WALKING_UPSTAIRS', 'WALKING_DOWNSTAIRS', 'SITTING', 'STANDING', and 'LAYING'.
 3. the rest 66 variables include averages of the mean (indicated in the names by "_mean()") and the standard deviation (indicated in the names by "_std()") of the features in source data.
   
The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals (time_accelerometer_xyz and time_gyroscope_xyz). 'time_body_accelerometer_xyz' and 'time_gravity_accelerometer_xyz' stand for body and gravity acceleration signals. 'time_body_accelerometer_jerk_xyz' and 'time_body_gyroscope_jerk_xyz' stand for Jerk signals. 'time_body_accelerometer_magnitude', 'time_gravity_accelerometer_magnitude', 'time_body_accelerometer_jerk_magnitude', 'time_body_gyroscope_magnitude', and 'time_body_gyroscope_jerk_magnitude' are the magnitude of these three-dimensional signals calculated using the Euclidean norm. 

As indicated by their names, the variables begin with 'time_' are time domain signals and that begin with 'frequency_' are after a Fast Fourier Transform (FFT) of its corresponding time domain signals. '_xyz' is used to denote 3-axial signals in the x, y and z directions.


