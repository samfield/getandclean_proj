#this script requires data.table for merging, aggregating and subsetting
require("data.table")

#set the url for the file to be downloaded
fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
#download the file to the working directory and name to dataset.zip
download.file(fileurl,paste(getwd(),"dataset.zip",sep="/"))
# user is required to extract all files from the zip archive, destination must be workdir
#unzip(zipfile=paste(getwd(),"dataset.zip"),)

#directory UCI HAR Dataset...is assumed to exist 
#string variable created for directory path of test and train
test_dir <- paste(getwd(),"/UCI HAR Dataset/test",sep ="")
train_dir <- paste(getwd(),"/UCI HAR Dataset/train",sep ="")
#create a variable that lists all files int test directory
test_files <- list.files(test_dir)
#update variable to include only datasets that begin with "X_test"
test_file <- test_files[grepl("^X_test", test_files)]
#create a variable that lists all files int train directory
train_files <- list.files(train_dir)
#update variable to include only datasets that begin with "X_train"
train_file <- train_files[grepl("^X_train", train_files)]

#read in the test & turn to data.table
#data.table has a default fread function to read in data but issues with the EOL/EOF characters couldn't be solved
test <- data.table(read.table(file=paste(test_dir,test_file,sep = "/")))
#read in the train & turn to data.table
#data.table has a default fread function to read in data but issues with the EOL/EOF characters couldn't be solved
train <- data.table(read.table(file=paste(train_dir,train_file,sep = "/")))

#read in column/variable (feature) names
features <- fread(paste(getwd(),"/UCI HAR Dataset/","features.txt",sep =""))
#read in activity labels
labels <- fread(paste(getwd(),"/UCI HAR Dataset/","activity_labels.txt",sep =""))
#read in training labels
train_labels <- fread(paste(train_dir,"y_train.txt",sep="/"))
#read int test labels
test_labels <- fread(paste(test_dir,"y_test.txt",sep="/"))

#setnames for train and test according to features
setnames(test, names(test), features$V2)
setnames(train, names(train), features$V2)

#read int test subjects
test_subjects <- fread(paste(test_dir,"subject_test.txt",sep="/"))
setnames(test_subjects,"V1","subject")

#read int train subjects
train_subjects <- fread(paste(train_dir,"subject_train.txt",sep="/"))
setnames(train_subjects,"V1","subject")

#column bind the labels for test and train & set names
test <- cbind(test,test_labels,test_subjects)
setnames(test, "V1","label")
train <- cbind(train,train_labels,train_subjects)
setnames(train, "V1","label")

#Merges the training and the test sets to create one data set.
#using faster data.table rowbind with list
all_list <- list(train,test)
dt <- rbindlist(all_list)

#Extracts only the measurements on the mean and standard deviation for each measurement. 
#choose columns with data.table
#form a list of column names with standard deviation and mean
cols_chosen <- names(dt)[grepl("mean\\(\\)",colnames(dt)) | grepl("std\\(\\)",colnames(dt))]
cols_chosen <- c(cols_chosen,"label","subject")
dt_subset <- dt[,cols_chosen, with=FALSE]
#Uses descriptive activity names to name the activities in the data set
#label column name is added according to labels
setnames(labels,"V1","label")
dt_subset <- merge(dt_subset,labels, by="label", all.x = TRUE)
setnames(dt_subset,"V2","activity")
dt_subset[,label:=NULL]
#From the data set in step 4, creates a second, independent tidy data set 
#with the average of each variable for each activity and each subject.
dt_tidy <- dt_subset[,lapply(.SD,mean),by=.(activity,subject)]
