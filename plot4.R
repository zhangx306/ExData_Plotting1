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
# Plot 4: Multi-frame plotting
############################################
par(mfcol = c(2,2))

# c(1,1)
# Change the col class from factor to numeric
data_twoDay$Global_active_power <- as.numeric(as.character(data_twoDay$Global_active_power))

plot(x = data_twoDay$datetime, y = data_twoDay$Global_active_power,
     xlab = "", ylab = "Global Active Power", type = "l")

# c(1,2)
# Change the col class from factor to numeric
data_twoDay$Sub_metering_1<- as.numeric(as.character(data_twoDay$Sub_metering_1))
data_twoDay$Sub_metering_2<- as.numeric(as.character(data_twoDay$Sub_metering_2))
data_twoDay$Sub_metering_3<- as.numeric(as.character(data_twoDay$Sub_metering_3))

plot(x = data_twoDay$datetime, y = data_twoDay$Sub_metering_1, type = "l", col = "black", 
     ylab = "Energy sub metering", xlab = "" )
lines(x = data_twoDay$datetime, y = data_twoDay$Sub_metering_2, type = "l", col = "red" )
lines(x = data_twoDay$datetime, y = data_twoDay$Sub_metering_3, type = "l", col = "blue" )
legend("topright",c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c("black", "red", "blue"), lty=rep(1,3), cex = 0.75, 
       bty = "n", y.intersp=0.5)

# c(2,1)
# Change the col class from factor to numeric
data_twoDay$Voltage<- as.numeric(as.character(data_twoDay$Voltage))

plot(x = data_twoDay$datetime, y = data_twoDay$Voltage, type = "l",  col = "black",
     ylab = "Voltage", xlab = "datetime")

# c(2,2)
# Change the col class from factor to numeric
data_twoDay$Global_reactive_power<- as.numeric(as.character(data_twoDay$Global_reactive_power))

with(data_twoDay, plot(x = datetime, y = Global_reactive_power, type = "l", col = "black"))

dev.copy(png, file = "plot4.png", width = 480, height = 480, units = "px")
dev.off()

