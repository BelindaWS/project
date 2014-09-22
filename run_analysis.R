# Analyze the test and train data that have been processed previouly.

# To be consistent, manually set the workspace
# to the 'project' directory

# Load workspace
load("run_analysis.RData")

library(dplyr)
library(stringr)
library(xlsx)

# Combine xData_test and xData_train into xData
xData <- rbind(xData_test,xData_train)

# Check to make sure xData looks good
tail(xData, n=1)

# Create new dataframe df by trimming xData to columns to:
#  - 1. subjectid
#  - 2. subjecttype
#  - 3. activity
#  - 4... columns with 'mean' or 'std' in the column name
data0 <- select(xData,
                subjectid,
                activity, 
                contains("mean", ignore.case=TRUE), 
                contains("std", ignore.case=TRUE))

# Confirm new dataframe's column names
print(names(data0))

# Confirm the data has not bee changed -
# I know the 4th variable has "mean" in the column name
print(identical(xData[,4],data0[,3]))

# Create a small subset of data0 sorted by 
# subject and activity, with only a few measurement
# columns, then write out so I can check them.

tmpdf = data0 %>%
  arrange(subjectid, activity) %>%
  select(subjectid,
    activity,
    tBodyAccmeanX,
    tBodyAccmeanY,
    tBodyAccmeanZ)

write.xlsx(tmpdf, file="subjectSortedData.xlsx")

# Calculate mean of selected measurement columns in data0
# grouped by subjectid and activity
byIdAndActivity <- data0 %>% 
  group_by(subjectid, activity) %>%
  summarise_each(funs(mean))

# Output file of resultant table so I can check
# the results in Excel against a subset of grouped data0
# records I have generated earlier, where I had
# manually calculated the grouped means for
# a few columns.
# I want to verify these mean values agree.
write.xlsx(byIdAndActivity, file="MeansByIdAndActivity.xlsx")
write.table(byIdAndActivity,
  file="MeansByIdAndActivity.txt",
  sep=" ",
  row.names=FALSE,
  col.names=TRUE)

# Save current workspace
print("Saving current workspace in 'run_analysis.RData'")
save(list = ls(all = TRUE), file = "run_analysis.RData")

