# This script will download a zipped data file from a url.
# This script will:
#   1. Ask you for the name of the data subjectory you want to create.
#   2. Create a data folder if it does not already exist.
#   3. Change the workspace to the data subdirectory.
#   4. Ask you for the url to retrieve the project data.
#   5. Download the data to the data subdirectory.
#   6. Unzip the downloaded data.
#   7. Print the names of extracted files in the
#      unzipped subdirectory
# NOTE: Your current workspace should be 'project'
#       if not, please manually set your workspace to this.
#       The intended folder structure is:
#        project dir > data dir > unzipped files dir

print("Current working directory: ")
getwd()

# Get name of data directory
print("\n)
  The data direcotry will be created if it does not
  exist already. \n
  The data directory will be one level DOWN from
  your current direcotry.\n")
dataDir <- readline("Enter data directory name: ")

# Create directory if it does not exist
dataDir <- paste(getwd(),"/",dataDir,sep="")
if (!file.exists(dataDir)) {
  dir.create(dataDir)
}

# Set workspace to data directory
setwd(dataDir)
print(getwd())

zipfile <- "data.zip"

# Dowload zip file and record date if it does not already exist
# Get URL to download file
if (!file.exists(zipfile)) {
  fileUrl <- readline("Enter URL to download file.
  NOTE: Do NOT enclose with quotes \"\":")
  download.file(fileUrl, destfile=zipfile, method="curl")
  dateDownloaded <- date()
  print(paste(zipfile, "file downloaded on: ",dateDownloaded))
}

# Extract file
print("The next step will extract the zipped data file")
print("Previously extracted data, if any, will be overwritten")
unzip(zipfile, list=TRUE, overwrite=TRUE)

print("Finish extracting file(s)")
setwd("../")
print("Workspace has been reset to the project dir.")
print("Saving workspace to file 'run_analysis.RData'")
save(list = ls(all = TRUE), file = "run_analysis.RData")
print("Type 'q()' without the quote to exist R")
