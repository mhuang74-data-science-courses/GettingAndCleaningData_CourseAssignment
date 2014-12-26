---
title: "CodeBook"
author: "Michael Huang"
date: "December 22, 2014"
output: html_document
---

This is the CodeBook to explain how UCI Human Activity Recognition dataset was tidied.

Steps Taken to create Tidy Data

* Row bind y_train and y_test datasets, then merge() with activity_labels file using activity id to get activity label for each measurement row.
* Row bind subject_train and subject_test to get subject id for each measurement row.
* Row bind X_train and X_test to get combined measurements.
* In features.txt, assume first column corresponds to column number in X_train/X_test. Sort using first column, and use sorted second column as column names for combined measurements.
* Reduce size of combined measurements by using subset() to select only columns with names that contain "mean" or "std".
* Column bind reduced combined measurements with activity label and subject id.
* Create a new key vector that has all combinations of Activity and SubjectID's.
* Traverse each column of reduced combined measurements using apply, and for each column, take the grouped average using tapply and the Activity_SubjectID key vector constructed above.
* Convert resulting matrix to long-form dataframe.
* Write results to tab delimited file "tidy_data.txt" using write.table.

