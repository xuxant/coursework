## Peer Graded Assignment
### Getting and Cleaning Data Course Projet

This repository is Susanta Gautam submission for the course project of Getting and Cleaning Data. It has the instruction how to run the analysis on the Human Activity Recognition dataset.

### Dataset
[Human Activity Recognition](!https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

### Files
  - `CodeBook.md` is a code book explaining the data, it's variables, data transformation discription and the task I performed on the dataset.
  - `run_analysis.R` is the R script that perform the following activity.
    - Download the dataset
    - Extract the dataset.
    - Load all the dataset to the dataframe.
    - Merge the different dataframe into single dataframe.
    - Perform the data transform.
    - Perform the transformation on the variables name.
    - Summarize the data by mean of each variable for each activity and each subject.
    - Export the dataframe into `IndependentData.txt`
  - `IndependentData.txt` is the final exported data.