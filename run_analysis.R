## If you haven't already done so, save the UCI HAR Dataset to your working directory. Data can be downloaded here: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
## Set your working directory in R.

##Read all test and training data into R. This includes three separate files/data frames for both test and training; one containing subject id's, one containing acceleration and velocity measurements, and one containing the subjects activity at the time of the measurement.   

subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", quote="\"")
X_test <- read.table("UCI HAR Dataset/test/X_test.txt", quote="\"")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", quote="\"")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", quote="\"")
X_train <- read.table("UCI HAR Dataset/train/X_train.txt", quote="\"")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", quote="\"")

## The data need to be merged into one data frame in order to be analyzed. For both the test and training data, the three data frames --id, activity, and measurements-- are combined into one data frame using the cbind function.

test.df <- cbind(subject_test, y_test, X_test)
train.df <- cbind(subject_train, y_train, X_train)

##Now that there are two data frames -- one test data and one for training data -- these two data frames are combined into one using the rbind function. 
df.merged <- rbind(train.df, test.df)

##The subject id and activity columns are labeled accordingly for clarity. 

names(df.merged)[1:2] <- c("id", "activity")

##Acceleration and velocity measurements that are mean or standard deviations are extracted from the data frame to form a new, smaller, data frame. The criterion for doing so was to look through features.txt and select only those variables that ended with "mean()" or "std()".

df.merged2 <- df.merged[ , c(1:8, 43:48, 83:88, 123:128, 163:168, 203:204, 216:217, 229:230, 242:243, 255:256, 268:273, 347:352, 426:431, 505:506, 518:519, 531:532, 544:545)]

##The numeric values in the activity column are replaced with descriptive names matched to the information in activity_labels.txt. This is done by assigning labels in the factors function. 

df.merged2$activity <- factor(df.merged2$activity, levels = 1:6, labels = c("walking", "walking_upstairs", "walking_downstairs", "sitting", "standing", "laying"))

##The names for the 66 acceleration and velocity measurement variables are manually copied from features.txt and are manually edited to eliminate "()" and "-" and add in underscores for separation. These new names are assigned to the data frame.

names(df.merged2)[3:68] <- c("tBodyAcc_mean_X", "tBodyAcc_mean_Y", "tBodyAcc_mean_Z", "tBodyAcc_std_X", "tBodyAcc_std_Y", "tBodyAcc_std_Z", "tGravityAcc_mean_X", "tGravityAcc_mean_Y", "tGravityAcc_mean_Z", "tGravityAcc_std_X", "tGravityAcc_std_Y", "tGravityAcc_std_Z", "tBodyAccJerk_mean_X", "tBodyAccJerk_mean_Y", "tBodyAccJerk_mean_Z", "tBodyAccJerk_std_X", "tBodyAccJerk_std_Y", "tBodyAccJerk_std_Z", "tBodyGyro_mean_X", "tBodyGyro_mean_Y", "tBodyGyro_mean_Z", "tBodyGyro_std_X", "tBodyGyro_std_Y", "tBodyGyro_std_Z", "tBodyGyroJerk_mean_X", "tBodyGyroJerk_mean_Y", "tBodyGyroJerk_mean_Z", "tBodyGyroJerk_std_X", "tBodyGyroJerk_std_Y", "tBodyGyroJerk_std_Z", "tBodyAccMag_mean", "tBodyAccMag_std", "tGravityAccMag_mean", "tGravityAccMag_std", "tBodyAccJerkMag_mean", "tBodyAccJerkMag_std", "tBodyGyroMag_mean", "tBodyGyroMag_std", "tBodyGyroJerkMag_mean", "tBodyGyroJerkMag_std", "fBodyAcc_mean_X", "fBodyAcc_mean_Y", "fBodyAcc_mean_Z", "fBodyAcc_std_X", "fBodyAcc_std_Y", "fBodyAcc_std_Z", "fBodyAccJerk_mean_X", "fBodyAccJerk_mean_Y", "fBodyAccJerk_mean_Z", "fBodyAccJerk_std_X", "fBodyAccJerk_std_Y", "fBodyAccJerk_std_Z", "fBodyGyro_mean_X", "fBodyGyro_mean_Y", "fBodyGyro_mean_Z", "fBodyGyro_std_X", "fBodyGyro_std_Y", "fBodyGyro_std_Z", "fBodyAccMag_mean", "fBodyAccMag_std", "fBodyBodyAccJerkMag_mean", "fBodyBodyAccJerkMag_std", "fBodyBodyGyroMag_mean", "fBodyBodyGyroMag_std", "fBodyBodyGyroJerkMag_mean", "fBodyBodyGyroJerkMag_std")

##Some of the variable names have a typo where it says "BodyBody" instead of "Body". I replace these using gsub(). Also, I chose to remove the underscores and change "mean" and "std" so that they begin with capital letters.

names(df.merged2) <- gsub("BodyBody", "Body", names(df.merged2))
names(df.merged2) <- gsub("_", "", names(df.merged2))
names(df.merged2) <- gsub("mean", "Mean", names(df.merged2))
names(df.merged2) <- gsub("std", "Std", names(df.merged2))

## In order to calculate averages for the acceleration and velocity variables, the dplyr package is installed and loaded. 

install.packages("dplyr")
library("dplyr")
df2 <- tbl_df(df.merged2)

##The data frame is arranged and grouped by activity and subject id.
df2 <- arrange(df2, id, activity)
g.df2 <- group_by(df2, activity, id)

##Last, the summaris_each function is run on the grouped data to calculate the mean for each subject at each activity level. 
df2.activity.means <- summarise_each(g.df2, funs(mean), tBodyAccMeanX:fBodyGyroJerkMagStd)

View(df2.activity.means)
