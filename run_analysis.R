library(dplyr)

## Clean the environment.
rm(list = ls())


zip_name <- "Coursera_DS3_Final.zip"
zip_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
## Verify if the zip file already exist. If not, download it.

if (!file.exists(zip_name)) {
  download.file(zip_url, destfile = zip_name, method = "curl") 
}

## Check if the unarchived directory exists and if not extract it. As zip is extracted to name 
## UCI HAR Dataset, let's check if it is available.

extracted_directory_name <- "UCI HAR Dataset"

if (!file.exists(extracted_directory_name)) {
  unzip(zip_name)
}

files_location <- paste(getwd(), "/", extracted_directory_name, "/", sep = "")

## Now the data set has been extracted, let's load the data set into the 
## data frame for cleaning. First, features and activity labels will be loaded to data frame.

features <- read.table(paste(files_location, "features.txt", sep = ""), col.names = c("n", "features"))
activity_labels <- read.table(paste(files_location, "activity_labels.txt", sep = ""), col.names = c("activity_code", "activity"))

## Now load the training data set. We will be loading subject_train, X_train and y_train data set into data frame.

subject_train <- read.table(paste(files_location, "train/subject_train.txt", sep = ""), col.names = "subject")
X_train <- read.table(paste(files_location, "train/X_train.txt", sep = ""), col.names = features$features)
y_train <- read.table(paste(files_location, "train/y_train.txt", sep = ""), col.names = "training_code")

## Now loading test data set to the data frame. We will be loading subject_test, X_test and y_test.

subject_test <- read.table(paste(files_location, "test/subject_test.txt", sep = ""), col.names = "subject")
X_test <- read.table(paste(files_location, "test/X_test.txt", sep = ""), col.names = features$features)
y_test <- read.table(paste(files_location, "test/y_test.txt", sep = ""), col.names = "training_code")

## Merge the multiple data frame to single data frame. First train and test data set using rbind

# Merge X_train and X_test data frame

X_df <- rbind(X_train, X_test)

# Merge y_test and y_train data frame

Y_df <- rbind(y_train, y_test)

# Merge subject_train and subject_test

subject_df <- rbind(subject_test, subject_train)

## Now let's merge the multiple column

data_df <- cbind(subject_df, Y_df, X_df)

## Remove unused dataframe
rm(list = c("subject_df", "subject_test", "subject_train", "X_df", "Y_df", "y_test", "y_train", "features", "X_train", "X_test"))

## Now we will use dplyr to extract the mean and standard deviation measurement.

tidydata_df <- data_df %>% select(subject, training_code, contains("mean"), contains("std"))

## Using activity name to name the training activity.
tidydata_df$training_code <- activity_labels[tidydata_df$training_code, 2]

## Label the data set with descriptive variable name.

colnames(tidydata_df)[2] <- "activity"
names(tidydata_df) <- gsub("mean()", "Mean", names(tidydata_df))
names(tidydata_df) <- gsub("Mag", "Magnitude", names(tidydata_df))
names(tidydata_df) <- gsub("tBody", "TimeBody", names(tidydata_df))
names(tidydata_df) <- gsub("fBody", "Frequency", names(tidydata_df))
names(tidydata_df) <- gsub("Acc", "Accelerometer", names(tidydata_df))
names(tidydata_df) <- gsub("Gyro", "Gyroscope", names(tidydata_df))
names(tidydata_df) <- gsub("std()", "STD", names(tidydata_df))
names(tidydata_df) <- gsub("freq()", "Frequency", names(tidydata_df))
names(tidydata_df) <- gsub("^t", "Time", names(tidydata_df))

# Second tidy dataset with average of each variable for each subject and activity

Second_Tidy_df <- tidydata_df %>% group_by(subject, activity) %>% summarise_all(list(mean))
write.table(Second_Tidy_df, "IndependentData.txt", row.names = FALSE)