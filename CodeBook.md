---
title: "CodeBook"
author: "PrideNN"
date: "Saturday, March 21, 2015"
output: html_document
---

CodeBook for Tidy UCI HAR Dataset
=================================

This CodeBook describes the data contained in the output of the `run_analysis.R` script contained in this repository. The tidy flat text file can be read using `data.table` to create a data table for further analysis.

```R
tidy_data <- data.table("tidy_data.txt")
```

The script creates a tidy, condensed version of the University of California Irvine's (UCI's) dataset for Human Activity Recognition (HAR) using smartphones that can be used for further research and analysis. The original UCI HAR Dataset is a public domain dataset built from the recordings of subjects performing activities of daily living (ADL) while carrying a waist-mounted smartphone with embedded inertial sensor (see http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

As noted in the above referenced document, the original data comes from experiments that were carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (walking, walking_upstairs, walking_downstairs, sitting, standing, and laying) wearing a Samsung Galaxy S II smartphone on the waist. Using its embedded accelerometer and gyroscope, 3-axial linear acceleration and 3-axial angular velocity were captured at a constant rate of 50Hz. The experiments were video-recorded to label the data manually.

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force was assumed to have only low frequency components, so a filter with a 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

The script generates a combined subset of the original data by extracting the mean and standard deviation features for each of the 33 processed signals, for a total of 66 features (out of the 561 available features from the original feature vector). This combined subset contains 10299 observations of 68 variables, with activity and subject appended to the 66 features.

The combined subset is further reduced by calculating the mean of the observations by activity and subject pair to generate 180 observations (6 activities * 30 subjects) of the same 68 variables. This dataset is tidied to generate a narrow and lean dataset containing 11880 observations with 4 variables each and is saved as a text file in the current working directory with the name `tidy_data.txt`

## Variable name cleanup

As part of the _tidying_ process the variable names are cleaned up using the following transformations.

```R
filt.feat <- features$V2[feat.ind] %>% gsub("\\(\\)", "", .) %>% 
        gsub("Acc", "-acceleration", .) %>% gsub("Mag", "-magnitude", .) %>%
        gsub("(Jerk|Gyro)", "-\\1", .) %>% gsub("^t(.*)$", "Time-\\1", .) %>%
        gsub("^f(.*)$", "Frequency-\\1", .) %>% gsub("BodyBody", "Body", .)
```

And finally all variable names are converted into lowercase.

## Description of the UCI HAR variables

The Tidy dataset consists of 11880 observations summarized by activity (6 categories) and subject (30 volunteers) pairs. For each observation (row) in the Tidy dataset, the following 4 columns are provided:

- subject
- activity
- measurement
- mean

### subject

A numeric identifier (1-30) of the subject who carried out the experiment.

### activity

The activity name with the following possible values.
- 'laying',
- 'sitting',
- 'standing',
- 'walking',
- 'walking_downstairs'
- 'walking_upstairs'

### measurement

The name of the measurement for which the mean is calculated. This variable can contain one of the following 66 variables. Please refer the codebook with the original dataset for the explanation of these different variables.

[1] "time-body-acceleration-mean-x"                   "time-body-acceleration-mean-y"                  
[3] "time-body-acceleration-mean-z"                   "time-body-acceleration-std-x"                   
[5] "time-body-acceleration-std-y"                    "time-body-acceleration-std-z"                   
[7] "time-gravity-acceleration-mean-x"                "time-gravity-acceleration-mean-y"               
[9] "time-gravity-acceleration-mean-z"                "time-gravity-acceleration-std-x"                
[11] "time-gravity-acceleration-std-y"                 "time-gravity-acceleration-std-z"                
[13] "time-body-acceleration-jerk-mean-x"              "time-body-acceleration-jerk-mean-y"             
[15] "time-body-acceleration-jerk-mean-z"              "time-body-acceleration-jerk-std-x"              
[17] "time-body-acceleration-jerk-std-y"               "time-body-acceleration-jerk-std-z"              
[19] "time-body-gyro-mean-x"                           "time-body-gyro-mean-y"                          
[21] "time-body-gyro-mean-z"                           "time-body-gyro-std-x"                           
[23] "time-body-gyro-std-y"                            "time-body-gyro-std-z"                           
[25] "time-body-gyro-jerk-mean-x"                      "time-body-gyro-jerk-mean-y"                     
[27] "time-body-gyro-jerk-mean-z"                      "time-body-gyro-jerk-std-x"                      
[29] "time-body-gyro-jerk-std-y"                       "time-body-gyro-jerk-std-z"                      
[31] "time-body-acceleration-magnitude-mean"           "time-body-acceleration-magnitude-std"           
[33] "time-gravity-acceleration-magnitude-mean"        "time-gravity-acceleration-magnitude-std"        
[35] "time-body-acceleration-jerk-magnitude-mean"      "time-body-acceleration-jerk-magnitude-std"      
[37] "time-body-gyro-magnitude-mean"                   "time-body-gyro-magnitude-std"                   
[39] "time-body-gyro-jerk-magnitude-mean"              "time-body-gyro-jerk-magnitude-std"              
[41] "frequency-body-acceleration-mean-x"              "frequency-body-acceleration-mean-y"             
[43] "frequency-body-acceleration-mean-z"              "frequency-body-acceleration-std-x"              
[45] "frequency-body-acceleration-std-y"               "frequency-body-acceleration-std-z"              
[47] "frequency-body-acceleration-jerk-mean-x"         "frequency-body-acceleration-jerk-mean-y"        
[49] "frequency-body-acceleration-jerk-mean-z"         "frequency-body-acceleration-jerk-std-x"         
[51] "frequency-body-acceleration-jerk-std-y"          "frequency-body-acceleration-jerk-std-z"         
[53] "frequency-body-gyro-mean-x"                      "frequency-body-gyro-mean-y"                     
[55] "frequency-body-gyro-mean-z"                      "frequency-body-gyro-std-x"                      
[57] "frequency-body-gyro-std-y"                       "frequency-body-gyro-std-z"                      
[59] "frequency-body-acceleration-magnitude-mean"      "frequency-body-acceleration-magnitude-std"      
[61] "frequency-body-acceleration-jerk-magnitude-mean" "frequency-body-acceleration-jerk-magnitude-std" 
[63] "frequency-body-gyro-magnitude-mean"              "frequency-body-gyro-magnitude-std"              
[65] "frequency-body-gyro-jerk-magnitude-mean"         "frequency-body-gyro-jerk-magnitude-std"  e

### mean

The mean of the measurements.
