---
title: "ReadMe"
author: "Michael Huang"
date: "December 22, 2014"
output: html_document
---

This is the ReadMe article for the Course Assignment of Getting and Cleaning Data.

In this assignment, I created a script to tidy up [data](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) from [UCI Human Activity Recognition Using Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) project.

The followinwg artifacts are included for this assignment submission:

1. README.md - this file
2. run_analysis.R - script to tidy up data per assignment instructions
3. CodeBook.md - Codebook to explain how data was tidied and what's included in the tidy data file
4. tidy_data.txt - tidy data with only the average of each variable for each activity-subject

Courtesy of [David's Proejct FAQ forum article](https://class.coursera.org/getdata-016/forum/thread?thread_id=50), the command for reading in tidy data and viewing it in R would be

```{r}
  data <- read.table("tidy_data.txt", header = TRUE)
  View(data)
```

