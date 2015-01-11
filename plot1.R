
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
  # formatting dates as Date
  february$Date <- as.Date(levels(february$Date), "%d/%m/%Y")[february$Date]
}

plot1 <- function() {
  library(datasets);
  png(file = "plot1.png", width = 480, height = 480, units = "px");
  hist(february$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", col = "red");
  dev.off();
}
