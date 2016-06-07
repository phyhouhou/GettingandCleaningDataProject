#The data linked to from the course website represent data collected from the
#accelerometers from the Samsung Galaxy S smartphone. A full description is 
#available at the site where the data was obtained:
#http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
#Here are the data for the project:
#https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
#You should create one R script called run_analysis.R that does the following.
#1. Merges the training and the test sets to create one data set.
#2. Extracts only the measurements on the mean and standard deviation
#   for each measurement.
#3. Uses descriptive activity names to name the activities in the data set
#4. Appropriately labels the data set with descriptive variable names.
#5. From the data set in step 4, creates a second, independent tidy data set with
#   the average of each variable for each activity and each subject.

#Step 1
#Get the data and merge the training and the test sets to create one data set

#1. Download the data into the data folder in the working directory

#setwd("~/couresera/ProgrammingAssignment4/Projectgetandcleandata")
if(!file.exists('./data')){dir.create('./data')}
fileUrl<-'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
download.file(fileUrl,destfile='./data/rawdata.zip',method='curl')

#2. Unzip the file and list the files in the raw data set

unzip('./data/rawdata.zip',exdir='./data')
list.files('./data')
list.files('./data/UCI HAR Dataset/',recursive =T)

#3. Read the relevant files that are used for the purpose of this project

#read the training set
library(data.table)
X_train<-fread('./data/UCI HAR Dataset/train/X_train.txt',header=F)
Y_train<-read.table('./data/UCI HAR Dataset/train/Y_train.txt',header=F)
subject_train<-read.table('./data/UCI HAR Dataset/train/subject_train.txt',header=F)

#read the test set
X_test<-fread('./data/UCI HAR Dataset/test/X_test.txt',header=F)
Y_test<-read.table('./data/UCI HAR Dataset/test/Y_test.txt',header=F)
subject_test<-read.table('./data/UCI HAR Dataset/test/subject_test.txt',header=F)


#Combine the training and the test data by rows seperately 
X<-rbind(X_train,X_test)
Y<-rbind(Y_train,Y_test)
subject<-rbind(subject_train,subject_test)

#name the variables
names(subject)<-'subject'
names(Y)<-'activity'
names(X)<-as.character(read.table('./data/UCI HAR Dataset/features.txt')$V2)

#Merge all the variables to form a whole data set
dataset<-cbind(subject,Y,X)

#Step 2
#Extract only the measurements on the mean and standard deviation for each measurement

indexselect<-c(1,2,
               grep('mean\\(\\)|std\\(\\)',names(dataset)))

dataset<-as.data.frame(dataset[,indexselect])
#Step3
#Use descriptive activity names to name the activities in the data set

#read the labels
labeldata<-read.table('./data/UCI HAR Dataset/activity_labels.txt',header=F)

#rename the labels
dataset$activity<-factor(as.factor(dataset$activity),labels=as.character(labeldata$V2))


#Step4
#Appropriately labels the data set, enssentially, the features with descriptive
#variable names.

names(dataset)<-tolower(names(dataset))
names(dataset)<-gsub('-','_',names(dataset))
names(dataset)<-gsub('^t','time_',names(dataset))
names(dataset)<-gsub('^f','frequency_',names(dataset))
names(dataset)<-gsub('acc','_accelerometer',names(dataset))
names(dataset)<-gsub('gyro','_gyroscope',names(dataset))
names(dataset)<-gsub('jerk','_jerk',names(dataset))
names(dataset)<-gsub('mag','_magnititude',names(dataset))
names(dataset)<-gsub('bodybody','body',names(dataset))

#Step5
#From the data set in step 4, creates a second, independent tidy data set with
#the average of each variable for each activity and each subject.

library(reshape2)
meltdata<-melt(dataset,id=c('subject','activity'),measur.vars=names(dataset)[-(1:2)])
averages<- dcast(meltdata, subject + activity ~ variable, mean)

#Export the tidy data 
write.table(averages, file = "./tidy_data.txt", row.name = FALSE)

