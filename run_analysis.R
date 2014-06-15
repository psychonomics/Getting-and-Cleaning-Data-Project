# See the readme.md file for more details about how this script works

#-------------------------------------------------------------------------
### 0. Download the data, unzip the folders
my.url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url=my.url, destfile="getdata-projectfiles-UCI HAR Dataset.zip")
unzip("getdata-projectfiles-UCI HAR Dataset.zip")
#?unzip  # {utils} Extract of List Zip Archives
```

#-------------------------------------------------------------------------
### 1. Merge the training and the test sets to create one data set

# Read the meta data
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")
features <- read.table("./UCI HAR Dataset/features.txt")
features <- features[ , 2]

# Read the training data
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")

# Read the testing data
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt", header = FALSE)
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt", header = FALSE)
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")

# Name the X training and test data
names(X_train) <- features
names(X_test) <- features

# Combine the training data [subject, y, X]
train <- cbind(subject_train, y_train, X_train) 

#### Combine the test data [subject, y, X]
test <- cbind(subject_test, y_test, X_test) 

#### Combine the training and test data
complete <- rbind(train, test) 

#### Remove the composite parts of the training and test data
rm(subject_train, y_train, X_train)
rm(subject_test, y_test, X_test)
rm(train, test)


#-------------------------------------------------------------------------
### 2. Extract the mean and standard deviation for each measurement

# Create Indices for mean variables
index.mean <- grep("-mean()", features, fixed = TRUE)

# Create Indices for std variables
index.std <- grep("-std()", features)

# Create a single index vector for the mean and std variables
index.mean.std <- sort(c(index.mean, index.std))

# Add 2 to the index vector, to allow for the subject and y variables
index.df.subset <- c(1, 2, index.mean.std + 2)

# Subset the complete dataframe columns, using the index vector
df.subset <- complete[ , index.df.subset]

# Remove the composite index vectors, and the complete data set
rm(index.mean, index.std)
rm(index.mean.std, index.df.subset)
rm(complete)


### 3. Use descriptive activity names to name the activities in the data set

names(df.subset)[1] <- "Subject"
names(df.subset)[2] <- "Activity.Code"

# Create a new variable containing the activity label
df.subset$Activity <- activity_labels[df.subset$Activity.Code, 2]

# Keep the subject number, activity name, and measurements
df.subset <- df.subset[, c(1, 69, 3:68)]


####

#-------------------------------------------------------------------------
### 4. Appropriately label the data set with descriptive activity names

# Create a vector of descriptive activity names
names <- names(df.subset)

# Remove the brackets from each variable name
names <- gsub(pattern = "[()]", replacement = "", x = names)

# Replace the dash with a dot
names <- gsub(pattern = "-", replacement = ".", x = names)

# Acceleration Signal - Body
names <- gsub(pattern = "tBodyAcc", 
              replacement = "time.domain.body.acceleration.signals",
              x = names)

# Acceleration Signal - Gravity
names <- gsub(pattern = "tGravityAcc", 
              replacement = "time.domain.gravity.acceleration.signals", 
              x = names)
 
# Gyroscope Signal
names <- gsub(pattern = "tBodyGyro", 
              replacement = "time.domain.body.gyroscope.signals", 
              x = names)

# Acceleration Signal - Body
names <- gsub(pattern = "fBodyAcc", 
              replacement = "frequency.domain.body.acceleration.signals",
              x = names)

names <- gsub(pattern = "fBodyBodyAcc", 
              replacement = "frequency.domain.body.acceleration.signals",
              x = names)

# Gyroscope Signal
names <- gsub(pattern = "fBodyGyro", 
              replacement = "frequency.domain.body.gyroscope.signals", 
              x = names)

names <- gsub(pattern = "fBodyBodyGyro", 
              replacement = "frequency.domain.body.gyroscope.signals", 
              x = names)

# Jerk
names <- gsub(pattern = "signalsJerk", 
              replacement = "Jerk.signals", 
              x = names)

# Magnitude
names <- gsub(pattern = "Mag", 
              replacement = ".magnitude", 
              x = names)

# Assign the names to the dataframe
names(df.subset) <- names


#-------------------------------------------------------------------------
### 5. Create a second, independent tidy data set with the average of each variable for each activity and each subject

# Assign the names to the dataframe
df.tidydata <- aggregate(df.subset[, 3:68], by = list("Subject" = df.subset$Subject, 
                            "Activity" = df.subset$Activity), FUN = "mean")

# Export the data to a .txt file in the working directory
write.table(df.tidydata, file = "./UCI HAR Dataset/Tidy Data Export.txt", row.names = FALSE)