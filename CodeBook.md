---
title: "CodeBook"
author: "Susanta Gautam"
date: '2022-05-14'
output: html_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

## Code Book

The R script run_analysis.R perform various steps for preparing the data for analysis. The steps are described in details below.

- Collection of the Data

    -   Data set is download from the [source](!https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) under the file name Coursera_DS3_Final.zip archive.
    -   Archive is extracted under the name UCI HAR Data set.
    -   Inside the UCI HAR Data set, there is README file that explains how the data is stored in different files.

- Loading Data and Assigning Features Name.

  - Features: Features in this data set are stored in features.txt file. The features in this data set comes from the signal of accelerometer and gyroscope.
    
  - Activities: Activities consist of the set of activities performed by the test subjects when corresponding measurement was taken. Activity in this dataset is stored on activity_labels.txt file.
    
  - Subject Test: Subject test consist of the subject volunteers for the experiment. Value range from 1 to 30.
    
  - Subject Train: Subject train consist of the subject volunteers for the experiment. Value range from 1 to 30.

  - X_test: X_test consist of the recorded features for the experiments.

  - Y_test: Y_test consist of the labels for the test experiments.

  - X_train: X_train consist of the recorded features for the experiments.

  - Y_train: Y_train consist of the labels for the train experiments.

    
- Merge the multiple dataframe to single dataframe.
  
  - X_df is created by merging X_train and X_test using rbind.
  - Y_df is created by merging y_train and y_test using rbind function.
  - subject_df is created by merging subject_train and subject_test using rbind function.
  - data_df is created by merging X_df, Y_df and subject_df using cbind function.
    
- Extracting the measurements on mean and standard deviation.
  - tidydata_df is created by subsetting data_df while only selecting the columns subject, code and column containing mean and std.
  
- Label the activity code with activity name
  - Code column in tidydata_df is replaced with the activity name.
  
- Label the dataset with descriptive variables name
  - `code` column is replaced with `activities`.
  - All `mean()` is replaced with `Mean`.
  - All `Mag` is replaced with `Magnitude`.
  - All `tBody` is replaced with `TimeBody`.
  - All `fBody` is replaced with `FrequencyBody`.
  - All `Acc` is replaced with `Aclerometer`.
  - All `Gyro` is replaced with `Gyroscope`.
  - All `std()` is replaced with `STD`.
  - All `freq()` is replaced with `Frequency`.
  - All string with character `t` is replaced with `Time`.

- From the tydydata_df, new independent tidy data set with the average of each variable for each activity and each subject is created.
  - `Second_Tidy_df` dataframe is created summarizing `tidydata_df` by taking mean of each variable for each activity and each subject.
  - Exported `Second_Tidy_df` into `IndependentData.txt`.
    