Getting-and-Cleaning-Data-Project
=================================
Course project for Getting and Cleaning Data.  See https://class.coursera.org/getdata-004

The run_analysis.R script uses data collected from the accelerometers from the Samsung Galaxy S smartphone.  It has several steps, to produce a tidy data set using the measurements on the mean and standard deviation for each measurement.  The tidy data set contains the average of each variable for each activity and each subject in the original data.

The script does the following:
0. Downloads the original data, and unzip it
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.  This does not include the mean frequency (meanFreq(): weighted average of the frequency components) 
3. Creates a new variable labelling the activities in the data set
4. Renames the mean and standard deviation variable names, so that they are appropriate for analysis and suitably descriptive 
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject, and writes this dataset to file 
