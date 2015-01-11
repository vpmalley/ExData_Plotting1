
download <- function() {
  # downloading, unzipping files
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "exdata_data_household_power_consumption.zip", method = "curl");
  unzip("exdata_data_household_power_consumption.zip");
}

loadData <- function() {
  # loading the file in R
  t <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?");
  # subsetting the data to keep only the data for the 2 first days of February
  february <- t[t$Date=="1/2/2007" | t$Date=="2/2/2007",];
  # formatting date and time as Date
  febDate <- as.character(levels(february$Date))[february$Date];
  febTime <- as.character(levels(february$Time))[february$Time];
  february$DateTime <- strptime(paste(february$Date, febTime), "%d/%m/%Y %H:%M:%S");
  
}

plot2 <- function() {
  library(datasets);
  png(file = "plot2.png", width = 480, height = 480, units = "px");
  with(february, plot(DateTime, Global_active_power, xlab = "", ylab = "Global Active Power (kilowatts)", pch = "." ));
  lines(february$DateTime, february$Global_active_power);
  dev.off();
}
