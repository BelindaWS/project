# This script assumes that:
#  1. the data files have been downloaded and extracted
#  2. you know the contents of each file
#  3. you current directory is 'project'

library(dplyr)

print("Current working directory: ")
getwd()

# Enter unzipped files directory
#print("\n)
#  Enter the unzipped files' directory, 
#  This directory is one level down from your current direcotry.\n")
#unzipDir <- readline("Enter data directory name: ")
unzipDir <- "UCI HAR Dataset"

# Create directory if it does not exist
dataDir <- paste(getwd(),"/data/",unzipDir,sep="")

# Set workspace to unzipped data's directory
setwd(dataDir)
getwd()
print("The contents in the unzipped data's directory are:")
list.files(dataDir)

# Read in activity_lables.txt,
# mapping activity number to activity description
activityMap <- read.table("activity_labels.txt",
  header = FALSE,
  sep = " ",
  col.names = c("activityid", "activityname"),
  colClasses = c("factor", "factor"),
  strip.white = TRUE)
# Confirm data are read in correctly
activityMap

# Read in features.txt, a two column file that contains
# the variable number and the variable name.
# The variable name vector will be used later as
# column headings when reading in the X_test & X_train data sets.
features <- read.table("features.txt",
                          header = FALSE,
                          sep = " ",
                          col.names = c("featureid", "feature"),
                          colClasses = c("factor", "factor"),
                          strip.white = TRUE)
# Confirm data are read in correctly
head(features,n=2)
tail(features,n=2)

# Before we read in the other data sets,
# we need to create the column name vector for the X-day based on
# vector of features$featureName.
# The features$feature contain odd characters.
#   - We will remove "()";
#   - We will remove "-";
#   - We will remove "(";
#   - We will remove ")";
#   - replace "," with "_" so as not confuse a csv file later on;
# We will keep the irregular upper & lower cases 
# to make the long feature names more readable.
varnames <- gsub("\\(","",features$feature)
varnames <- gsub("\\)","",varnames)
varnames <- gsub("-","",varnames)
varnames <- gsub(",","_",varnames)
print(varnames)

# Read in the X, y and subject data sets
# !!!!!!!!!!
# NOTE: The part below is repeated to process the 'test' and 'train' data.
# !!!!!!!!!!

# Read in test datasets
testOrTrain <- "test"

subDir <- paste(dataDir,"/",testOrTrain,sep="")

# Read in data files in test sub-directory
# First read in subject_?.txt, the vector of subjectID
# corresponding to each row of record in X_?.txt
filename = paste(subDir,"/subject_",testOrTrain,".txt",sep="")
subjectData <- read.table(filename,
                       header = FALSE,
                       sep = " ",
                       col.names = c("subjectid"),
                       colClasses = c("integer"),
                       strip.white = TRUE)
head(subjectData,n=2)
tail(subjectData,n=2)

# Next read in y_test.txt, the vector of activites
# corresponding to each row of record in X_test.txt
filename = paste(subDir,"/y_",testOrTrain,".txt",sep="")
activityData <- read.table(filename,
                          header = FALSE,
                          sep = " ",
                          col.names = c("activityid"),
                          colClasses = c("factor"),
                          strip.white = TRUE)
head(activityData,n=2)
tail(activityData,n=2)

# Added a column in activityTest by looking up the activityNum value in activityMap
activityData <- mutate(activityData, activity=activityMap[match(activityid, activityMap$activityid, nomatch=0),2])
head(activityData,n=2)
tail(activityData,n=2)

# Read in the X data set
filename = paste(subDir,"/X_",testOrTrain,".txt",sep="")
xData <- read.table(filename,
  header = FALSE,
  col.names = varnames)
head(xData,n=2)
tail(xData,n=2)

# Add 3 columns: subjectID, subjectType, activity to xData
xData$subjecttype <- testOrTrain
xData <- cbind(subjectData$subjectid,
  xData$subjecttype,
  activityData$activity, 
  xData[,1:561])

# Rename these two new columns' names to subjectID and activity
names(xData)[names(xData)=="subjectData$subjectid"] <- "subjectid"
names(xData)[names(xData)=="xData$subjecttype"] <- "subjecttype"
names(xData)[names(xData)=="activityData$activity"] <- "activity"
print("New column names:")
print(names(xData)[1]);print(names(xData)[2]);print(names(xData)[3])
print(tail(xData,n=1))

xData_test = xData

# !!!!!
# Read in train datasets
testOrTrain <- "train"

subDir <- paste(dataDir,"/",testOrTrain,sep="")

# First read in subject_?.txt, the vector of subjectID
# corresponding to each row of record in X_?.txt
filename = paste(subDir,"/subject_",testOrTrain,".txt",sep="")
subjectData <- read.table(filename,
                          header = FALSE,
                          sep = " ",
                          col.names = c("subjectid"),
                          colClasses = c("integer"),
                          strip.white = TRUE)
head(subjectData,n=2)
tail(subjectData,n=2)

# Next read in y_test.txt, the vector of activites
# corresponding to each row of record in X_test.txt
filename = paste(subDir,"/y_",testOrTrain,".txt",sep="")
activityData <- read.table(filename,
                           header = FALSE,
                           sep = " ",
                           col.names = c("activityid"),
                           colClasses = c("factor"),
                           strip.white = TRUE)
head(activityData,n=2)
tail(activityData,n=2)

# Added a column in activityTest by looking up the activityid value in activityMap
activityData <- mutate(activityData, 
  activity=activityMap[match(activityid, activityMap$activityid, nomatch=0),2])
head(activityData,n=2)
tail(activityData,n=2)

# Read in the X data set
filename = paste(subDir,"/X_",testOrTrain,".txt",sep="")
xData <- read.table(filename,
                    header = FALSE,
                    col.names = varnames)
head(xData,n=2)
tail(xData,n=2)

# Add 3 columns: subjectID, subjectType, activity to dataTest
xData$subjecttype <- testOrTrain
xData <- cbind(subjectData$subjectid,
               xData$subjecttype,
               activityData$activity, 
               xData[,1:561])

# Rename these two new columns' names to subjectID and activity
names(xData)[names(xData)=="subjectData$subjectid"] <- "subjectid"
names(xData)[names(xData)=="xData$subjecttype"] <- "subjecttype"
names(xData)[names(xData)=="activityData$activity"] <- "activity"
print("New column names:")
print(names(xData)[1]);print(names(xData)[2]);print(names(xData)[3])
print(tail(xData,n=1))

xData_train = xData

# Save data sets to the 'data' subdirectory,
# one level ABOVE 'UCI HAR Dataset' sub-subdirectory
setwd("../../")

# Save current workspace
print("Saving workspace to 'run_analysis.RData'")
save(list = ls(all = TRUE), file = "run_analysis.RData")

