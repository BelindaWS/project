# Coursera Getting and Cleaning Data Project
============================================
This is a class project as partial fulfillment for the Coursera course
'Getting And Cleaning Data'.

## Project Statement
-------------------
The project requires:
1. Data to be downloaded from
<https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>
2. Process the data
3. Analyze the data including
* trimming the data columns
* grouping the trimmed data
* getting means for the numeric columns by group
* generating the results to a .txt file

## Directory & Files
---------------------
* project, which contains:
  - this README file,
  - R scripts,
  - and results files,
  - as well as miscellaneous files used to check
  intermediate and final results.
* data, which is one level below project:
  this is where the zipped file was downloaded to
* UCI HAR Dataset, which is automatically created
  when the zipped file was extracted. It contains
  - README.txt: background information regarding the data
  - activity_labels.txt: this file will be read in
  and matched with the measurements file later.
  It contains a numeric value and a text string of
  six different types of activities carried out by
  subjects when the measurements were made.
  - features.txt: this file will be used to create
  headings for the measurement data file. They are the
  names of 561 variables for each measurements were taken
  - features_info.txt: explains the features.
  - test: subdirectory containing "test" datasets
  - train: subdirectory containing "training" datasets
  Both the test and train directories contain
    > processed data (X_, subject_, y_),
    > and raw data (in Intertial Signals subdirectory)
    on test and train subjects respectively.

The files in the Inertial Signals subdirectories are not
needed for this project and can be ignored or removed.

The (X_, subject_, y_) files are ascii files,
without column headings, and with a space (" ")
as separator where applicable. A major part of this
project is to match up these three files together
for the test and train datasets respectively.

The X_test.txt and X_train.txt contains processed
data of the 561 variables, listed in the order of
the time and frequency domain for a test or train subject
for a given activity.

The subject_test.txt and subject_train.txt contains
the subject ID number that correspond to each record
in the X_test.txt and X_train.txt respectively.
There are 30 unique subjects total,
9 in test, the remaining in train.

The y_test.txt and y_train.txt contains the
activity number corresponding to each record in the
X_test.txt and X_train.txt.  Since we are asked to
list the results with a descriptive activity,
we have to use the activity number & activity name
in file 'activity_labels.txt' as a lookup table.
There are six unique activities.

After data from the these three files,
(subject_, y_ and X_ ) are matched up, for both
the test and train datasets, then we were asked to
combine the test and train datasets into one.

From the combined datasets, we are then asked to
cut down the 561 measurement variables to only
those that are either a 'mean' or 'std' value.
This reduced the 561 measurement columns to 86.

This trimmed down dataset is then grouped by
subject (regardless of test or train), and
activity.

I have written 3 separate R scripts to perform
the project assignment, as it requires 3 major steps:
* download and extract data,
* process the data,
* analyze the data and output results.

The R scripts and corresponding documentation are:
* dataDownloadExtract.R, dataDownloadExtract.docx
* processData.R, processData.docx
* run_analysis.R, run_analysis.docx

The saved workspace are in run_analysis.RData

I generated several .xlsx files so I can check
the intermediate and final results.
* checkRecordCount.xlsx was used to ensure that
  the number of records for a given unique subject
  in the test and train datasets, and for a given
  unique activity, summed up to
  the total number of records in the respective
  X_test.txt and X_train.txt file.  One can see
  in this file that each subject has several
  hundreds of records over the six activities.

* subjectSortedData.xlsx contains a subset
  of the trimmed down data sorted by
  subject and activity. The file only has
  some of the measurement variables, but has
  all the train and test records, 10299 records
  in all, which is the sum of the number of records
  respectively in X_test.txt and X_train.txt.
  For the first 3 variable columns, I added a column
  next to each to calculate the mean value for a
  given subject and activity.  I did this for the
  subject 1 for all six activites, and subject 2
  for the first few activities.

* MeansByIdAndActivity.xlsx contains 180 rows
  (30 subjects X 6 activties) of mean value
  for each of the 86 "mean" and "std" columns, for a
  given subject and activity pair. I compared these
  values for those values I calculated in
  extractedSortedData.xlsx to make sure they agree.

* MeansByIdAndActivity.txt is the final results file
  produced after I confirmed via
  byIdAndActivity.xlsx that everything looked fine.

