#Getting and Cleaning Data, Course Project
======================
##Description of Project

The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit: 1) a tidy data set as described below, 2) a link to a Github repository with your script for performing the analysis, and 3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.  

One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Here are the data for the project: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

 You should create one R script called run_analysis.R that does the following. 
*Merges the training and the test sets to create one data set.
*Extracts only the measurements on the mean and standard deviation for each measurement. 
*Uses descriptive activity names to name the activities in the data set
*Appropriately labels the data set with descriptive variable names. 
*From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

##Explanation of What I Did

In order to run the file run_analysis.R the user must save the UCI HAR
Dataset to his or her working directory. The data can be downloaded
here:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR
%20Dataset.zip

See Codebook.md for a short description of the data and the variables.

The code reads in the data files, merges them into one data set, subsets
the desired columns, labels the variables, orders the dataframe, and,
finally, calculates the average for each acceleration and velocity
variable for each participant at each activity level.

The code in run_ analysis.R first reads all test and training data into
R. This includes three separate files for both test and training; one
containing subject id numbers, one containing acceleration and velocity
measurements, and one containing the subjects activity at the time of
the measurement. I excluded the inertial signals files.

The data need to be merged into one data frame in order to be analyzed.
For both the test and training data, the three data frames -- id,
activity, and measurements -- are combined into one data frame using the
cbind function. Now that there are two data frames -- one test data and
one for training data -- these two data frames are combined into one
using the rbind function. The data frame is in the wide form, that is,
each measurement variable has its own column.

The subject id and activity columns are labeled accordingly for clarity.

Acceleration and velocity measurements that are mean or standard
deviations are extracted from the data frame to form a new, smaller,
data frame. The criterion for doing so was to look through features.txt
and select only those variables that ended with "mean()" or "std()".

The numeric values in the activity column are replaced with descriptive
names matched to the information in activity_labels.txt. This is done by
assigning labels in the factors function.

The names for the 66 acceleration and velocity measurement variables are
manually copied from features.txt and are manually edited to eliminate
"()" and "-" and add in underscores for separation. These new names are
assigned to the data frame. Some of the variable names have a typo where
it says "BodyBody" instead of "Body". I replace these using gsub().
Also, I chose to remove the underscores and change "mean" and "std" so
that they begin with capital letters.

In order to calculate averages for the acceleration and velocity
variables, the dplyr package is installed and loaded. The data frame is
arranged and grouped by activity and subject id. Last, the summaris_each
function is run on the grouped data to calculate the mean for each
subject at each activity level. 
