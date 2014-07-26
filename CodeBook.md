---
title: "CodeBook"
author: "Logan Yang"
date: "July 26, 2014"
output: html_document
---

filename: dataset_byLogan.txt

column names: subject.activity, e.g. 1.LAYING, 2.SITTING, etc.

row names: the measurements

data entries: the average of each measurement for each activity and each subject

### Transforms used to obtain this dataset from the original

1. Find the measurement variables with the keywords "mean" and "std".
2. Read in only these variables from the original training and test sets.
3. Merge the training and the test sets to create one data set.
4. Use descriptive activity names to name the activities in the data set
5. Label the data set with descriptive variable names. 
6. Create a second, independent tidy data set with the average of each variable for each activity and each subject, by using split on the interaction of *subject* and *activity*, and take the **colMean()**.
