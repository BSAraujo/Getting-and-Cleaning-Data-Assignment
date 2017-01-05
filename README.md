# Getting-and-Cleaning-Data-Assignment
Repo for the Peer-graded assignment for the Coursera course: "Getting and Cleaning Data"

This repository contains the R script "run_analysis.R", which gets a data for the course project and outputs a tidy data set, and a codebook explaining all the variables in the analysis.


The R script does the following:

Downloads the data for the course project, from this url:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Applies the following steps to the data, creating a tidy data set, as requested:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

For the script to work you only need to have an active internet connection.
The script creates a folder called "Assignment Dataset" and downloads to this folder the zip file from the link mentioned above.
It then unzips all the files into this new folder, and loads the data into R. 
The data from the folders named "Inertial Signals" are not used in the analysis.
The script creates two data sets: "data", which is the result of steps 1 to 4, and "avg_data", which is the result of steps 1 to 5.
"data" contains 88 columns (or variables) and 10299 rows (or observations). 
The first identifies the subject (subject id), the second column is the activity description and the rest of the columns are the measurements (only the measurements on the mean and standard for each measurement).
