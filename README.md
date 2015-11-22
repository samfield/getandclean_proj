This repository contains my files for get project assignment for the getting and cleaningn data Coursera course.
The repository holds three files: the readme files (which includes the code book), the run_analysis.R script file containing the script that tidies up the data and the tidy.txt file. The tidy.txt file is the ouput file of a data set of the assignement.
==========STUDY DESIGN======================
run_analysis.R :

Dependencies on packages and user actions:
-library data.table is used. Installation of the package is assumed.
-after downloading the dataset the user is expected to extract the folder and files as is from the archive.
Note:automation for extracting through script would be possible but some issues steered to extract manually.

Goal of script:
This script loads, reads and mangles the Samsung dataset described in the outline of the assginement. The description of the original dataset can be found:http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones.

Loading:
The script downloads the archived dataset from the url provided in the assginment and saves it in the working directory of the user. The user is expected to extract the archive as-is into the working directory -with the subfolderstructure included.
Reading:
The script reads datasets containing the training,test, label and subject data into R. All tables are converted or read in as a data.table for convienience later on.

Mangle:
The main steps -after downloading and reading the data- for constructing the data are:
1.)setting equal names for training and test data (this is done for merging)
2.)Train and test data are rowbinded together 
3.)the mean, standard deviation, activity label and subject columns are extracted from the column names with grep functions.
4.)Activity labels are attached to the dt_subset data.table
5.)Finally a dt_tidy dataset is calculated containing the variables of interest. This data is described in the following code book.
6.)tidy dataset is printed in the console.
===========CODE BOOK:=====================

The set contains one row per test subject per activity label (which desribes whether subject was walking, sitting etc).
The variables are:

Activity label: factor variable with several classes, depicting if the measurements were taken when the subject was standing, walking, sitting etc.

Subject: Identifier for each subject. Integer.

Variables containing the calculated mean values for each of the measurement (of standard deviation or mean) for each of the subject activity class at a time. 
These varuiables include:
"tBodyAcc-mean()-X" "tBodyAcc-mean()-Y" "tBodyAcc-mean()-Z" "tBodyAcc-std()-X" "tBodyAcc-std()-Y" "tBodyAcc-std()-Z" "tGravityAcc-mean()-X" "tGravityAcc-mean()-Y" "tGravityAcc-mean()-Z" "tGravityAcc-std()-X" "tGravityAcc-std()-Y" "tGravityAcc-std()-Z" "tBodyAccJerk-mean()-X" "tBodyAccJerk-mean()-Y" "tBodyAccJerk-mean()-Z" "tBodyAccJerk-std()-X" "tBodyAccJerk-std()-Y" "tBodyAccJerk-std()-Z" "tBodyGyro-mean()-X" "tBodyGyro-mean()-Y" "tBodyGyro-mean()-Z" "tBodyGyro-std()-X" "tBodyGyro-std()-Y" "tBodyGyro-std()-Z" "tBodyGyroJerk-mean()-X" "tBodyGyroJerk-mean()-Y" "tBodyGyroJerk-mean()-Z" "tBodyGyroJerk-std()-X" "tBodyGyroJerk-std()-Y" "tBodyGyroJerk-std()-Z" "tBodyAccMag-mean()" "tBodyAccMag-std()" "tGravityAccMag-mean()" "tGravityAccMag-std()" "tBodyAccJerkMag-mean()" "tBodyAccJerkMag-std()" "tBodyGyroMag-mean()" "tBodyGyroMag-std()" "tBodyGyroJerkMag-mean()" "tBodyGyroJerkMag-std()" "fBodyAcc-mean()-X" "fBodyAcc-mean()-Y" "fBodyAcc-mean()-Z" "fBodyAcc-std()-X" "fBodyAcc-std()-Y" "fBodyAcc-std()-Z" "fBodyAccJerk-mean()-X" "fBodyAccJerk-mean()-Y" "fBodyAccJerk-mean()-Z" "fBodyAccJerk-std()-X" "fBodyAccJerk-std()-Y" "fBodyAccJerk-std()-Z" "fBodyGyro-mean()-X" "fBodyGyro-mean()-Y" "fBodyGyro-mean()-Z" "fBodyGyro-std()-X" "fBodyGyro-std()-Y" "fBodyGyro-std()-Z" "fBodyAccMag-mean()" "fBodyAccMag-std()" "fBodyBodyAccJerkMag-mean()" "fBodyBodyAccJerkMag-std()" "fBodyBodyGyroMag-mean()" "fBodyBodyGyroMag-std()" "fBodyBodyGyroJerkMag-mean()" "fBodyBodyGyroJerkMag-std()"
