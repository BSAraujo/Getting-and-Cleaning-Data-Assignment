# Peer-graded Asssignment: Getting and Cleaning Data Course Project
#
# Name: Breno Serrano de Araujo
#
# This R script downloads the zip file containing the data from the url given in the assignment description,
# unzips the file, reads the data files into R and does all the required steps, 
# cleaning the data and making it tidy.
#


library(plyr)
library(dplyr)

# creates a folder where the files with the data will be downloaded to
destfolder <- "Assignment Dataset" 

if (!file.exists(destfolder)) {
  dir.create(destfolder)
}

# downloads the zip file containing the data and unzips it
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

destfile <- "assignment_dataset.zip"
download.file(url, destfile)
unzip(destfile, exdir = destfolder)

# sets the working directory to the folder "UCI HAR Dataset"
path <- paste0("./", destfolder, "/UCI HAR Dataset")
setwd(path)

# read files with activity and feature description
activity_labels <- read.table("activity_labels.txt", col.names = c("activity_id", "activity_description")) %>%
  tbl_df

features <- read.table("features.txt", col.names = c("feature_id", "feature_description")) %>% tbl_df

# read training set into R
X_train <- read.table("train/X_train.txt", col.names = features$feature_description) %>% tbl_df
y_train <- read.table("train/y_train.txt", col.names = "activity_id") %>% tbl_df
subject_train <- read.table("train/subject_train.txt", col.names = "subject_id") %>% tbl_df



# read test set into R
X_test <- read.table("test/X_test.txt", col.names = features$feature_description) %>% tbl_df
y_test <- read.table("test/y_test.txt", col.names = "activity_id") %>% tbl_df
subject_test <- read.table("test/subject_test.txt", col.names = "subject_id") %>% tbl_df


# 1. Merge the training and the test sets to create one data set
# creates 3 data tables which will later be binded together, in step 4
X_data <- rbind(X_train, X_test)
y_data <- rbind(y_train, y_test)
subject <- rbind(subject_train, subject_test)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement
data <- select(X_data, contains("mean"), contains("std"))

# 3. Uses descriptive activity names to name the activities in the data set
activity <- inner_join(y_data, activity_labels) %>% select(activity_description) 

# 4. Appropriately labels the data set with descriptive variable names.
colnames(data) <- gsub("(\\.)+$", "", colnames(data))
colnames(data) <- gsub("(\\.)+", "_", colnames(data))

# binds the 3 data tables together columnwise:
data <- cbind(subject, activity, data) %>% tbl_df

# This is the final tidy data set for step 4:
View(data)

# 5. From the data set in step 4, creates a second, independent tidy data set 
#    with the average of each variable for each activity and each subject.
avg_data <- data %>% group_by(subject_id, activity_description) %>% 
  summarise_each(funs(mean))

# This is the final tidy data set for step 5:
View(avg_data)

write.table(avg_data, file = "output_data.txt", row.names = FALSE)


