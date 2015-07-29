---
title: "README"
author: "Morozov Gleb"
date: "Saturday, March 21, 2015"
output: html_document
---

Getting and Cleaning Data Course Project
========================================

'run_analysis.R' script does the following action sequence:

1. Downloading and extracting raw data
2. Required packages are "dplyr" and "tidyr"
3. Reading test and train datasets
4. Merges the training and the test sets to create one data set.
5. Extracts only the measurements on the mean and standard deviation for each measurement.
6. Transforming column names in readable form.
7. Creating the second dataset from the first one. The new dataset contains only average values of all observations of the 1st dataset for each activity and each subject.
