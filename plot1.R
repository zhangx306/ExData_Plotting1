##############################
# Coursera EDA
# Week 1: Plotting Project
##############################

rm( list = ls() )

library(dplyr)

# download zip file and unzip files
if ( !file.exists("Project_Wk1.zip")) {
  url_zip <- "https://archive.ics.uci.edu/ml/machine-learning-databases/00235/household_power_consumption.zip"
  download.file(url_zip, "Project_Wk1.zip")
}

if (!file.exists("UCI HAR Dataset")) { 
  unzip("Project_Wk1.zip") 
}

# read feature names and activity labels, keep only 2007-02-01 and 2007-02-02
data_all<- read.csv("./household_power_consumption.txt", sep = ";", header = TRUE)

data_twoDay <- data_all[data_all$Date %in% c("1/2/2007", "2/2/2007"), ]

# convert Date and Time to date format
data_twoDay$datetime <- paste(data_twoDay$Date, data_twoDay$Time)
data_twoDay$datetime <- strptime(data_twoDay$datetime, "%d/%m/%Y %H:%M:%S")

# remove the two cols that no longer needed
data_twoDay <- select(data_twoDay, -Date, -Time)


############################################
# Plot 1: Histogram of Global Active Power
############################################
# Change the col class from factor to numeric
data_twoDay$Global_active_power <- as.numeric(as.character(data_twoDay$Global_active_power))

par(mfrow = c(1,1))
hist(data_twoDay$Global_active_power, breaks = 16,
     col = "red", xlim = c(0,6), ylim = c(0,1200),
     main = "Global Active Power", xlab = "Global Active Power (kilowatts)", xaxt = "n")
axis(1, at=seq(0, 6, by=2), labels=c("0","2", "4", "6") )
dev.copy(png, file = "plot1.png", width = 480, height = 480, units = "px")
dev.off()
